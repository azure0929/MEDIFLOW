<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Hospital Search Result Main Page</title>
<link rel="stylesheet" href="/css/common.css" />
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" />
<style type="text/css">
.container {
	max-width: 1440px;
	margin: 0 auto;
	padding-top: 80px;
}

.main-content {
	display: flex;
	flex-direction: column;
	gap: 40px;
}

.search-form {
    width: 810px;
    display: flex;
    align-items: center;
    border-radius: 8px;
    overflow: hidden;
    margin: 0 auto;
	box-shadow: 0 0 8px rgba(0, 0, 0, 0.05);
	border: 1px solid rgba(0, 0, 0, 0.1);
}

.custom-select-wrap {
	position: relative;
	width: 160px;
  	height: 56px;
}
.custom-select{
    -webkit-appearance: none; 
    -moz-appearance: none;    
    appearance: none;         
	width: 100%;
	height: 100%;
	font-size: 16px;
	color: var(--text-color);
	border-radius: 8px 0 0 8px;
	text-align: center;
	border: none;
	border-right: 1px solid #C1C7CD;
	outline: 0 none;
}

.icon-arrow {
	position: absolute;
	top: 50%;
	right: 12px;
	width: 24px;
	height: 24px;
	pointer-events: none;
	transform: translateY(-50%);
	transition: transform 0.3s ease;
}

.custom-select:focus + .icon-arrow {
  transform: translateY(-50%) rotate(180deg);
}

.search-dropdown option{
    background-color: #fff;
}

.search-input-wrap {
    display: flex;
    flex-grow: 1;
}

.search-input {
    padding: 10px 20px;
    font-size: 16px;
    width: 100%;
    height: 56px;
    border: none;
}

.search-input:focus,
.custom-select:focus {
    outline: none;
}

.search-input::placeholder {
	font-size: 16px;
	color: #999;
}

.search-button {
	width: 56px;
	height: 56px;
    border: none;
    cursor: pointer;
    font-size: 16px;
    background-color: transparent;
    color: var(--text-color);
}

.list-container {
	width: fit-content;
	margin: 0 auto;
}

.hospital-card {
	width: 810px;
	height: 300px;
	display: flex;
	padding: 24px;
	align-items: center;
	background: #fff;
	border-radius: 8px;
	box-shadow: 0 0 8px rgba(0, 0, 0, 0.05);
	border: 1px solid rgba(0, 0, 0, 0.1);
	margin-bottom: 24px;
}

.card-wrap {
	/*
	display: flex;
	justify-content: space-between;
	gap: 24px;
	width: 100%;
	height: 100%;*/
	/* gap: 28px; */
	display: flex;
	width: 100%;
	height: 100%;
}

.card-image {
	width: 240px;
	height: 240px;
}

.card-image img {
	width: 100%;
	height: 100%;
	border-radius: 8px;
	object-fit: cover;
}

.card-info {
	/*flex: 1;
	flex-direction: column;
	margin-top: 10px;
	display: flex;*/
	/* margin-left: 24px; */
	display: flex;
	flex-direction: column;
	justify-content: space-between;
	margin-left: 24px;
	flex-grow: 1; /* 남는 공간을 모두 차지하도록 */
}

.card-detail {
	display: flex;
	flex-direction: column;
	gap: 14px;
}

.top-title, .middle-state, .bottom-info {
	display: flex;
	gap: 8px;
	align-items: center;
	flex-wrap: wrap;
}

.hospital-title {
	font-size: 20px;
	font-weight: bold;
	color: var(--text-color);
}

.hospital-specialty, 
.hospital-status, 
.hospital-time,
.hospital-location {
	margin: 4px 0;
	font-size: 14px;
	color: #595959;
}

.copy {
	padding: 4px 8px;
	color: var(--text-color);
	font-size: 12px;
	cursor: pointer;
	border-radius: 8px;
	background-color: var(--secondary-color);
	/* margin-top: 4px; */
}

.hospital-info-wrap {
	display: flex;
	padding: 0;
	gap: 8px;
	/* margin-top: 8px; */
}

.hospital-info {
	background: #f0f0f0;
	padding: 4px 8px;
	border-radius: 4px;
	font-size: 12px;
	color: #595959;
}

.card-actions {
	display: flex;
	justify-content: flex-end;
	gap: 8px;
	/* 	padding-top: 16px; */
	/* padding: 0 16px 16px; */
}

.call-btn, .booking-btn {
	width: 122px;
	height: 56px;
	font-size: 14px;
	font-weight: bold;
	border-radius: 8px;
	cursor: pointer;
}

.call-btn {
	background: white;
	border: 1px solid var(--primary-color);
	color: var(--primary-color);
}

.booking-btn {
	background: var(--primary-color);
	color: white;
	border: none;
}
</style>
</head>
<body>
	<div class="container">
		<jsp:include page="/components/header.jsp" />

		<main class="main-content">
			<section class="map-section">
				<div class="map-api">
					<!-- 실제 구현 시 카카오맵 또는 구글맵 embed -->
					<p style="text-align: center">[지도 영역]</p>
				</div>
			</section>

			<form action="/search" method="get" class="search-form">
				<div class="custom-select-wrap">
					<select name="searchType" id="search-type" class="custom-select">
						<option value="all" selected>전체 검색</option>
						<option value="hospitalName">병원이름</option>
						<option value="location">지역</option>
						<option value="specialty">진료과목</option>
					</select>
					<span class="icon-arrow"><img alt="icon-arrow" src="/img/arrow-down.svg"></span>
				</div>
			    <div class="search-input-wrap">
			        <input type="text" name="keyword" id="search-keyword" class="search-input" placeholder="병원이름, 지역, 진료과 검색해보세요">
			        <button type="submit" class="search-button">
			            <span class="material-symbols-outlined">search</span>
			        </button>
			    </div>				
			</form>

			<section class="hospital-list-section">
				<ul class="list-container">
					<!-- 추후 서버 연동 시 아래 구조를 반복 처리 -->
					<li class="hospital-card">
						<div class="card-wrap">
							<a href="hospital.detail.jsp"></a>
							<div class="card-image">
								<img src="/img/main01.png" alt="병원 이미지">
							</div>
							<div class="card-info">
								<div class="card-detail">
									<div class="top-title">
										<h3 class="hospital-title">웰봄병원</h3>
										<p class="hospital-specialty">내과</p>
									</div>
									<div class="middle-state">
										<img src="/img/MedicalStatement_ing.png" alt="병원 상태">
										<p class="hospital-time">🕒 09:00 ~ 18:00</p>
									</div>
									<div class="bottom-info">
										<p class="hospital-location">📍 서울특별시 강남구 테헤란로 110 5층 501호
											(역삼동, 켐브리지빌딩)</p>
										<button class="copy">복사</button>
									</div>
									<ul class="hospital-info-wrap">
										<li class="hospital-info">국가예방접종</li>
										<li class="hospital-info">주차장</li>
										<li class="hospital-info">전문의</li>
									</ul>
								</div>
								<div class="card-actions">
									<button class="call-btn">전화하기</button>
									<button class="booking-btn" onclick="location.href='hospitalDetail.jsp'">예약하기</button>
								</div>
							</div>
						</div>
					</li>
					<li class="hospital-card">
						<div class="card-wrap">
							<a href="#"></a>
							<div class="card-image">
								<img src="/img/main01.png" alt="병원 이미지">
							</div>
							<div class="card-info">
								<div class="card-detail">
									<div class="top-title">
										<h3 class="hospital-title">웰봄병원</h3>
										<p class="hospital-specialty">내과</p>
									</div>
									<div class="middle-state">
										<img src="/img/MedicalStatement_ing.png" alt="병원 상태">
										<p class="hospital-time">🕒 09:00 ~ 18:00</p>
									</div>
									<div class="bottom-info">
										<p class="hospital-location">📍 서울특별시 강남구 테헤란로 110 5층 501호
											(역삼동, 켐브리지빌딩)</p>
										<button class="copy">복사</button>
									</div>
									<ul class="hospital-info-wrap">
										<li class="hospital-info">국가예방접종</li>
										<li class="hospital-info">주차장</li>
										<li class="hospital-info">전문의</li>
									</ul>
								</div>
								<div class="card-actions">
									<button class="call-btn">전화하기</button>
									<button class="booking-btn">예약하기</button>
								</div>
							</div>
						</div>
					</li>
					<li class="hospital-card">
						<div class="card-wrap">
							<a href="#"></a>
							<div class="card-image">
								<img src="/img/main01.png" alt="병원 이미지">
							</div>
							<div class="card-info">
								<div class="card-detail">
									<div class="top-title">
										<h3 class="hospital-title">웰봄병원</h3>
										<p class="hospital-specialty">내과</p>
									</div>
									<div class="middle-state">
										<img src="/img/MedicalStatement_ing.png" alt="병원 상태">
										<p class="hospital-time">🕒 09:00 ~ 18:00</p>
									</div>
									<div class="bottom-info">
										<p class="hospital-location">📍 서울특별시 강남구 테헤란로 110 5층 501호
											(역삼동, 켐브리지빌딩)</p>
										<button class="copy">복사</button>
									</div>
									<ul class="hospital-info-wrap">
										<li class="hospital-info">국가예방접종</li>
										<li class="hospital-info">주차장</li>
										<li class="hospital-info">전문의</li>
									</ul>
								</div>
								<div class="card-actions">
									<button class="call-btn">전화하기</button>
									<button class="booking-btn">예약하기</button>
								</div>
							</div>
						</div>
					</li>
					<li class="hospital-card">
						<div class="card-wrap">
							<a href="#"></a>
							<div class="card-image">
								<img src="/img/main01.png" alt="병원 이미지">
							</div>
							<div class="card-info">
								<div class="card-detail">
									<div class="top-title">
										<h3 class="hospital-title">웰봄병원</h3>
										<p class="hospital-specialty">내과</p>
									</div>
									<div class="middle-state">
										<img src="/img/MedicalStatement_ing.png" alt="병원 상태">
										<p class="hospital-time">🕒 09:00 ~ 18:00</p>
									</div>
									<div class="bottom-info">
										<p class="hospital-location">📍 서울특별시 강남구 테헤란로 110 5층 501호
											(역삼동, 켐브리지빌딩)</p>
										<button class="copy">복사</button>
									</div>
									<ul class="hospital-info-wrap">
										<li class="hospital-info">국가예방접종</li>
										<li class="hospital-info">주차장</li>
										<li class="hospital-info">전문의</li>
									</ul>
								</div>
								<div class="card-actions">
									<button class="call-btn">전화하기</button>
									<button class="booking-btn">예약하기</button>
								</div>
							</div>
						</div>
					</li>															
				</ul>
			</section>
			
			<div class="booking-modal">
				<div class="modal-components">
					<div class="modal-title hospital-title">예약하기(해당병원이름)</div>
					<div class="step1 date-choice">
						<div class="step-title">예약 날짜 선택</div>
					</div>
				</div>
			</div>
			
		</main>
		<jsp:include page="/components/footer.jsp" />
	</div>
</body>
</html>