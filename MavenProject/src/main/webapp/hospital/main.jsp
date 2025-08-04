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

<style type="text/css">
.main-content {
	display: flex;
	flex-direction: column;
}

.search-area {
  max-width: 900px;
  margin: 32px auto;
  padding: 0 24px;
  display: flex;
  justify-content: center;
}

.search-box {
  width: 100%;
  max-width: 600px;
  padding: 12px 16px;
  font-size: 16px;
  border: 1px solid #ccc;
  border-radius: 8px;
  outline: none;
  transition: border-color 0.2s;
}

.search-box:focus {
  border-color: #347eff;
  box-shadow: 0 0 0 2px rgba(52, 126, 255, 0.2);
}

.list-container {
	max-width: 900px;
	margin: 0 auto;
	padding: 24px;
	list-style: none;
}

.hospital-card {
	width: 900px;
	height: 300px;
	background: white;
	border-radius: 8px;
	box-shadow: 0 0 8px rgba(0, 0, 0, 0.05);
	margin-bottom: 24px;
	overflow: hidden;
}

.hospital-card a {
	display: flex;
	height: 100%;
	text-decoration: none;
	color: inherit;
	padding: 16px;
}

.card-image img {
	width: 240px;
	height: 240px;
	border-radius: 8px;
	object-fit: cover;
}

.card-info {
	flex: 1;
	margin-left: 16px;
	display: flex;
	flex-direction: column;
	justify-content: space-between;
}

.hospital-title {
	font-size: 20px;
	font-weight: bold;
	margin-right: 8px;
}

.hospital-specialty, .hospital-status, .hospital-time,
	.hospital-location {
	margin: 4px 0;
	font-size: 14px;
	color: #555;
}

.copy {
	padding: 4px 8px;
	font-size: 12px;
	margin-top: 4px;
	cursor: pointer;
}

.hospital-info-wrap {
	list-style: none;
	padding: 0;
	display: flex;
	gap: 8px;
	margin-top: 8px;
}

.hospital-info {
	background: #f0f0f0;
	padding: 4px 8px;
	border-radius: 4px;
	font-size: 12px;
}

.card-actions {
	display: flex;
	justify-content: flex-end;
	gap: 8px;
	padding: 0 16px 16px;
}

.top {
	display: flex;
}

.call-btn, .booking-btn {
	padding: 8px 16px;
	font-size: 14px;
	font-weight: bold;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

.call-btn {
	background: white;
	border: 1px solid #347eff;
	color: #347eff;
}

.booking-btn {
	background: #347eff;
	color: white;
}
</style>
</head>
<body>
	<div class="container">
	
		<main class="main-content">
			<section class="map-section">
				<div class="map-api">
					<!-- 실제 구현 시 카카오맵 또는 구글맵 embed -->
					<p style="text-align: center">[지도 영역]</p>
				</div>
			</section>

			<div class="search-area">
				<input class="search-box" placeholder="진료과, 병원명 검색해보세요..." />
			</div>

			<section class="hospital-list-section">
				<ul class="list-container">
					<!-- 추후 서버 연동 시 아래 구조를 반복 처리 -->
					<li class="hospital-card">
						<a href="#">
							<div class="card-image">
								<img src="/img/main01.png" alt="병원 이미지">
							</div>
							<div class="card-info">
								<div class="top">
									<h3 class="hospital-title">병원이름</h3>
									<p class="hospital-specialty">진료과목</p>
								</div>
								<div>
									<p class="hospital-status">병원 휴무 정보(이미지 대체 예정)</p>
									<p class="hospital-time">🕒 09:00 ~ 18:00</p>
								</div>
								<div>
									<p class="hospital-location">📍 병원 위치 정보</p>
									<button class="copy">복사</button>
								</div>
								<ul class="hospital-info-wrap">
									<li class="hospital-info">국가예방접종</li>
									<li class="hospital-info">주차장</li>
									<li class="hospital-info">전문의</li>
								</ul>
							</div>
						</a>
						<div class="card-actions">
							<button class="call-btn">전화하기</button>
							<button class="booking-btn">예약하기</button>
						</div>
					</li>
				</ul>
			</section>
		</main>
	</div>
</body>
</html>