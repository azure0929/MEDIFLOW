<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link rel="stylesheet" href="/css/common.css" />
<link rel="stylesheet" href="/css/mypage.css" />

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(() => {
		// 폰넘버 유효성 검사 - RangeError 해결
    const $phone = $('#phone');
    const phoneInputHandler = function () {
        let val = $phone.val();
        let numeric = val.replace(/[^0-9]/g, '');

        if (!numeric.startsWith('010')) {
            numeric = '010' + numeric.substring(3);
        }

        let formatted = '010';
        let rest = numeric.substring(3);

        if (rest.length > 0 && rest.length <= 4) {
            formatted += '-' + rest;
        } else if (rest.length > 4) {
            formatted += '-' + rest.substring(0, 4) + '-' + rest.substring(4);
        }

        $phone.off('input', phoneInputHandler);
        $phone.val(formatted);
        $phone.on('input', phoneInputHandler);
    };

    $phone.on('input', phoneInputHandler);

    // 초기값 설정 및 포커스 처리 로직
    $phone.val('010-');
    $phone.on('focus', function () {
        const val = $(this).val();
        if (!val.startsWith('010-')) {
            $(this).val('010-');
        }
        setTimeout(() => {
            this.setSelectionRange(this.value.length, this.value.length);
        }, 0);
    });		
	
    // 탭 별 내용 보이기/숨기기
    $('.modify').show();
    $('.reserveinfo').hide();
	
    // 탭 클릭 처리
    $('.tabs .tab').on('click', function(e) {
    	e.preventDefault();
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
    
    // 회원탈퇴 모달 - 회원탈퇴 탭 클릭
    $('.tabs li').eq(2).on('click', function() {
      $('#withdrawModal').fadeIn(100);
    });
    // 회원탈퇴 모달 - 탈퇴 취소
    $('.cancelWithdraw').on('click', function() {
      $('#withdrawModal').fadeOut(100);
    });
    // 회원탈퇴 모달 - 회원 탈퇴 확인 버튼 클릭 -> AJAX 요청 추가
    $('.confirmWithdraw').on('click', function() {
    	$('.modal-text').text('탈퇴 되었습니다.');
      $('.modal-buttons').html('<button type="button" class="closeWithdraw">닫기</button>');
    });
    // 회원탈퇴 모달 - 닫기 클릭 -> index.jsp 이동
    $(document).on('click', '.closeWithdraw', function() {
    	window.location.href = "/deleteMember"; 
    });
  
    
    // 회원정보수정 모달 - 버튼 클릭
    $('.memberupdate').on('click', function() {
      // 입력된 비밀번호와 전화번호 가져오기
      const password = $('#password').val();
      const phone = $('#phone').val();

      // 비밀번호 또는 전화번호가 입력되었는지 확인
      if (password === "" && phone === "") {
          alert('수정할 정보를 입력해주세요.');
          return;
      }

      $('#memberUpdateForm').submit();
     	alert(phone);
    });
    // 회원정보수정 모달 - 닫기 버튼
    $(document).on('click', '.closeMemberUpdate', function() {
      $('#memberUpdateModal').fadeOut(100, () => {
        window.location.href = "member/bookings"
      });
    });
  
    
    // 로그아웃 모달 - 로그아웃 탭 클릭
    $('.tabs li').eq(3).on('click', function() {
      $('#logoutModal').fadeIn(100);
    });
    // 로그아웃 모달 - 로그아웃 확인 버튼 클릭
    $(document).on('click', '.confirmLogout', function() {
      $('.modal-text').text('로그아웃 되었습니다.');
      $('.modal-buttons').html('<button type="button" class="closeLogout">닫기</button>');
    });
    // 로그아웃 모달 - 로그아웃 모달 닫기 버튼
    $(document).on('click', '.closeLogout', function() {
      $('#logoutModal').fadeOut(100);
      window.location.href = '/logout';
    })
    // 로그아웃 모달 - 로그아웃 모달 취소 버튼
    $(document).on('click', '.cancelLogout', function() {
      $('#logoutModal').fadeOut(100);
    })
    
    let bNum=null; //버튼 클릭시 예약번호 가져오는 변수
    // 예약 취소 모달 - 예약 취소 버튼 클릭
    $('.reservecancle').on('click', function(e) {
      e.preventDefault(); 
      $('#reserveCancleModal').fadeIn(100);
      bNum=$(this).data('bnum');
    });
    // 예약 취소 모달 - 예약 취소 모달 확인 버튼
    $(document).on('click', '.confirmreserveCancle', function() {
      $('.modal-text').text('예약이 취소 되었습니다.');
      $('.modal-buttons').html('<button type="button" class="closereservemodal">닫기</button>');
      $('.reservelist').remove();
    })
    // 예약 취소 모달 - 예약 취소 모달 취소 버튼
    $(document).on('click', '.canclereserveCancle', function() {
      $('#reserveCancleModal').fadeOut(100);
    })
    // 예약 취소 모달 - 예약 취소 모달 닫기 버튼
    $(document).on('click', '.closereservemodal', function() {
      $('#reserveCancleModal').fadeOut(100);
      window.location.href = "/mypage/deleteBooking?bNum="+bNum;
    })
	
    let mNum=null; //버튼 클릭시 회원번호 가져오는 변수
    let hNum=null; //버튼 클릭시 병원번호 가져오는 변수
    // 리뷰 모달 - '리뷰 작성' 버튼 클릭 시 리뷰 모달 열기
    $('.reviewbutton').on('click', function() {
      bNum=$(this).data('bnum');
      mNum=$(this).data('mnum');
      hNum=$(this).data('hnum');
      //alert("예약번호 : "+bNum+"회원번호 :"+mNum+"병원번호 : "+hNum);
      $('#reviewModal').fadeIn(100);
    });
    // 리뷰 모달 - 리뷰 항목 선택 시 스타일 변경
    $('.review-item').on('click', function() {
      // 모든 항목의 선택 해제
      $('.review-item').removeClass('active');
      // 클릭된 항목만 선택
      $(this).addClass('active');
    });
    // 리뷰 모달 - '제출' 버튼 클릭 시
   	$('#reviewForm').on('submit', function(e){
   	 const selectedReview = $('.review-item.active').text().trim();
   		if(!mNum || !hNum){
   		    e.preventDefault();
   		    alert('회원/병원 정보가 없습니다. 다시 시도해주세요.');
   		    return;
   		}
   	  if (!selectedReview) {
   	    e.preventDefault();
   	    alert('리뷰를 선택해주세요.');
   	    return;
   	  }
   	  $('#bNumField').val(bNum);
      $('#mNumField').val(mNum);
      $('#hNumField').val(hNum);
      $('#rContentField').val(selectedReview);
   	  alert('리뷰가 성공적으로 제출되었습니다.');
      
      $('#reviewModal').fadeOut(100);
      
      $('.status-message').css('display', 'block');
      $('.reservation-buttons').css('display', 'none');
   	});
  
    // 리뷰 모달 - '닫기' 버튼 클릭 시 
    $('.closeReview').on('click', function() {
    	$('.review-item').removeClass('active');
    	$('#reviewModal').fadeOut(100);
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
				<form action="/updateMember" method="post" id="memberUpdateForm">
					<input type="password" name="mPassword" id="password" maxlength="8"
						placeholder="비밀번호를 입력해주세요." autocomplete="off" /> <input
						type="text" name="mPhone" id="phone" placeholder="전화번호를 입력해주세요."
						autocomplete="off" />
					<div class="modifybtn">
						<button class="memberupdate" type="submit">수정</button>
					</div>
				</form>
			</section>
			<section class="reserveinfo">
				<p>
					<span><c:out value="${loggedInMember.mName}" /></span>님의 예약 내역입니다.
				</p>
				<ul class="reservelists">
					<c:choose>
						<c:when test="${not empty bookingList}">
							<c:forEach var="booking" items="${bookingList}">
								<li class="reservelist" data-bnum="${booking.bNum}">
									<div class="hospitalphoto">
										<img src="${booking.hospital.hUrl}" alt="${booking.hospital.hTitle}" />
									</div>
									<form class="reservecontent" action="" method="get">
										<div class="name hospitalinfo">
											<label>병원:</label>
											<span>${booking.hospital.hTitle}</span>
										</div>
										<div class="department hospitalinfo">
											<label>진료과:</label>
											<span>${booking.hospital.hDepartment}</span>
										</div>
										<div class="reservedate hospitalinfo">
											<label>예약일자:</label>
											<span>${booking.bDate}</span>
										</div>
										<div class="reservetime hospitalinfo">
											<label>예약시간:</label>
											<span>${booking.bTime}</span>
										</div>
										<div class="reservation-buttons">
											<c:if test="${booking.bStatus == 1}">
											<button type="button" data-bNum="${booking.bNum}" data-hNum="${booking.hospital.hNum}" data-mNum="${booking.member.mNum}" class="reviewbutton">리뷰 작성</button>
											</c:if>
											<c:if test="${booking.bStatus == 0}">
											<button type="button" data-bNum="${booking.bNum}" class="reservecancle">예약 취소</button>
											</c:if>
											<c:if test="${booking.bStatus == 2}">
											<div class="status-message">
												<span>진료 완료</span>
											</div>
											</c:if>
										</div>
									</form>
								</li>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<p class="no-booking">예약 내역이 없습니다.</p>
						</c:otherwise>
					</c:choose>
				</ul>
			</section>
		</main>

		<div id="withdrawModal" class="modal">
			<div class="modal-content">
				<p class="modal-text">정말로 탈퇴 하시겠습니까?</p>
				<div class="modal-buttons">
					<button type="submit" class="confirmWithdraw">확인</button>
					<button type="button" class="cancelWithdraw">취소</button>
				</div>
			</div>
		</div>

		<div id="memberUpdateModal" class="modal">
			<div class="modal-content">
				<p class="modal-text">정보가 수정 되었습니다.</p>
				<div class="modal-buttons">
					<button type="button" class="closeMemberUpdate">닫기</button>
				</div>
			</div>
		</div>


		<div id="reviewModal" class="modal reviewmodal">
			<div class="reviewmodal-content">
				<p class="reviewmodal-title">리뷰를 선택해주세요.</p>
				<form id="reviewForm" action="/mypage/reviewRegister" method="post">
				
					<input type="hidden" name="booking.bNum" id="bNumField">
					<input type="hidden" name="member.mNum" id="mNumField">
				    <input type="hidden" name="hospital.hNum" id="hNumField">
				    <input type="hidden" name="rContent" id="rContentField">
				
				<ul class="review-options">
					<li class="review-item">친절한 의사 선생님</li>
					<li class="review-item">전문적인 치료</li>
					<li class="review-item">상냥한 간호사 / 직원</li>
					<li class="review-item">깨끗한 시설</li>
					<li class="review-item">편한 교통.주차</li>
				</ul>
				<div class="modal-buttons-review">
					<button type="submit" class="submitReview">제출</button>
					<button type="button" class="closeReview">닫기</button>
				</div>
				</form>
			</div>
		</div>

		<div id="reserveCancleModal" class="modal">
			<div class="modal-content">
				<p class="modal-text">예약을 취소 하시겠습니까?</p>
				<div class="modal-buttons">
					<button type="submit" class="confirmreserveCancle">확인</button>
					<button type="button" class="canclereserveCancle">취소</button>
				</div>
			</div>
		</div>

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