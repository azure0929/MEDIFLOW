<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MEDIFLOW</title>

<link rel="stylesheet" href="/css/common.css" />
<link rel="stylesheet" href="/css/hospitalDetail.css" />

<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" />
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr/dist/l10n/ko.js"></script>

<script>
	let selectedDate = null;
	let flatpickrInstance = null;
	// JSP에서 전달받은 병원 이름과 진료 과목을 JavaScript 변수로 저장합니다.
	const hospitalTitle = "${hospital.hTitle}";
	const hospitalDepartment = "${hospital.hDepartment}";

	function openModal() {
		if (flatpickrInstance) {
			flatpickrInstance.destroy();
		}
		selectedDate = null;
		localStorage.removeItem('selectedDate');
		$('#date-error').hide();
		
		$('.modal-title').text(`예약하기 (${hospital.hTitle})`); 

		$('.booking-modal').fadeIn(100);
		$('.modal-wrap').css('bottom', '0');
		initFlatpickr();
	}

	function initFlatpickr() {
		flatpickrInstance = flatpickr("#calendar", {
			locale: "ko",
			inline: true,
			minDate: "today",
			dateFormat: "Y-m-d",
			onChange: function(selectedDates, dateStr, instance) {
				selectedDate = dateStr;
				localStorage.setItem('selectedDate', dateStr);
				$('#date-error').hide();
			}
		});
	}

	function showDayChoice() {
		const modalContents = $('.modal-contents');
		const modalButtons = $('.modal-buttons');

		modalContents.html(`
			<div class="date-choice">
				<h3 class="choice-title">요일 선택</h3>
				<div id="calendar"></div>
				<p id="date-error" class="date-error" style="display: none;">날짜는 반드시 선택해야 합니다. ❗</p>
			</div>
		`);
		
		modalButtons.html(`
			<button class="modal-btn prev-btn selectdayprev" id="prev-btn">이전</button>
			<button class="modal-btn next-btn selectdaynext" id="next-btn">다음</button>
		`);
		if (flatpickrInstance) {
			flatpickrInstance.destroy();
		}
		initFlatpickr();
		$(document).off('click', '.selectdayprev').on('click', '.selectdayprev', function() {
			$('.modal-wrap').css('bottom', '-660px');
			$('.booking-modal').fadeOut(100);
		});
		$(document).off('click', '.selectdaynext').on('click', '.selectdaynext', function() {
      if (flatpickrInstance.selectedDates.length > 0) {
        const dateStr = flatpickrInstance.formatDate(flatpickrInstance.selectedDates[0], "Y-m-d");
        localStorage.setItem('selectedDate', dateStr);
        showTimeChoice();
      } else {
        $('#date-error').show();
      }
    });
	}

	function showTimeChoice() {
	  const modalContents = $('.modal-contents');
	  const modalButtons = $('.modal-buttons');
	  const storedDate = localStorage.getItem('selectedDate');

	  if (storedDate) {
	    modalContents.html(`
	      <div class="time-choice">
	        <h3 class="choice-title">예약 날짜</h3>
	        <p class="selected-date"></p>  
	        <h3 class="choice-title time">진료 시간</h3>
	        <div class="time-buttons">
	          <button class="time-btn">오전</button>
	          <button class="time-btn">오후</button>
	        </div>
	        <p id="date-error" class="date-error" style="display: none;">시간은 반드시 선택해야 합니다. ❗</p>
	      </div>
	    `);

	    $('.selected-date').text(storedDate);
	    modalButtons.html(`
	      <button class="modal-btn prev-btn timeselectprev" id="prev-btn">이전</button>
	      <button class="modal-btn next-btn timeselectnext" id="next-btn">다음</button>
	    `);
	    $(document).off('click', '.timeselectprev').on('click', '.timeselectprev', function() {
	      showDayChoice();
	    });
	  } else {
	    $('#date-error').show();
	  }
	}

	$(() => {
		initFlatpickr();
		$('.booking-btn').on('click', function() {
			openModal();
		});
		$(document).on('click', '.selectdaynext', function() {
			if (localStorage.getItem('selectedDate')) {
				showTimeChoice();
			} else {
				$('#date-error').show();
			}
		});
		$(document).on('click', '.timeselectprev', function() {
			showDayChoice();
		});
		$(document).on('click', '.selectdayprev', function() {
			$('.modal-wrap').css('bottom', '-660px');
			$('.booking-modal').fadeOut(100);
		});
		$(document).on('click', '.time-btn', function() {
			$('.time-btn').removeClass('active');
			$(this).addClass('active');
		});
	});
</script>
</head>
<body>
	<jsp:include page="/components/header.jsp" />
	<div class="inner">
		<main class="main-content">
			<section class="hopital-main-img">
				<div class="hospital-img-wrap">
					<img src="/img/hospital_main.jpg" alt="병원 대표 이미지" />
				</div>
			</section>
			<hr class="section-divider">
			<div class="hospital-header">
				<div class="hospital-title-wrap">
					<h1 class="hospital-title">${hospital.hTitle}</h1>
					<p class="hospital-specialty">${hospital.hDepartment}</p>
				</div>
				<div class="hospital-state-wrap">
					<img src="/img/MedicalStatement_ing.png" alt="병원 상태">
					<p class="hospital-time">🕒 09:00 ~ 18:00</p>
				</div>
				<ul class="hospital-info-wrap">
					<li class="hospital-info">국가예방접종</li>
					<li class="hospital-info">주차장</li>
					<li class="hospital-info">전문의</li>
				</ul>
			</div>
			<hr class="section-divider">
			<section class="notice-wrap">
				<div class="notice-box">
					<p class="notice-text">* 메디플로우에서 예약 후, 병원에서 호명시 자리에 없으시면 예약은 바로
						취소됩니다. 예약 후 진료 상담 시 반드시 '메디플로우'에서 예약했다 말씀해주세요.</p>
				</div>
			</section>
			<div class="hospital-buttons">
				<button class="btn-call">전화문의</button>
				<button class="btn-share">공유하기</button>
			</div>
			<hr class="section-divider">
			<div class="hospital-tabs">
				<ul class="tab-list">
					<li class="tab-item active">병원 정보</li>
					<li class="tab-item">진료 과목</li>
					<li class="tab-item">병원 리뷰</li>
				</ul>
			</div>

			<section class="info-section-wrap">
				<div class="info-section-title">
					<h2 class="section-title">병원 운영 시간</h2>
					<img src="/img/MedicalStatement_ing.png" alt="병원 상태">
				</div>
				<ul class="time-info-grid">
					<li class="time-info-list"><span class="time-info-day">월요일</span>
						<span class="time-info-hour">09:00 ~ 18:00</span></li>
					<li class="time-info-list"><span class="time-info-day">화요일</span>
						<span class="time-info-hour">09:00 ~ 18:00</span></li>
					<li class="time-info-list"><span class="time-info-day">수요일</span>
						<span class="time-info-hour">09:00 ~ 18:00</span></li>
					<li class="time-info-list"><span class="time-info-day">목요일</span>
						<span class="time-info-hour">09:00 ~ 18:00</span></li>
					<li class="time-info-list"><span class="time-info-day">금요일</span>
						<span class="time-info-hour">09:00 ~ 18:00</span></li>
					<li class="time-info-list"><span
						class="time-info-day text-blue">토요일</span> <span
						class="time-info-hour">09:00 ~ 13:00</span></li>
					<li class="time-info-list"><span
						class="time-info-day text-red">일요일</span> <span
						class="time-info-hour">휴무</span></li>
					<li class="time-info-list"><span
						class="time-info-day text-red">공휴일</span> <span
						class="time-info-hour">휴무</span></li>
					<li class="time-info-list"><span
						class="time-info-day break-time">* 휴게시간</span> <span
						class="time-info-hour">13:00 ~ 14:30</span></li>
				</ul>
			</section>
			<hr class="section-divider">
			<section class="info-section-wrap">
				<h2 class="section-title">병원 위치</h2>
				<div class="info-location-wrap">
					<p class="hospital-location">📍 서울특별시 강남구 테헤란로 110 5층 501호
						(역삼동, 켐브리지빌딩)</p>
					<button class="copy">복사</button>
				</div>
				<div class="info-map">[지도 API 영역]</div>
			</section>
			<hr class="section-divider">
			<section class="info-section-wrap">
				<h2 class="section-title">병원 소개</h2>
				<p class="info-list-item">
					환자의 건강을 최우선으로 생각하는 병원입니다. <br> 친절함과 정확한 진료로, 환자 치료에 전념합니다. <br>
					지하철역 2번 출구에서 100m 대로변 따라 직진 후 1층 약국 건물 5층입니다.
				</p>
			</section>
			<hr class="section-divider">
			<section class="info-section-wrap">
				<div class="section-title-wrap">
					<h2 class="section-title">병원 리뷰</h2>
					<p class="review-all-count">총 230개</p>
				</div>
				<div class="review-bar-wrap">
					<div class="review-progress-bar">
						<div class="review-content">
							<img src="/img/doctor.png" /> <span class="review-label">친절한
								의사선생님</span>
						</div>
						<div class="review-progress-fill" style="width: 80%;"></div>
						<div class="review-count">100개</div>
					</div>
					<div class="review-progress-bar">
						<div class="review-content">
							<img src="/img/doctor.png" /> <span class="review-label">전문적인
								치료</span>
						</div>
						<div class="review-progress-fill" style="width: 60%;"></div>
						<div class="review-count">60개</div>
					</div>
					<div class="review-progress-bar">
						<div class="review-content">
							<img src="/img/doctor.png" /> <span class="review-label">상냥한
								간호사 / 직원</span>
						</div>
						<div class="review-progress-fill" style="width: 40%;"></div>
						<div class="review-count">40개</div>
					</div>
					<div class="review-progress-bar">
						<div class="review-content">
							<img src="/img/doctor.png" /> <span class="review-label">깨끗한
								시설</span>
						</div>
						<div class="review-progress-fill" style="width: 20%;"></div>
						<div class="review-count">20개</div>
					</div>
					<div class="review-progress-bar">
						<div class="review-content">
							<img src="/img/doctor.png" /> <span class="review-label">편한
								교통.주차</span>
						</div>
						<div class="review-progress-fill" style="width: 10%;"></div>
						<div class="review-count">10개</div>
					</div>
				</div>
			</section>
			<hr class="section-divider">
			<button class="booking-btn" onclick="openModal()">예약하기</button>
		</main>
		
		<div class="booking-modal" id="booking-modal">
			<div class="modal-wrap">
				<div class="modal-title"></div>
				<div class="modal-contents">
					<div class="date-choice">
						<h3 class="choice-title">요일 선택</h3>
						<div id="calendar"></div>
						<p id="date-error" class="date-error" style="display: none;">날짜는 반드시 선택해야 합니다. ❗</p>
					</div>
				</div>
				<div class="modal-buttons">
					<button class="modal-btn prev-btn selectdayprev" id="prev-btn">이전</button>
					<button class="modal-btn next-btn selectdaynext" id="next-btn">다음</button>
				</div>
			</div>
		</div>
		
	</div>
	<jsp:include page="/components/footer.jsp" />
</body>
</html>