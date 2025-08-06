<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link rel="stylesheet" href="/css/common.css" />
<link rel="stylesheet" href="/css/memberRegister.css" />

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	$(() => {
		// 폰넘버 유효성 검사
		const $phone = $('#phone');
	  // 초기값 설정
	  $phone.val('010-');
	  // 포커스 시 커서 위치 조정
	  $phone.on('focus', function () {
	    const val = $(this).val();
	    if (!val.startsWith('010-')) {
	      $(this).val('010-');
	    }
	    // 커서 위치를 맨 끝으로 이동
	    setTimeout(() => {
	      this.setSelectionRange(this.value.length, this.value.length);
	    }, 0);
	  });
	  // 입력 시 하이픈 자동 삽입
	  $phone.on('input', function () {
	    let val = $(this).val();
	    // 숫자만 추출
	    let numeric = val.replace(/[^0-9]/g, '');
	    // '010'이 없으면 무조건 앞에 추가
	    if (!numeric.startsWith('010')) {
	      numeric = '010' + numeric;
	    }
	    // 010 제외한 나머지만 추출
	    let rest = numeric.substring(3, 11); // 최대 8자리
	    // 하이픈 포함한 최종 포맷
	    let formatted = '010';
	    if (rest.length > 0 && rest.length <= 4) {
	      formatted += '-' + rest;
	    } else if (rest.length > 4) {
	      formatted += '-' + rest.substring(0, 4) + '-' + rest.substring(4);
	    }
	    $(this).val(formatted);
	  });		  
		
		// 나이 입력 필드 유효성 검사
		$('#age').on('input', function() {
			let value = $(this).val().replace(/[^0-9]/g, ''); // 숫자 이외의 문자 제거
			
			if (value === '' || isNaN(value)) {
				// 입력값이 비어있거나 숫자가 아니면 0으로
				$(this).val('');
				return;
			}
			
			// 입력값을 숫자로
			let age = parseInt(value, 10);
			
			// 나이가 0보다 작거나 99보다 크면 범위를 벗어난 값으로
			if (age < 0) {
				$(this).val('0');
			} else if (age > 99) {
				$(this).val('99');
			} else {
				$(this).val(age); // 유효한 값은 그대로
			}
		});
		
		// 임시
		$('#memberRegister').on('click', function() {
			window.location.href = "/index.jsp";		
		})
	});
</script>

<title>MEDIFLOW</title>
</head>
<body>

	<div id="wrap">
		<jsp:include page="/components/header.jsp" />
		<main class="main">
			<div class="container">
				<form action="" method="post">
					<input type="text" name="username" id="username" placeholder="이름을 입력해주세요." required autocomplete="off" />
					<input type="text" name="age" maxlength="2" id="age" placeholder="나이" required autocomplete="off" />
					<input type="text" name="userid" id="userid" placeholder="아이디를 입력해주세요." required autocomplete="off" />
					<input type="password" name="password" id="password" maxlength="8" placeholder="비밀번호를 입력해주세요." required autocomplete="off" />
					<input type="text" name="phone" id="phone" placeholder="전화번호를 입력해주세요." required autocomplete="off" />
					<div class="registerbtn">
						<button type="submit" id="memberRegister">회원가입</button>
					</div>
				</form>
			</div>
		</main>
	</div>

</body>
</html>