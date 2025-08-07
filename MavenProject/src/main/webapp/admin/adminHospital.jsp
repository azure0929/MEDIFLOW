<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="activeMenu" value="hospital" scope="request"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>

<link rel="stylesheet" href="/css/common.css" />
<link rel="stylesheet" href="/css/adminHospital.css" />

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<div class="wrapper">
 <%-- 사이드바 include --%>
    <jsp:include page="/components/sidebar.jsp" />
	<div class="main">
		<div class="top-bar">
			<div class="logout"><a href="/logout">로그아웃</a></div>
		</div>
		<form class="filter-search" action="/admin/searchHospital" method="get">
			<div class="filter-search">
				<select id="searchKey">
					<option value="">선택하세요</option>
					<option value="hDepartment">진료과</option>
					<option value="hTitle">병원이름</option>
					<option value="hAddress">주소</option>
				</select> 
				<input type="text" id="searchValue" placeholder="검색어 입력" />
				<button><img src="/img/search.webp"></button>
			</div>
		</form>
		<div class="register-container">
			<button id="hospital-register"><a href="/admin/adminHospitalRegister.jsp">등록</a></button>
		</div>
		<div class="table-container">
			<table>
				<thead>
					<tr>
						<th>NO</th>
						<th>병원이름</th>
						<th>진료과목</th>
						<th>병원주소</th>
						<th>연락처</th>
						<th>비고</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="hospital" items="${hospitalList}">
						<tr>
							<td>${hospital.hNum}</td>
							<td>${hospital.hTitle}</td>
							<td>${hospital.hDepartment}</td>
							<td>${hospital.hAddress}</td>
							<td>${hospital.hTel}</td>
							<td>
								<div class="note-container">
									<button data-hNum="${hospital.hNum}" class="hospital-update">수정</button>
									<button data-hNum="${hospital.hNum}" class="hospital-delete">삭제</button>
								</div>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>

		<div class="pagination">
			<c:forEach var="i" begin="1" end="${pageCount}">
			 <a href="/admin/searchAllHospital?pageNum=${i}" class="page-link ${i == currentPage ? 'active' : ''}">
		       ${i}
		    </a>
			</c:forEach>
		</div>
	</div>
</div>

<!-- 모달창   -->
<div id="myModal" class="modal" style="display: none;">
	<div class="modal-content">
		<div class="modal-title">
			<c:if test="${not deleted}">
				<p>정말로 삭제하시겠습니까?</p>
			</c:if>
			<c:if test="${deleted}">
				<p>삭제 되었습니다.</p>
			</c:if>
		</div>
		<div class="modal-button">
			<c:if test="${not deleted}">
				<button id="confirmYes">확인</button>
				<button id="confirmNo">취소</button>
			</c:if>
			<c:if test="${deleted}">
				<button id="confirmNo">닫기</button>	
			</c:if>
		</div>
	</div>
</div>
</body>
<script>
$(function () {
    $('#searchKey').on('change', function () {
      const selectedKey = $(this).val();
      $('#searchValue').attr('name', selectedKey);
    });
  });


let hNum=null;
$('.hospital-update').on('click',function(){
	let hNum = $(this).data('hnum');
	location.href = '/admin/hospitalUpdatePage?hNum='+hNum;
});

$('.hospital-delete').on('click',function(){
	let hNum = $(this).data('hnum');
	$('#myModal').show();
	
	$('#confirmYes').click(function(){
		location.href = '/admin/hospitalDelete?hNum='+hNum;
		//controller 에서 return "redirect:/admin/adminHospital.jsp?deleted=true";
	})

});

$('#confirmNo').click(function(){
    $('#myModal').hide(); // 모달 닫기
  });
</script>
</html>