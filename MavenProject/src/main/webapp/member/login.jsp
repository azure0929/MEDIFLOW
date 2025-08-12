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
	  function validateInput(inputElement) {
      const value = $(inputElement).val().trim();
      const errorMessageDiv = $(inputElement).closest('.input-group').find('.error-message');

      if (value) {
          errorMessageDiv.remove();
          $(inputElement).removeClass('input-error');
          return true;
      } else {
          if (errorMessageDiv.length === 0) {
              const message = $(inputElement).attr('placeholder');
              $(inputElement).closest('.input-group').append('<div class="error-message" style="color: #ff0000; font-size: 14px; margin-top: 5px;">' + message + '</div>');
          }
          $(inputElement).addClass('input-error');
          return false;
      }
	  }
	
	  $('#userid, #password').on('input', function() {
	      validateInput(this);
	  });
	
	  $('#login').on('click', function(e) {
      e.preventDefault();
      const isIdValid = validateInput('#userid');
      const isPasswordValid = validateInput('#password');

      if (isIdValid && isPasswordValid) {
          $('#loginForm').submit();
      }
	  });
	});
</script>

<title>MEDIFLOW</title>
</head>
<body>

	<div class="wrap">
		<jsp:include page="/components/header.jsp" />
		<main class="main">
			<div class="container">
				<form action="/login" method="post" id="loginForm">
			    <div class="logininfo">
		        <div class="input-group">
	            <input id="userid" type="text" name="mId" placeholder="아이디를 입력해주세요." autocomplete="off" />
	        	</div>
		        <div class="input-group">
		            <input id="password" type="password" name="mPassword" placeholder="비밀번호를 입력해주세요." autocomplete="off" />
		        </div>
		   		</div>
			    <div class="loginbtn">
		        <button type="submit" id="login">로그인</button>
			    </div>
				</form>
			</div>
		</main>
	</div>

</body>
</html>