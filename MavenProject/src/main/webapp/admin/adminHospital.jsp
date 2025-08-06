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
			<div class="logout"><a href="#">로그아웃</a></div>
		</div>
		<form class="filter-search" action="admin/searchMember" method="get">
			<div class="filter-search">
				<select>
					<option>병원</option>
					<option>진료과</option>
					<option>병원이름</option>
					<option>지역구</option>
				</select> 
				<input type="text" placeholder="검색어 입력" />
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
					<%-- <c:forEach var="hospital" items="${hospitalList}"> --%>
						<tr>
							<td>${hospital.hNum}1</td>
							<td>${hospital.hTitle}스마일병원</td>
							<td>${hospital.hDepartment}이비인후과</td>
							<td>${hospital.hAddress}서울시 종로구 새문안로 89 정우빌딩 8층</td>
							<td>${hospital.hTel}02-734-3999</td>
							<td>
								<div class="note-container">
									<button data-hNum="${hospital.hNum}" class="hospital-update">수정</button>
									<button data-hNum="${hospital.hNum}" class="hospital-delete">삭제</button>
								</div>
							</td>
						</tr>
					<%-- </c:forEach> --%>
				</tbody>
			</table>
		</div>

		<div class="pagination">
			<a href="#"><img src="/img/leftArrow.webp"></a> <a class="active" href="#">1</a> <a href="#">2</a>
			<a href="#">3</a> <a href="#">4</a> <a href="#">5</a> <a href="#"><img src="/img/rightArrow.webp"></a>
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
$('.hospital-update').on('click',function(){
	let hNum = $(this).data('hnum');
	location.href = 'admin/hospitalUpdate?hNum='+hNum;
});

$('.hospital-delete').on('click',function(){
	$('#myModal').show();
	
	$('#confirmYes').click(function(){
		let hNum = $(this).data('hnum');
		location.href = 'admin/hospitalDelete?hNum='+hNum;
		//controller 에서 return "redirect:/admin/adminHospital.jsp?deleted=true";
	})

});

$('#confirmNo').click(function(){
    $('#myModal').hide(); // 모달 닫기
  });
</script>
</html>