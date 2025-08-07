<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link rel="stylesheet" href="/css/common.css" />
<link rel="stylesheet" href="/css/login.css" />

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	$(() => {
		$('#login').on('click', function() {
			
			$(".error-message").remove();
			
			const mId = $("#userid").val();
			const mPassword = $("#password").val();
			
			if (!mId) {
				$("#userid").after('<div class="error-message" style="color: #ff0000; font-size: 14px;">아이디를 입력해주세요.</div>');
				return;
			}
			
			if (!mPassword) {
				$("#password").after('<div class="error-message" style="color: #ff0000; font-size: 14px;">비밀번호를 입력해주세요.</div>');
				return;
			}
			
			$('#loginForm').submit();
		})
	})
</script>

<title>MEDIFLOW</title>
</head>
<body>

	<div class="wrap">
		<jsp:include page="/components/header.jsp" />
		<main class="main">
			<div class="container">
				<form action="/login" method="post" id="loginForm">
					<input id="userid" type="text" name="mId" placeholder="아이디를 입력해주세요." required autocomplete="off" />
    			<input id="password" type="password" name="mPassword" placeholder="비밀번호를 입력해주세요." required autocomplete="off" />
					<div class="loginbtn">
						<button type="submit" id="login">로그인</button>
					</div>
				</form>
			</div>
		</main>
	</div>

</body>
</html>