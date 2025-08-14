<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="activeMenu" value="dashboard" scope="request" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>

<link rel="stylesheet" href="/css/common.css" />
<link rel="stylesheet" href="/css/adminDashboard.css" />
<link
	href="https://fonts.googleapis.com/css2?family=Pretendard&display=swap"
	rel="stylesheet">

<style>
#map {
	width: 100%;
	height: 350px;
	background: #eee; /* 회색 배경: 지도 로딩 확인용 */
}

canvas {
	font-family: 'Pretendard', 'Noto Sans KR', 'Malgun Gothic',
		sans-serif !important;
}
</style>
</head>

<body>
	<div class="wrapper">
		<%-- 사이드바 JSP 포함 --%>
		<jsp:include page="/components/sidebar.jsp" />

		<div class="main">
			<h2>📍 병원 위치 지도</h2>
			<div id="map"></div>
		</div>
	</div>
	<script>
function collectAddresses() {
	  const nodes = document.querySelectorAll('.hospital-location');
	  const addresses = [...nodes]
	    .map(el => el.dataset.address?.trim() || el.textContent.replace(/^📍\s*/, '').trim())
	    .filter(a => a && a.length > 0);

	  // (옵션) 중복 제거
	  return [...new Set(addresses)];
	}
  function loadKakaoMap() {
    const script = document.createElement('script');
    script.src = "https://dapi.kakao.com/v2/maps/sdk.js?appkey=05a7077a5f466aaa4ba854dc2c6e035a&autoload=false&libraries=services";
    script.onload = function () {
      console.log("✅ Kakao SDK 로딩 완료");
      kakao.maps.load(initMap); // 이제 kakao가 정의되어 있음
    };
    script.onerror = function () {
      console.error("❌ Kakao Maps SDK 로딩 실패");
    };
    document.head.appendChild(script);
  }

  function initMap() {
	  console.log("🗺 initMap 실행");

	  const geocoder = new kakao.maps.services.Geocoder();
	  const map = new kakao.maps.Map(document.getElementById('map'), {
	    center: new kakao.maps.LatLng(37.5665, 126.9780), // 임시 센터(시청)
	    level: 5
	  });
		
	  const addresses = [
	    "서울 동대문구 제기동 1054-1",
	    "서울 마포구 독막로 109",
	    "서울 성북구 정릉로 77",
	    "서울 구로구 구로동 125-1"
	  ];
	  //const addresses = collectAddresses();
	  const bounds = new kakao.maps.LatLngBounds();
	  const infoWindows = [];

	  addresses.forEach((address) => {
	    geocoder.addressSearch(address, function(result, status) {
	      if (status !== kakao.maps.services.Status.OK) return;

	      const coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	      bounds.extend(coords);

	      const marker = new kakao.maps.Marker({
	        map: map,
	        position: coords
	      });

	      const infowindow = new kakao.maps.InfoWindow({
	        content: `<div style="padding:5px;font-size:13px;">${address}</div>`
	      });
	      infoWindows.push(infowindow);

	      // 마커 클릭 시 해당 인포윈도우만 열리게
	      kakao.maps.event.addListener(marker, 'click', function() {
	        infoWindows.forEach(iw => iw.close());
	        infowindow.open(map, marker);
	      });

	      // 모든 마커가 보이도록 영역 맞춤
	      map.setBounds(bounds);
	    });
	  });
	}

  // 🔄 이 시점에서 kakao가 아직 정의 안 됐으므로 SDK 동적 로딩
  window.onload = loadKakaoMap;
</script>

</body>
</html>