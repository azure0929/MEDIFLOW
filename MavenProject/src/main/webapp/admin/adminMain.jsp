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
<link rel="stylesheet" href="/css/adminMain.css" />

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
    <jsp:include page="/admin/sidebar.jsp" />

	<div class="main">
		<div class="top-bar">
			<div class="logout"><a href="#">로그아웃</a></div>
		</div>
		<form class="filter-search" action="admin/searchMember" method="get">
			<div class="filter-search">
				<select>
					<option>회원</option>
					<option>이름</option>
					<option>연락처</option>
					<option>연령대</option>
				</select> 
				<input type="text" placeholder="검색어 입력" />
				<button><img src="/img/search.webp"></button>
			</div>
		</form>
		<div class="table-container">
			<table>
				<thead>
					<tr>
						<th>NO</th>
						<th>아이디</th>
						<th>이름</th>
						<th>연락처</th>
						<th>연령대</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="member" items="${memberList}">
						<tr>
							<td>${member.mNum}</td>
							<td>${member.mId}</td>
							<td>${member.mName}</td>
							<td>${member.mPhone}</td>
							<td>${member.mAge}</td>
						</tr>
					</c:forEach>
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