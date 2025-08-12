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
		
		// 아이디 실시간 유효성 검사
		$('#userid').on('input', function() {
			const $this = $(this);
			const userId = $this.val();
			
			if (userId.length > 0 && (userId.length < 4 || userId.length > 30)) {
				$this.addClass('input-error');
				$this.after('<span class="error-message">아이디는 최소 4자리 이상 최대 30자 이내로 입력해주세요.</span>');
			} else {
				$this.removeClass('input-error');
			}
		});

		// 비밀번호 실시간 유효성 검사
		$('#password').on('input', function() {
			const $this = $(this);
			const password = $this.val();
			
			if (password.length > 0 && (password.length < 4 || password.length > 30)) {
				$this.addClass('input-error');
				$this.after('<span class="error-message">비밀번호는 최소 4자리 이상 최대 30자 이내로 입력해주세요.</span>');
			} else {
				$this.removeClass('input-error');
			}
		});
		
		// 회원가입
		$('#memberRegister').on('click', function(e) {
			// 기본 폼 제출 방지
			e.preventDefault();
			
			// 이전에 표시된 모든 에러 메시지 제거 및 스타일 초기화
			$('.error-message').remove();
			$('.input-error').removeClass('input-error');

			const rawAge = parseInt($('#age').val(), 10);
	    let mAge;
			const userId = $('#userid').val();
			const password = $('#password').val();
			
			// 유효성 검사 플래그
			let isValid = true;
			
			// 아이디 길이 유효성 검사
			if (userId.length < 4 || userId.length > 30) {
				$('#userid').addClass('input-error');
				$('#userid').after('<span class="error-message">아이디는 최소 4자리 이상 최대 30자 이내로 입력해주세요.</span>');
				isValid = false;
			}
			
			// 비밀번호 길이 유효성 검사
			if (password.length < 4 || password.length > 30) {
				$('#password').addClass('input-error');
				$('#password').after('<span class="error-message">비밀번호는 최소 4자리 이상 최대 30자 이내로 입력해주세요.</span>');
				isValid = false;
			}
			
			if (!isValid) {
				return;
			}
			
			// 나이 검사
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
	      mId: userId,
	      mName: $('#username').val(),
	      mPassword: password,
	      mPhone: $('#phone').val(),
	      mAge: mAge
	    };

	    if (!member.mId || !member.mPassword || !member.mName || !member.mPhone || !member.mAge) {
	      alert("모든 필드를 입력해주세요.");
	      return;
	    }
			
			// 아이디 중복 확인 (서버 통신)
			$.ajax({
				url: '/checkUserId', // 아이디 중복 확인을 위한 서버 엔드포인트
				type: 'POST',
				data: { mId: member.mId },
				success: function(response) {
					if (response.isDuplicate) { // 서버에서 중복 여부를 JSON으로 반환한다고 가정
						$('#userid').addClass('input-error');
						$('#userid').after('<span class="error-message">이미 등록된 아이디입니다.</span>');
					} else {
						// 중복이 아니면 폼 제출 로직 실행
						// mAge 값을 숨겨서 보냄
						$('<input>').attr({
							type: 'hidden',
							name: 'mAge',
							value: mAge
						}).appendTo('#memberRegisterForm');

						// 기존 age input 제거 (중복 방지)
						$('#age').remove();
						
						// 모든 유효성 검사 통과 후 폼 제출
						$('#memberRegisterForm').submit();
					}
				},
				error: function() {
					alert('서버 오류가 발생했습니다. 다시 시도해주세요.');
				}
			});
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
					<div class="memberinfo">
						<div><input type="text" name="mName" id="username" placeholder="이름을 입력해주세요." required autocomplete="off" /></div>
						<div><input type="text" name="mAge" maxlength="2" id="age" placeholder="1~99" required autocomplete="off" /></div>
						<div><input type="text" name="mId" id="userid" placeholder="아이디를 입력해주세요." required autocomplete="off" /></div>
						<div><input type="password" name="mPassword" id="password" placeholder="비밀번호를 입력해주세요." required autocomplete="off" /></div>
						<div><input type="text" name="mPhone" id="phone" placeholder="전화번호를 입력해주세요." required autocomplete="off" /></div>
					</div>
					<div class="registerbtn">
						<button type="submit" id="memberRegister">회원가입</button>
					</div>
				</form>
			</div>
		</main>
	</div>

</body>
</html>