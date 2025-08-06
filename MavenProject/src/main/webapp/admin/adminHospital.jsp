<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="activeMenu" value="member" scope="request"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>

<link rel="stylesheet" href="/css/common.css" />
<link rel="stylesheet" href="/css/adminHospital.css" />

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
/* h1 {
	color: var(--primary-color);
} */

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
			<button id="hospital-register">등록</button>
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
									<button id="hospital-update">수정</button>
									<button id="hospital-delete">삭제</button>
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
</body>
</html>