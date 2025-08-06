<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="/css/sidebar.css" />

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

<div class="sidebar">
    <div class="logo">
		<img src="/img/logo.webp" alt="logo" />
	</div>
    <div class="menu">
        <div class="menu-item">
            <a href="#" class="${activeMenu eq 'member' ? 'active' : ''}">
                <img src="${activeMenu eq 'member' ? '/img/memManagerActive.webp' : '/img/memManager.webp'}">회원관리
            </a>
        </div>
        <div class="menu-item">
            <a href="#" class="${activeMenu eq 'hospital' ? 'active' : ''}">
                <img src="${activeMenu eq 'hospital' ? '/img/hosManagerActive.webp' : '/img/hosManager.webp'}">병원관리
            </a>
        </div>
        <div class="menu-item">
            <a href="#" class="${activeMenu eq 'dashboard' ? 'active' : ''}">
                <img src="${activeMenu eq 'dashboard' ? '/img/dashManagerActive.webp' : '/img/dashManager.webp'}">통계보드
            </a>
        </div>
    </div>
</div>
</body>
</html>