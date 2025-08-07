<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="activeMenu" value="dashboard" scope="request"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>

<link rel="stylesheet" href="/css/common.css" />
<link rel="stylesheet" href="/css/adminDashboard.css" />

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- Chart.js (반드시 있어야 함!) -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<link href="https://fonts.googleapis.com/css2?family=Pretendard&display=swap" rel="stylesheet">
<style>
  canvas {
    font-family: 'Pretendard', 'Noto Sans KR', 'Malgun Gothic', sans-serif !important;
  }
</style>
</head>
<body>
<div class="wrapper">
 <%-- 사이드바 include --%>
    <jsp:include page="/components/sidebar.jsp" />
	<div class="main">
		<div class="top-bar">
			<div class="logout"><a href="#">로그아웃</a></div>
		</div>
		<div class="dash-menu-bar">
			<button id="ageChart" class="dash-menu-active" onclick="ageChart()">회원연령별 예약통계</button>
			<button id="addressChart" class="dash-menu" onclick="addressChart()">지역별 진료과목 예약 통계</button>
			<button id="departmentChart" class="dash-menu" onclick="departmentChart()">진료과별 연령대 예약 통계</button>
		</div>
		<div class="canvas-container">
			<canvas id="chart-canvas"></canvas>
		</div>		
	</div>
</div>
</body>
<script>
let addressChartInstance = null;
const ageChart = function(){
	$('#ageChart').attr('class','dash-menu-active');
	$('#addressChart').attr('class','dash-menu');
	$('#departmentChart').attr('class','dash-menu');
	$.ajax({
		type : 'get',
		url : '/admin/ageChart',
		dataType : 'json',
		success : function(result){
		  if (addressChartInstance) {
			    addressChartInstance.destroy();
			  }
			console.log(typeof result);
			const ageDatas = result;
			const labels = Object.keys(ageDatas);
			const values = Object.values(ageDatas);
			const ageCtx=$('#chart-canvas');
			const ageData = {
					  labels: labels,
					  datasets: [{
					    label: '연령대별 이용객 데이터 수',
					    data: values,
					    backgroundColor: [
							'#FF6B8A',
							'#25CB8B',
							'#F2C94C',
							'#C5CAE9',
							'#568BFF', 
							'#C5CAE9', 
							'#FFB86C', 
							'#6A67CE', 
							'#00BFA6', 
							'#FFD166', 
							'#EF476F'
					    ],
					   	hoverOffset: 25
					  }]
			};
			const ageConfig = {
					  type: 'doughnut',
					  data: ageData,
					  options: {
						  	maintainAspectRatio: false,
						  	responsive: true,
						  	radius : '80%',   // <-- 핵심, 기본은 100%
						    cutout: '60%',           // 도넛 두께 조절
						    plugins: {
						      legend: { 
						   			display: true,
				    	 			position: 'top',
				    	 			labels:{
				    	 			font: {
				    	 	            size: 12,
				    	 	          },
				    	 	        boxWidth: 20,
				    	 	        boxHeight: 20
				    	 			}
						      },   // 범례 숨기기(원하면 true)
						      tooltip: { enabled: true },  // 툴팁 끄기(선택)
						      datalabels: {
						        // ① 표시할 내용: 퍼센트로 변환
						        formatter: (value, ctx) => {
						          const total = ctx.chart._metasets[0].total;      // v4
						          const pct   = (value / total * 100).toFixed(0);
						          return pct + '%';
						        },
						        // ② 위치·스타일
						        anchor: 'end',        // 밖으로 뺄 때 'end'
						        align: 'end',         // 선 밖 정렬: 'center'면 가운데
						        offset: 2,            // 원에서 얼마나 떨어질지
						        font: { weight: 'bold', size: 14 },
						        color: '#455A64'      // 글자색
						      },
							 title: {
								display: true,
								text: '연령대별 이용객 예약 건수',
						       	font: {
			    	 				family: 'Pretendard',  // ← 폰트 패밀리
			    	 	            weight: '700',                 // ← 굵기 (또는 'bold')
			    	 	            style: 'italic',
						       		size: 30,
						       		color : '#3A3A3A',
						       		position: 'top', 
						       	}
							 }
						      
						    },

					}
			};
			addressChartInstance = new Chart(ageCtx, ageConfig);
		},//success
		
		error : function(request, status, error) { // 결과 에러 콜백함수
		        console.log(error)
		    }
	})//ajax
	
}

const addressChart = function(){
	$('#ageChart').attr('class','dash-menu');
	$('#addressChart').attr('class','dash-menu-active');
	$('#departmentChart').attr('class','dash-menu');
	$.ajax({
		type : 'get',
		url : '/admin/addressChart',
		dataType : 'json',
		success : function(result){
		  if (addressChartInstance) {
			    addressChartInstance.destroy();
			  }
			//const adrressCtx=$('#chart-canvas');
			const adrressCtx = document.getElementById('chart-canvas');
			const resultDatas = result;
			const districts = Object.keys(resultDatas);
			
			//maxValue
			let maxValue = 0;
			districts.forEach(district => {
			  const departments = resultDatas[district];
			  Object.values(departments).forEach(value => {
			    if (value > maxValue) {
			      maxValue = value;
			    }
			  });
			});
		    // 범례: 진료과 전체 모으기 (Set으로 중복 제거)
		    const departmentSet = new Set();
		    districts.forEach(district => {
		      const departments = Object.keys(resultDatas[district]);
		      departments.forEach(dep => departmentSet.add(dep));
		    });
		    const departments = Array.from(departmentSet); // ["치과", "이비인후과", ...]

		    // 각 진료과별 데이터셋 만들기
		    const colorPalette = 
		    	['#FF6B8A', '#25CB8B', '#F2C94C', '#568BFF', '#C5CAE9', 
		    	'#FFB86C', '#6A67CE', '#00BFA6', '#FFD166', '#EF476F'];
		    const datasets = departments.map((dep, idx) => {
		      return {
		        label: dep,
		        data: districts.map(district => resultDatas[district][dep] || 0),
		        backgroundColor: colorPalette[idx % colorPalette.length],
		        borderRadius: 8,
		        borderWidth: 1
		      };
		    });

		    const config = {
		      type: 'bar',
		      data: {
		        labels: districts,    // X축: 지역구
		        datasets: datasets    // 범례: 진료과별 막대
		      },
		      options: {
		        responsive: true,
		        maintainAspectRatio: false,
		        plugins: {
		          legend: {
		            position: 'top',
		          },
		          title: {
		            display: true,
		            text: '지역구별 진료과 예약 건수',
		            font: {
		              family: 'Pretendard',
		              size: 24,
		              weight: 'bold'
		            }
		          },
		          tooltip: {
		              callbacks: {
	            	  	title: function () {
	                      return '';
	                    },
		                label: function(ctx) {
	                	  const label = ctx.dataset.label || '';
	                	  const value = ctx.raw;
	                	  return label + ":" + value+"건";
		                }
		              }
		            }
		        },
		        scales: {
		          x: {
		            ticks: {
		              font: {
		                size: 12
		              }
		            }
		          },
		          y: {
		            beginAtZero: true,
		            max: maxValue + 5,
		            ticks: {
		              stepSize: 1
		            },
		            title: {
		              display: true,
		              text: '예약 건수'
		            }
		          }
		        }
		      }
		    };
		    addressChartInstance = new Chart(adrressCtx, config);
		},//success
		error : function(request, status, error) { // 결과 에러 콜백함수
	        console.log(error)
	    }
	});//ajax
}

const departmentChart = function(){
	$('#ageChart').attr('class','dash-menu');
	$('#addressChart').attr('class','dash-menu');
	$('#departmentChart').attr('class','dash-menu-active');
	$.ajax({
		type : 'get',
		url : '/admin/departmentChart',
		dataType : 'json',
		success : function(result){
		  if (addressChartInstance) {
			    addressChartInstance.destroy();
			  }
		  console.log(result);
			//const departmentCtx=$('#chart-canvas');
			const departmentCtx = document.getElementById('chart-canvas');
			const resultDatas = result;
			const departments = Object.keys(resultDatas);
			
			//maxValue
			let maxValue = 0;
			departments.forEach(department => {
			  const ages = resultDatas[department];
			  Object.values(ages).forEach(value => {
			    if (value > maxValue) {
			      maxValue = value;
			    }
			  });
			});
		    // 범례: 나이대 전체 모으기 (Set으로 중복 제거)
		    const ageSet = new Set();
		    departments.forEach(department => {
		      const ages = Object.keys(resultDatas[department]);
		      ages.forEach(dep => ageSet.add(dep));
		    });
		    const ages = Array.from(ageSet); // ["30대", "20대", ...]

		    // 각 나이대별 데이터셋 만들기
		    const colorPalette = 
		    	['#FF6B8A', '#25CB8B', '#F2C94C', '#568BFF', '#C5CAE9', 
		    	'#FFB86C', '#6A67CE', '#00BFA6', '#FFD166', '#EF476F'];
		    const datasets = ages.map((dep, idx) => {
		      return {
		        label: dep,
		        data: departments.map(department => resultDatas[department][dep] || 0),
		        backgroundColor: colorPalette[idx % colorPalette.length],
		        borderRadius: 8,
		        borderWidth: 1
		      };
		    });

		    const config = {
		      type: 'bar',
		      data: {
		        labels: departments,    // X축: 지역구
		        datasets: datasets    // 범례: 진료과별 막대
		      },
		      options: {
		        responsive: true,
		        maintainAspectRatio: false,
		        plugins: {
		          legend: {
		            position: 'top',
		          },
		          title: {
		            display: true,
		            text: '진료과별 연령대 예약 건수',
		            font: {
		              family: 'Pretendard',
		              size: 24,
		              weight: 'bold'
		            }
		          },
		          tooltip: {
		              callbacks: {
	            	  	title: function () {
	                      return '';
	                    },
		                label: function(ctx) {
	                	  const label = ctx.dataset.label || '';
	                	  const value = ctx.raw;
	                	  return label + ":" + value+"건";
		                }
		              }
		            }
		        },
		        scales: {
		          x: {
		            ticks: {
		              font: {
		                size: 12
		              }
		            }
		          },
		          y: {
		            beginAtZero: true,
		            max: maxValue + 5,
		            ticks: {
		              stepSize: 1
		            },
		            title: {
		              display: true,
		              text: '예약 건수'
		            }
		          }
		        }
		      }
		    };
		    addressChartInstance = new Chart(departmentCtx, config);
		},//success
		error : function(request, status, error) { // 결과 에러 콜백함수
	        console.log(error)
	    }
	});//ajax
}
</script>
</html>