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
		$('#age').on('input', function () {
	    let value = $(this).val().replace(/[^0-9]/g, '');
	    if (value === '') {
	      $(this).val('');
	      return;
	    }
	
	    const age = parseInt(value, 10);
	    if (isNaN(age) || age < 1 || age > 99) {
	      alert('1부터 99까지 숫자만 입력할 수 있습니다.');
	      $(this).val('');
	    } else {
	      $(this).val(age); // 숫자 그대로 유지
	    }
	  });
		
		// 회원가입
		$('#memberRegister').on('click', function() {
			const rawAge = parseInt($('#age').val(), 10);
	    let mAge;

	    if (isNaN(rawAge)) {
	      alert('나이를 입력해주세요.');
	      return;
	    }

	    if (rawAge >= 1 && rawAge <= 9) {
	      mAge = String(rawAge); // 1~9는 그대로
	    } else if (rawAge >= 10 && rawAge <= 99) {
	      const decade = Math.floor(rawAge / 10) * 10;
	      mAge = decade + '대'; // 10~99는 NN대
	    } else {
	      alert('나이는 1~99 사이로 입력해주세요.');
	      return;
	    }

	    const member = {
	      mId: $('#userid').val(),
	      mName: $('#username').val(),
	      mPassword: $('#password').val(),
	      mPhone: $('#phone').val(),
	      mAge: mAge
	    };

	    if (!member.mId || !member.mPassword || !member.mName || !member.mPhone || !member.mAge) {
	      alert("모든 필드를 입력해주세요.");
	      return;
	    }

	    // mAge 값을 숨겨서 보냄
	    $('<input>').attr({
	      type: 'hidden',
	      name: 'mAge',
	      value: mAge
	    }).appendTo('#memberRegisterForm');

	    // 기존 age input 제거 (중복 방지)
	    $('#age').remove();

	    $('#memberRegisterForm').submit();
		});
	});
</script>

<title>MEDIFLOW</title>
</head>
<body>

	<div id="wrap">
		<jsp:include page="/components/header.jsp" />
		<main class="main">
			<div class="container">
				<form action="/memberRegister" method="post" id="memberRegisterForm">
					<input type="text" name="mName" id="username" placeholder="이름을 입력해주세요." required autocomplete="off" />
					<input type="text" name="mAge" maxlength="2" id="age" placeholder="1~99" required autocomplete="off" />
					<input type="text" name="mId" id="userid" placeholder="아이디를 입력해주세요." required autocomplete="off" />
					<input type="password" name="mPassword" id="password" maxlength="8" placeholder="비밀번호를 입력해주세요." required autocomplete="off" />
					<input type="text" name="mPhone" id="phone" placeholder="전화번호를 입력해주세요." required autocomplete="off" />
					<div class="registerbtn">
						<button type="submit" id="memberRegister">회원가입</button>
					</div>
				</form>
			</div>
		</main>
	</div>

</body>
</html>