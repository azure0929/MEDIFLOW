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
<link rel="stylesheet" href="/css/hospitalMain.css" />
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@shoelace-style/shoelace@2.20.1/cdn/themes/light.css" />
<script type="module" src="https://cdn.jsdelivr.net/npm/@shoelace-style/shoelace@2.20.1/cdn/shoelace-autoloader.js"></script>

</head>
<body>
	<div class="inner">
		<jsp:include page="/components/header.jsp" />

		<main class="main-content">

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
			
			<section class="map-section">
				<div class="map-api">
					<!-- 실제 구현 시 카카오맵 또는 구글맵 embed -->
					<p style="text-align: center">[지도 영역]</p>
				</div>
			</section>

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
										<p class="hospital-location" id="location">📍 서울특별시 강남구 테헤란로 110 5층 501호 (역삼동, 켐브리지빌딩)</p>
										<!-- 커스텀 복사하기 버튼 -->
										<sl-copy-button id="copyBtn" from="location" copy-label="클릭하여 복사하기" success-label="복사하였습니다." error-label="이런, 복사에 실패하였습니다!"> 
										</sl-copy-button>
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
										<!-- 커스텀 복사하기 버튼 -->
										<sl-copy-button id="copyBtn" from="location" copy-label="클릭하여 복사하기" success-label="복사하였습니다." error-label="이런, 복사에 실패하였습니다!"> 
										</sl-copy-button>
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
										<!-- 커스텀 복사하기 버튼 -->
										<sl-copy-button id="copyBtn" from="location" copy-label="클릭하여 복사하기" success-label="복사하였습니다." error-label="이런, 복사에 실패하였습니다!"> 
										</sl-copy-button>
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
										<!-- 커스텀 복사하기 버튼 -->
										<sl-copy-button id="copyBtn" from="location" copy-label="클릭하여 복사하기" success-label="복사하였습니다." error-label="이런, 복사에 실패하였습니다!"> 
										</sl-copy-button>
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
				</ul>
			</section>
		</main>
	</div>
	<jsp:include page="/components/footer.jsp" />
</body>
</html>