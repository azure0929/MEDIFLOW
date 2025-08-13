<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.service.spring.domain.Member"%>
<%
    Member loggedInMember = (Member) session.getAttribute("loggedInMember");
		String memberName = (loggedInMember != null) ? loggedInMember.getmName() : "비회원";
%>
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

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/@shoelace-style/shoelace@2.20.1/cdn/themes/light.css" />
<script type="module"
	src="https://cdn.jsdelivr.net/npm/@shoelace-style/shoelace@2.20.1/cdn/shoelace-autoloader.js"></script>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr/dist/l10n/ko.js"></script>

<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- SweetAlert2 CDN -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>	
	let selectedDate = null;
	let flatpickrInstance = null;
	let selectedTime = null;

	const hospitalTitle = "${hospital.hTitle}";
	const hospitalDepartment = "${hospital.hDepartment}";
	const hospitalNum = "${hospital.hNum}";
	const loggedInMemberName = "<%= memberName %>";
	const loggedInMemberNum = "<%= loggedInMember != null ? loggedInMember.getmNum() : 0 %>";

	// 예약하기 버튼 클릭 시 처음 나타나는 모달
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

	// Flatpickr 설정 함수
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

	// 예약일자 선택 모달
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

	// 진료 시간 선택 모달
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
	          <button class="time-btn" data-time="오전">오전</button>
	          <button class="time-btn" data-time="오후">오후</button>
	        </div>
	        <p id="time-error" class="time-error">시간은 반드시 선택해야 합니다. ❗</p>
	      </div>
	    `);

	    $('.selected-date').text(storedDate);
	    
	    modalButtons.html(`
	      <button class="modal-btn prev-btn timeselectprev" id="prev-btn">이전</button>
	      <button class="modal-btn next-btn timeselectnext" id="next-btn">다음</button>
	    `);
	    
	    $('#time-error').hide();
	    
	    $('.time-btn').on('click', function() {
	      $('.time-btn').removeClass('selected');
	      $(this).addClass('selected');
	      selectedTime = $(this).data('time');
	      localStorage.setItem('selectedTime', selectedTime);
	    });
	    
	    // 이전 버튼 클릭 시
	    $(document).on('click', '.timeselectprev').on('click', '.timeselectprev', function() {
	    	showDayChoice();
	    });
	    
	    // 다음 버튼 클릭 시
	    $(document).on('click', '.timeselectnext').on('click', '.timeselectnext', function() {
	    	if (selectedTime) {
					showConfirmation();
				} else {
					$('#time-error').show();
				}
	    });
	  } else {
		  $('#time-error').show();
	  }
	}
	
	// 예약 확인 모달
	function showConfirmation() {
	  const modalContents = $('.modal-contents');
	  const modalButtons = $('.modal-buttons');
	  const hDate = localStorage.getItem('selectedDate');
	  const hTime = localStorage.getItem('selectedTime');
	
	  modalContents.html(`
      <div class="confirmation-wrap">
	      <ul class="confirmation-lists">
          <div class="confirmation-list">
		        <li class="confirmation-item">
		          <p class="confirmation-label">예약자</p>
		          <span class="user-value"></span>
		        </li>
		        <li class="confirmation-item">
		          <p class="confirmation-label">진료 과목</p>
		          <span class="department-value"></span>
		        </li>
          </div>
          <div class="confirmation-list">
	          <li class="confirmation-item">
		          <p class="confirmation-label">예약 날짜</p>
		          <span class="day-value"></span>
		        </li>
		        <li class="confirmation-item">
		          <p class="confirmation-label">진료 시간</p>
		          <span class="time-value"></span>
		        </li>
          </div>
	      </ul>
	      <p class="reserveconfirm-message">예약 하시겠습니까?</p>
      </div>
	  `);
	
	  $('.user-value').text(loggedInMemberName);
	  $('.department-value').text(hospitalDepartment);
	  $('.day-value').text(hDate);
	  $('.time-value').text(hTime);
	  modalButtons.html(`
      <button class="reservestatebtn reservestatebtn-confirm">확인</button>
      <button class="reservestatebtn reservestatebtn-cancle">취소</button>
	  `);
	
	  // 예약 확인 버튼 클릭 시
	  $('.reservestatebtn-confirm').on('click', function() {
		  const hDate = localStorage.getItem('selectedDate');
		  const hTime = localStorage.getItem('selectedTime');
		  
		  $.ajax({
			  url: "/booking/insert",
			  type: "POST",
			  data: {
				  mNum: loggedInMemberNum,
				  hNum: hospitalNum,
				  bDate: hDate,
				  bTime: hTime
			  },
			  success: function(response) {
				  if(response === 'success') {
					  resultresverve();
				  }
			  },
		  });
	  });
	  
		// 예약 취소 버튼 클릭 시
	  $('.reservestatebtn-cancle').on('click', function() {
      $('.modal-wrap').css('bottom', '-660px');
      $('.booking-modal').fadeOut(100);
	  });
	}
	
	// 예약 성공 결과 모달
	function resultresverve() {
		const modalWrap = $('.modal-wrap');
		const hDate = localStorage.getItem('selectedDate');
		const hTime = localStorage.getItem('selectedTime');

		modalWrap.html(`
			<div class="result-message-wrap">
				<div class="result-message-title">
					<p>
						<span class="user-value"></span>님, <br />
						<span class="hospitalTitle-value"></span> 예약이 완료되었습니다.<br />
						빠른 시일 내에 연락드리겠습니다.
					</p>
				</div>
				<div class="result-message-contents">
					<div class="photo">
						<img src="/img/userillust.webp" alt="photo" />
					</div>
					<div class="user-reserveinfo">
						<ul class="reserveinfo-lists">
		          <div class="reserveinfo-list">
				        <li class="reserveinfo-item">
				          <p class="reserveinfo-label">예약자</p>
				          <span class="user-value"></span>
				        </li>
				        <li class="reserveinfo-item">
				          <p class="reserveinfo-label">진료 과목</p>
				          <span class="department-value"></span>
				        </li>
		          </div>
		          <div class="reserveinfo-list">
			          <li class="reserveinfo-item">
				          <p class="reserveinfo-label">예약 날짜</p>
				          <span class="day-value"></span>
				        </li>
				        <li class="reserveinfo-item">
				          <p class="reserveinfo-label">진료 시간</p>
				          <span class="time-value"></span>
				        </li>
		          </div>
			      </ul>
					</div>
				</div>
				<div class="reserveinfo-notice">
	      	<div class="notice-photo">
	      		<img src="/img/reserveinfonotice.webp" alt="noticeimg" />
	      	</div>
	      	<div class="noticeinfo">
	      		<p>
	      			병원 정책에 따라 환자 호명 시 자리에 없으면 접수가<br />
	      			자동 취소됩니다.
	      		</p>
	      	</div>
	      </div>
	      <div class="reservestatebtns">
	      	<button class="reservestatebtn-success">확인</button>
	      </div>
			</div>
		`);

		$('.user-value').text(loggedInMemberName);
	  $('.hospitalTitle-value').text(hospitalTitle);
	  $('.department-value').text(hospitalDepartment);
	  $('.day-value').text(hDate);
	  $('.time-value').text(hTime);
	  
	  // 확인 버튼 클릭 시
	  $('.reservestatebtn-success').on('click', function() {
		  $('.booking-modal').fadeOut(100);
		  $('.modal-wrap').css('bottom', '-660px');
	  })
	}

	$(() => {
		initFlatpickr();
		
		// 단일 병원 상세 페이지 - 예약하기 버튼 클릭 시
		$('.booking-btn').on('click', function() {
			openModal();
		});
		
		// 예약일자 선택 모달 - 다음 버튼 클릭 시
		$(document).on('click', '.selectdaynext', function() {
			if (localStorage.getItem('selectedDate')) {
				showTimeChoice();
			} else {
				$('#date-error').show();
			}
		});
		
		// 예약일자 선택 모달 - 이전 버튼 클릭 시
		$(document).on('click', '.selectdayprev', function() {
			$('.modal-wrap').css('bottom', '-660px');
			$('.booking-modal').fadeOut(100);
		});
		
		// 진료 시간 선택 모달 - 진료 시간 버튼 클릭 시
		$(document).on('click', '.time-btn', function() {
			$('.time-btn').removeClass('active');
			$(this).addClass('active');
			selectedTime = $(this).data('time');
			localStorage.setItem('selectedTime', selectedTime);
			$('#time-error').hide();
		});
		
		// 진료 시간 선택 모달 - 다음 버튼 클릭 시
		$(document).on('click', '.timeselectnext', function() {
			if (localStorage.getItem('selectedTime')) {
				showConfirmation();
			} else {
				$('#time-error').show();
			}
		});
		
		// 진료 시간 선택 모달 - 이전 버튼 클릭 시
		$(document).on('click', '.timeselectprev', function() {
			showDayChoice();
		});
	});
	
	$(function(){
	    $(".call-btn").on("click", function(){
	        const phone = $(this).data("phone");
	        const name = $(this).data("name");

	        Swal.fire({
	            title: name,
	            text: phone ? phone : '등록된 전화번호가 없습니다.',
	            icon: phone ? 'info' : 'warning',
	            confirmButtonText: '확인',
	            confirmButtonColor: '#568BFF'
	        });
	    });
	    
	    $(".share-btn").on("click", function(){
	        // 현재 페이지 URL 복사
	        const link = window.location.href;
	        
	        navigator.clipboard.writeText(link).then(function(){
	            Swal.fire({
	                text: '링크가 복사되었습니다.',
	                icon: 'success',
	                confirmButtonText: '확인',
	                confirmButtonColor: '#568BFF'
	            });
	        }).catch(function(){
	            Swal.fire({
	                text: '복사에 실패했습니다.',
	                icon: 'error',
	                confirmButtonText: '확인',
	                confirmButtonColor: '#d33'
	            });
	        });
	    });
	});
	
	$(function () {	
		  var OFFSET = 120;

		  $('.tab-item').on('click', function (e) {
			    e.preventDefault();

			    // 1) active 토글 (이건 무조건 수행)
			    $('.tab-item').removeClass('active');
			    $(this).addClass('active');

			    // 2) 스크롤 이동 (타겟이 있을 때만)
			    var target = $(this).data('target');
			    if (target && $(target).length) {
			      var top = $(target).offset().top - OFFSET;
			      $('html, body').animate({ scrollTop: top }, 800);
			    }
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
					<img src="${hospital.hUrl}" alt="병원 대표 이미지" />
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
				<button class="call-btn" data-phone="${hospital.hTel}" data-name="${hospital.hTitle}">
					<span class="material-symbols-outlined">call</span>
					<span>전화문의</span>
					</button>
				<button class="share-btn">
					<span class="material-symbols-outlined">share</span>
					<span>공유하기</span>
				</button>
			</div>
			<hr class="section-divider">
			<div class="hospital-tabs">
				<ul class="tab-list">
					<li class="tab-item active" data-target="#section-hours">병원 정보</li>
					<li class="tab-item" data-target="#section-intro">병원 소개</li>
					<li class="tab-item" data-target="#section-reviews">병원 리뷰</li>
				</ul>
			</div>
			<section id="section-hours" class="info-section-wrap">
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
					<p class="hospital-location" id="location-${hospital.hNum}">${hospital.hAddress}</p>
					<sl-copy-button id="copyBtn" from="location-${hospital.hNum}"
						copy-label="클릭하여 복사하기" success-label="복사하였습니다."
						error-label="이런, 복사에 실패하였습니다!"> </sl-copy-button>
				</div>
				<div id="map" class="info-map">[지도 API 영역]</div>
			</section>
			<hr class="section-divider">
			<section class="info-section-wrap" id="section-intro">
				<h2 class="section-title">병원 소개</h2>
				<pre class="info-list-item">${hospital.hContent}</pre>
			</section>
			<hr class="section-divider">
			<section class="info-section-wrap" id="section-reviews">
				<div class="section-title-wrap">
					<h2 class="section-title">병원 리뷰</h2>
					<p class="review-all-count">총 ${totalReviewCount}개</p>
				</div>
				<div class="review-bar-wrap">
					<c:choose>
						<c:when test="${totalReviewCount == 0}">
				      		<div class="review-empty">아직 등록된 리뷰가 없습니다.</div>
						</c:when>
						<c:otherwise>
							<c:set var="safeTotal" value="${totalReviewCount > 0 ? totalReviewCount : 1}" />
							<c:forEach var="contents" items="${reviewCounts}">
								<c:set var="count" value="${contents.value}" />
								<c:set var="percentage" value="${(count * 100.0) / safeTotal}" />	
								<div class="review-progress-bar">
									<div class="review-content">
										<img src="/img/doctor.png" /> 
										<span class="review-label">${contents.key}</span>
									</div>
									
									<div class="review-progress-fill" style="width: ${percentage}%;"></div>
									<div class="review-count">${count}개</div>
								</div>
							</c:forEach>					
						</c:otherwise>
					</c:choose>
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
						<p id="date-error" class="date-error" style="display: none;">날짜는
							반드시 선택해야 합니다. ❗</p>
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
	
<!-- 	<script>
	// ===== 유틸 =====
	const sleep = (ms) => new Promise(r => setTimeout(r, ms));
	const jitter = (ms) => Math.floor(Math.random() * ms);

	const GEO_CACHE_KEY = 'geoCache:v1';
	const loadCache = () => {
	  try { return JSON.parse(localStorage.getItem(GEO_CACHE_KEY)) || {}; }
	  catch { return {}; }
	};
	const saveCache = (obj) => localStorage.setItem(GEO_CACHE_KEY, JSON.stringify(obj));

	// geocoder를 Promise로
	function geocodeOnce(geocoder, address) {
	  return new Promise(resolve => {
	    geocoder.addressSearch(address, (result, status) => resolve({ result, status }));
	  });
	}

	// ===== 주소 수집 =====
	function collectAddresses() {
	  const nodes = document.querySelectorAll('.hospital-location');
	  const addresses = [...nodes]
	    .map(el => el.dataset.address?.trim() || el.textContent.replace(/^📍\s*/, '').trim())
	    .filter(a => a && a.length > 0);
	  return [...new Set(addresses)];
	}

	// ===== 순차 지오코딩 =====
	async function geocodeAll(addresses, map, {
	  baseDelayMs = 500,        // 기본 간격 (0.5초)
	  baseJitterMs = 300,       // 랜덤 지터
	  pauseOnErrorMs = 60_000,  // ERROR 시 전체 일시정지 1분
	  backoffStartMs = 10_000,  // 개별 백오프 시작 10초
	  backoffMaxMs = 120_000,   // 개별 백오프 최대 2분
	  maxRetriesPerAddress = 2, // 재시도 횟수
	} = {}) {
	  const geocoder = new kakao.maps.services.Geocoder();
	  const bounds = new kakao.maps.LatLngBounds();
	  const infoWindows = [];
	  const seen = new Set();
	  const cache = loadCache();

	  const unique = addresses.filter(a => !!a && !seen.has(a) && seen.add(a.trim().toLowerCase()));

	  let globalPauseUntil = 0;
	  let nextBackoffMs = backoffStartMs;

	  const useCached = (address) => {
	    const c = cache[address];
	    if (!c) return null;
	    if (c.notFound) return 'NOT_FOUND';
	    if (typeof c.lat !== 'number' || typeof c.lng !== 'number') return null;
	    return c;
	  };

	  for (const address of unique) {
	    const now = Date.now();
	    if (globalPauseUntil > now) {
	      await sleep(globalPauseUntil - now);
	    }

	    const cached = useCached(address);
	    if (cached && cached !== 'NOT_FOUND') {
	      const pos = new kakao.maps.LatLng(cached.lat, cached.lng);
	      bounds.extend(pos);
	      makeMarker(map, pos, address, infoWindows);
	      continue;
	    } else if (cached === 'NOT_FOUND') {
	      continue;
	    }

	    await sleep(baseDelayMs + jitter(baseJitterMs));

	    let attempt = 0;
	    let done = false;

	    while (!done && attempt <= maxRetriesPerAddress) {
	      const { result, status } = await geocodeOnce(geocoder, address);

	      if (status === kakao.maps.services.Status.OK) {
	        const lat = parseFloat(result[0].y);
	        const lng = parseFloat(result[0].x);
	        cache[address] = { lat, lng, ts: Date.now() };
	        saveCache(cache);

	        const pos = new kakao.maps.LatLng(lat, lng);
	        bounds.extend(pos);
	        makeMarker(map, pos, address, infoWindows);

	        globalPauseUntil = 0;
	        nextBackoffMs = backoffStartMs;
	        done = true;

	      } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
	        cache[address] = { notFound: true, ts: Date.now() };
	        saveCache(cache);
	        done = true;

	      } else {
	        attempt++;
	        globalPauseUntil = Date.now() + pauseOnErrorMs;
	        console.warn(`[Geocode ERROR] global pause ${pauseOnErrorMs}ms; retry #${attempt} :`, address);

	        if (attempt > maxRetriesPerAddress) break;

	        await sleep(nextBackoffMs);
	        nextBackoffMs = Math.min(nextBackoffMs * 2, backoffMaxMs);
	      }
	    }
	  }

	  if (!bounds.isEmpty()) {
	    map.setBounds(bounds);
	  }
	}

	// ===== 마커 생성 =====
	function makeMarker(map, pos, address, infoWindows) {
	  const marker = new kakao.maps.Marker({ map, position: pos, title: address });
	  const iw = new kakao.maps.InfoWindow({ content: `<div class="kakao-iw">${address}</div>` });
	  infoWindows.push(iw);
	  kakao.maps.event.addListener(marker, 'click', () => {
	    infoWindows.forEach(x => x.close());
	    iw.open(map, marker);
	  });
	}

	// ===== 지도 초기화 =====
	async function initMap() {
	  const map = new kakao.maps.Map(document.getElementById('map'), {
	    center: new kakao.maps.LatLng(37.5665, 126.9780),
	    level: 5
	  });

	  const addresses = collectAddresses();
	  if (!addresses.length) return;

	  await geocodeAll(addresses, map, {
	    baseDelayMs: 500,
	    baseJitterMs: 300,
	    pauseOnErrorMs: 60_000,
	    backoffStartMs: 10_000,
	    backoffMaxMs: 120_000,
	    maxRetriesPerAddress: 2
	  });
	}

	// ===== SDK 로드 =====
	function loadKakaoMap() {
	  const script = document.createElement('script');
	  script.src = "https://dapi.kakao.com/v2/maps/sdk.js?appkey=05a7077a5f466aaa4ba854dc2c6e035a&autoload=false&libraries=services";
	  script.onload = function () {
	    kakao.maps.load(initMap);
	  };
	  script.onerror = function () {
	    console.error("❌ Kakao Maps SDK 로딩 실패");
	  };
	  document.head.appendChild(script);
	}

	window.onload = loadKakaoMap;
</script> -->
</body>
</html>