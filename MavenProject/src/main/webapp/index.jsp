<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MEDIFLOW</title>

<link rel="stylesheet" href="/css/common.css" />
<link rel="stylesheet" href="/css/index.css" />

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</head>
<body>

	<div id="wrap">
		<jsp:include page="components/header.jsp" />
		<main class="main">
			<div class="content">
				<p>
					반갑습니다! <br />
					<span>메디플로우</span>입니다
				</p>
				<div class="link">
					<a href="/member/login.jsp">로그인</a>
					<a href="/member/memberRegister.jsp">회원가입</a>
				</div>
			</div>
		</main>
	</div>

</body>
</html>