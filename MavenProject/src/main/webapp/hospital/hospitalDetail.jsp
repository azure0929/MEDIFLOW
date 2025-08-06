<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hospital Detail Page</title>
<link rel="stylesheet" href="/css/common.css" />
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" />
<style type="text/css">
.container {
	max-width: 1440px;
	margin: 0 auto;
	padding-top: 80px;
}

.main-content {
	width: 810px;
	margin: 0 auto;
}

.hospital-image-wrap {
	width: 810px;
	height: 480px;
	overflow: hidden;
	border-radius: 8px;
	margin-bottom: 24px;
	box-shadow: 0 0 8px rgba(0, 0, 0, 0.05);
	border: 1px solid rgba(0, 0, 0, 0.1);
}

.hospital-image-wrap img {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

.hospital-header {
	
}

</style>
</head>
<body>
    <div class="container">
        <jsp:include page="/components/header.jsp" />

        <main class="main-content">
        	<!-- 병원 대표 이미지 -->
            <div class="hospital-image-wrap">
                <img src="/img/hospital_main.jpg" alt="병원 대표 이미지" />
            </div>
            
            <div class="hospital-header">
                <div class="hospital-title-wrap">
                    <h1 class="hospital-title">화평한병원</h1>
                    <p class="hospital-specialty">내과</p>
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
            <hr class="section-divider" />
            
            <section class="notice-wrap">
            	<div class="notice-box">
            		<pre>
            			* 메디플로우에서 예약 후, 병원에서 호명시 자리에 없으시면 예약은 바로 취소됩니다.
            			  예약 후 진료 상담 시 반드시 '메디플로우'에서 예약했다 말씀해주세요.
            		</pre>
            	</div>
				<div class="hospital-buttons">
					<button class="btn-call">전화문의</button>
					<button class="btn-share">공유하기</button>
				</div>
			</section>
			 <hr class="section-divider" />
			 
			<div class="hospital-tabs">
				<ul>
					<li>병원 정보</li>
					<li>진료 과목</li>
					<li>병원 리뷰</li>
				</ul>
			</div>
			 <hr class="section-divider" />
			 
			<section class="info-section-wrap">
				<div class="info-section-title">
	                <h2 class="section-title">병원 운영 시간</h2>
					<img src="/img/MedicalStatement_ing.png" alt="병원 상태">
				</div>
                <ul class="time-info">
 					<li class="time-info-list"><span class="time-info-day">월요일</span> <span class="time-info-hour">09:00 ~ 18:00</span></li>
 					<li class="time-info-list"><span class="time-info-day">화요일</span> <span class="time-info-hour">09:00 ~ 18:00</span></li>
 					<li class="time-info-list"><span class="time-info-day">수요일</span> <span class="time-info-hour">09:00 ~ 18:00</span></li>
 					<li class="time-info-list"><span class="time-info-day">목요일</span> <span class="time-info-hour">09:00 ~ 18:00</span></li>
 					<li class="time-info-list"><span class="time-info-day">금요일</span> <span class="time-info-hour">09:00 ~ 18:00</span></li>
 					<li class="time-info-list"><span class="time-info-day">토요일</span> <span class="time-info-hour">09:00 ~ 13:00</span></li>
 					<li class="time-info-list"><span class="time-info-day">일요일</span> <span class="time-info-hour">휴무</span></li>
 					<li class="time-info-list"><span class="time-rest-day">휴무일</span> <span class="time-info-hour">휴무</span></li>
 					<li class="time-info-list"><span class="time-info-day">휴게시간</span> <span class="time-info-hour">13:00 ~ 14:00</span></li>
                </ul>
            </section>
             <hr class="section-divider" />
             
            <section class="info-section-wrap">
            	<h2 class="section-title">병원 위치</h2>
				<div class="info-location-wrap">
					<p class="hospital-location">📍 서울특별시 강남구 테헤란로 110 5층 501호
						(역삼동, 켐브리지빌딩)</p>
					<button class="copy">복사</button>
				</div>
				<div class="info-map">[지도 API 영역]</div>
            </section>
            <hr class="section-divider" />
            
            <section class="info-section-wrap">
                <h2 class="section-title">병원 소개</h2>
                <p class="info-list-item">
                    환자의 마음을 먼저 생각하는 병원, 화평한병원입니다.<br/>
                    쾌적한 시설과 친절한 서비스로 최선을 다하겠습니다.
                </p>
            </section>

            <hr class="section-divider" />
            
            <section class="info-section-wrap">
            	<div class="section-title-wrap">
	                <h2 class="section-title">병원 리뷰</h2>
					<h3>총 230개</h3>
            	</div>
                <div class="review-bar-wrap">
                    <span>친절한 의사선생님</span>
                    <div class="review-progress-bar"><div class="review-progress-fill" style="width: 80%;"></div></div>
                    <span class="review-count">100개</span>
                </div>
                <div class="review-bar-wrap">
                    <span>전문적인 치료</span>
                    <div class="review-progress-bar"><div class="review-progress-fill" style="width: 40%;"></div></div>
                    <span class="review-count">60개</span>
                </div>
                <div class="review-bar-wrap">
                    <span>상냥한 간호사선생님 / 직원</span>
                    <div class="review-progress-bar"><div class="review-progress-fill" style="width: 10%;"></div></div>
                    <span class="review-count">40개</span>
                </div>
                <div class="review-bar-wrap">
                    <span>깨끗한 시설</span>
                    <div class="review-progress-bar"><div class="review-progress-fill" style="width: 5%;"></div></div>
                    <span class="review-count">20개</span>
                </div>
                <div class="review-bar-wrap">
                    <span>편한 교통.주차</span>
                    <div class="review-progress-bar"><div class="review-progress-fill" style="width: 1%;"></div></div>
                    <span class="review-count">10개</span>
                </div>
            </section>
           <button class="review-booking-btn">예약하기</button>
        </main>
        
        <jsp:include page="/components/footer.jsp" />
    </div>
</body>
</html>