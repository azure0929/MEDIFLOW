<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link rel="stylesheet" href="/css/common.css" />
<link rel="stylesheet" href="/css/mypage.css" />

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
		
		
	  // 탭 별 내용 보이기/숨기기
		$('.modify').show();
		$('.reserveinfo').hide();
		
		// 탭 클릭 처리
	  $('.tabs .tab').on('click', function() {
	    $('.tabs .tab').removeClass('active');
	    $(this).addClass('active');

	    const index = $(this).index();

	    if (index === 0) {
	      $('.reserveinfo').fadeOut(200, () => {
	        $('.modify').fadeIn(300);
	      });
	    } else if (index === 1) {
	      $('.modify').fadeOut(200, () => {
	        $('.reserveinfo').fadeIn(300);
	      });
	    }
	  });

	  // 회원탈퇴 탭 클릭
	  $('.tabs li').eq(2).on('click', function() {
	    $('#withdrawModal').fadeIn(100);
	  });
	  // 탈퇴 취소
	  $('.cancelWithdraw').on('click', function() {
	    $('#withdrawModal').fadeOut(100);
	  });
	  // 탈퇴 확인
	  $('.confirmWithdraw').on('click', function() {
	    $('.modal-text').text('탈퇴 되었습니다.');
	    $('.modal-buttons').html('<button type="button" class="closeWithdraw">닫기</button>');
	  });
	  // 닫기 클릭 → index.jsp 이동
	  $(document).on('click', '.closeWithdraw', function() {
	    window.location.href = '/index.jsp';
	  });
	  
	  // 로그아웃 탭 클릭 임시
	  $('.tabs li').eq(3).on('click', function() {
		  $('#logoutModal').fadeIn(100);
	  });
	  // 로그아웃 모달 확인 버튼
	  $(document).on('click', '.confirmLogout', function() {
		  $('.modal-text').text('탈퇴 되었습니다.');
		  $('.modal-buttons').html('<button type="button" class="closeLogout">닫기</button>');
	  });
	  // 로그아웃 모달 닫기 버튼
	  $(document).on('click', '.closeLogout', function() {
		  $('#logoutModal').fadeOut(100);
		  window.location.href = '/index.jsp';
	  })
	  // 로그아웃 모달 취소 버튼
	  $(document).on('click', '.cancelLogout', function() {
		  $('#logoutModal').fadeOut(100);
	  })
	  
	  
		// 예약 수정 버튼 클릭
		/*
    $('.reservemodify').on('click', function(e) {
      e.preventDefault(); 
      // $.ajax를 사용하여 예약일자와 예약시간을 서버에 전송
      // 서버와 통신하는 로직이 없으므로 임시로 성공 로직만 실행
      $('#modifyModal').fadeIn(100);
      $('.modal-text-modify').text('정보가 수정되었습니다.');
    });
	  */
		
		// 예약 취소 버튼 클릭
		$('.reservecancle').on('click', function(e) {
      e.preventDefault(); 
      // $.ajax를 사용하여 예약일자와 예약시간을 서버에 전송
      // 서버와 통신하는 로직이 없으므로 임시로 성공 로직만 실행
      $('#reserveCancleModal').fadeIn(100);
    });
		// 예약 취소 모달 확인 버튼
		$(document).on('click', '.confirmreserveCancle', function() {
			$('.modal-text').text('예약이 취소 되었습니다.');
			$('.modal-buttons').html('<button type="button" class="closereservemodal">닫기</button>');
			$('.reservelist').remove();
		})
		// 예약 취소 모달 취소 버튼
		$(document).on('click', '.canclereserveCancle', function() {
			$('#reserveCancleModal').fadeOut(100);
		})
		// 예약 취소 모달 닫기 버튼
		$(document).on('click', '.closereservemodal', function() {
			$('#reserveCancleModal').fadeOut(100);
		})
		
	  
		// 닫기 버튼 클릭 시 버튼 구성 변경
    $(document).on('click', '.closeModify', function() {
      $('#modifyModal').fadeOut(100, () => {
        $('.reservation-buttons').fadeOut(200)
        $('.review-buttons').css('display', 'block');
      });
    });

    // '리뷰 작성' 버튼 클릭 시 리뷰 모달 열기
    $('.reviewbutton').on('click', function() {
      $('#reviewModal').fadeIn(100);
    });

    // 리뷰 항목 선택 시 스타일 변경
    $('.review-item').on('click', function() {
      // 모든 항목의 선택 해제
      $('.review-item').removeClass('selected');
      // 클릭된 항목만 선택
      $(this).addClass('selected');
    });

    // '제출' 버튼 클릭 시
    $('.submitReview').on('click', function() {
      const selectedReview = $('.review-item.selected').text();
      if (!selectedReview) {
          alert('리뷰를 선택해주세요.');
          return;
      }
      // $.ajax를 사용하여 선택된 리뷰 내용 서버에 전송
      // 서버와 통신하는 로직이 없으므로 임시로 성공 로직만 실행
      alert('리뷰가 성공적으로 제출되었습니다.');
      
      $('#reviewModal').fadeOut(100);
      
      $('.status-message').css('display', 'block');
      $('.reservation-buttons').css('display', 'none');
    });
	})
</script>

<title>MEDIFLOW</title>
</head>
<body>

	<div id="wrap">
		<jsp:include page="/components/header.jsp" />
		<main class="main">
			<div class="tabs">
				<ul>
					<li class="tab active"><a href="#none">회원정보수정</a></li>
					<li class="tab"><a href="#none">예약 내역</a></li>
					<li><a href="#none">회원탈퇴</a></li>
					<li><a href="#none">로그아웃</a></li>
				</ul>
			</div>
			<section class="modify">
				<p>
					비밀번호와 연락처를<br /> 수정해주세요.
				</p>
				<form action="" method="post">
					<input type="password" name="password" id="password" maxlength="8"
						placeholder="비밀번호를 입력해주세요." required autocomplete="off" /> <input
						type="text" name="phone" placeholder="전화번호를 입력해주세요."
						autocomplete="off" />
					<div class="modifybtn">
						<button type="submit">수정</button>
					</div>
				</form>
			</section>
			<section class="reserveinfo">
				<p>
					<span>홍길동</span>님의 예약 내역입니다.
				</p>
				<ul class="reservelists">
					<li class="reservelist">
						<div class="hospitalphoto">
							<img src="/img/hospital01.webp" alt="병원사진" />
						</div>
						<form class="reservecontent" action="" method="post">
							<div class="name hospitalinfo">
								<label>병원:</label> 
								<span>서울대학교 병원</span>
							</div>
							<div class="department hospitalinfo">
								<label>진료과:</label> 
								<span>정형외과</span>
							</div>
							<div class="reservedate hospitalinfo">
								<label>예약일자:</label> 
								<input type="text" name="reservedate" value="2025-07-08" />
							</div>
							<div class="reservetime hospitalinfo">
								<label>예약시간:</label>
								<input type="text" name="reservetime" value="오후" />
							</div>
							<div class="reservation-buttons">
								<!--<button type="button" class="reservemodify">예약 수정</button>-->
								<button type="button" class="reviewbutton">리뷰 작성</button>
								<button type="button" class="reservecancle">예약 취소</button>
							</div>
							<div class="status-message" style="display: none;">
								<span>진료 완료</span>
							</div>
						</form>
					</li>
				</ul>
			</section>
		</main>

		<!-- 탈퇴 모달 -->
		<div id="withdrawModal" class="modal">
			<div class="modal-content">
				<p class="modal-text">정말로 탈퇴 하시겠습니까?</p>
				<div class="modal-buttons">
					<button type="submit" class="confirmWithdraw">확인</button>
					<button type="button" class="cancelWithdraw">취소</button>
				</div>
			</div>
		</div>

		<!-- 예약 수정 모달 -->
		<!--
		<div id="modifyModal" class="modal">
			<div class="modal-content">
				<p class="modal-text-modify"></p>
				<div class="modal-buttons-modify">
					<button type="button" class="closeModify">닫기</button>
				</div>
			</div>
		</div>
		-->

		<!-- 리뷰 모달 -->
		<div id="reviewModal" class="modal">
			<div
				style="width: 300px; margin: 150px auto; background: #fff; padding: 20px; text-align: center; border-radius: 8px;">
				<p class="modal-title">리뷰를 선택해주세요.</p>
				<ul class="review-options" style="list-style: none; padding: 0;">
					<li class="review-item">친절한 의사 선생님</li>
					<li class="review-item">전문적인 치료</li>
					<li class="review-item">상냥한 간호사 / 직원</li>
					<li class="review-item">깨끗한 시설</li>
					<li class="review-item">편한 교통.주차</li>
				</ul>
				<div class="modal-buttons-review">
					<button type="submit" class="submitReview">제출</button>
				</div>
			</div>
		</div>
		
		<!-- 예약 취소 모달 -->
		<div id="reserveCancleModal" class="modal">
			<div class="modal-content">
				<p class="modal-text">예약을 취소 하시겠습니까?</p>
				<div class="modal-buttons">
					<button type="submit" class="confirmreserveCancle">확인</button>
					<button type="button" class="canclereserveCancle">취소</button>
				</div>
			</div>
		</div>
		
		<!-- 로그아웃 모달 -->
		<div id="logoutModal" class="modal">
			<div class="modal-content">
				<p class="modal-text">로그아웃 하시겠습니까?</p>
				<div class="modal-buttons">
					<button type="submit" class="confirmLogout">확인</button>
					<button type="button" class="cancelLogout">취소</button>
				</div>
			</div>
		</div>
	</div>

</body>
</html>