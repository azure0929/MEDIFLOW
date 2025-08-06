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
<script>
$(function(){
	
});//ready
</script>
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
			<button class="dash-menu-active" onclick="">회원연령별 예약통계</button>
			<button class="dash-menu" onclick="">지역별 진료과목 예약 통계</button>
			<button class="dash-menu" onclick="">진료과별 연령대 예약 통계</button>
		</div>
		<div class="canvas-container">
			<canvas id="chart-canvas"></canvas>
		</div>		
	</div>
</div>
</body>
<script>
//Age 차트
const ageCtx=$('#chart-canvas');
const ageData = {
		  labels: [
		    '20대',
		    '30대',
		    '40대',
		    '50대',
		    '60대 이상'
		  ],
		  datasets: [{
		    label: '연령대별 이용객 데이터 수',
		    data: [1500, 2500, 3000, 4500, 6000],
		    backgroundColor: [
		      '#FF6B8A',
		      '#25CB8B',
		      '#F2C94C',
		      '#C5CAE9',
		      '#568BFF'
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
					text: 'Age Comparison',
			       	font: {
    	 				family: 'Inria Serif, serif',  // ← 폰트 패밀리
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
new Chart(ageCtx,ageConfig);

//Chart.js 예
/* const revenueCtx = $('#chart-canvas');
const revenueData = {
  labels: [
    'January','February','March','April','May','June',
    'July','August','September','October','November','December'
  ],
  datasets: [
    {
      type: 'bar',
      label: '매출액',
      data: [35000, 45000, 25000, 35000, 55000, 60000, 75000, 85000, 45000, 55000, 35000, 65000],
      backgroundColor: '#D6DAF6',
      borderWidth: 2,
      borderRadius: 10,
      yAxisID: 'y',
      order:2,
    },
    {
      type: 'line',
      label: '예약건수',
      data: [250, 350, 150, 250, 450, 500, 650, 750, 350, 450, 250, 550],
      backgroundColor:  '#FF6B8A',
      borderColor: '#FF6B8A',
      borderWidth: 2,
      pointRadius: 4,
      yAxisID: 'y1',
      order:1,
    }
  ]
};

const revenueConfig = {
  data: revenueData,
  options: {
    maintainAspectRatio: false,
    responsive: true,
    scales: {
      x: {
        ticks: {
    	  autoSkip: false,
          maxRotation: 45,
          minRotation: 45,
          font: {
            size: 10
          }
        }
      },
      y: {
        position: 'left',
        ticks: {
          callback: value => '$' + value.toLocaleString()
        }
      },
      y1: {
        position: 'right',
       	min : 0,
        max :1000,
        grid: {
          drawOnChartArea: false
        }
      }
    },
    plugins: {
      legend: {
        position: 'top',
      },
      title: {
        display: true,
        text: 'Monthly revenue',
        font: {
				family: 'Inria Serif, serif',  // ← 폰트 패밀리
	            weight: '700',                 // ← 굵기 (또는 'bold')
	            style: 'italic',
       		size: 30,
       		color : '#3A3A3A',
       		position: 'top',
        },
      },
      tooltip: {
        callbacks: {
          label: ctx => {
            const value = ctx.parsed.y;
            const label = ctx.dataset.label;
            // 매출일 경우 달러표시, 예약건수는 단순 숫자
            return label === '매출액'
              ? `${label}: $${value.toLocaleString()}`
              : `${label}: ${value.toLocaleString()}건`;
          }
        }
      },
      datalabels: {
        display: false
      }
    }
  }
};

new Chart(revenueCtx, revenueConfig); */
</script>
</html>