<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>MEDIFLOW</title>
<link rel="stylesheet" href="/css/common.css" />
<link rel="stylesheet" href="/css/hospitalMain.css" />
<!-- 아이콘 css -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" />
<!-- copy Button 전용 외부 CSS, Script -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@shoelace-style/shoelace@2.20.1/cdn/themes/light.css" />
<script type="module" src="https://cdn.jsdelivr.net/npm/@shoelace-style/shoelace@2.20.1/cdn/shoelace-autoloader.js"></script>
<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- SweetAlert2 CDN -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
$(document).ready(function(){
    $(".call-btn").on("click", function(){
        const phone = $(this).data("phone");
        const name = $(this).data("name");
        Swal.fire({
            title: name,
            text: phone ? phone : '등록된 전화번호가 없습니다.',
            icon: phone ? 'info' : 'warning',
            confirmButtonText: '확인',
            confirmButtonColor: '#568BFF',
           
        });
    });
});

$(function(){
    $(".hospital-card").on("click", function(e){
        // 버튼이나 복사 버튼 클릭 시에는 동작 안 함
        if ($(e.target).closest(".call-btn, sl-copy-button").length) return;

        // 상세 페이지로 이동
        var hNum = $(this).data("hnum");
        location.href = "/hospital/detail?hNum=" + hNum;
    });
});
</script>
</head>
<body>
	<div class="inner">
		<jsp:include page="/components/header.jsp" />

		<main class="main-content">
			<form action="/hospital/search/result" method="get" class="search-form">
				<div class="custom-select-wrap">
					<select name="searchType" id="search-type" class="custom-select">
						<option value="all" disabled selected>선택하세요</option>
						<option value="hospitalName" >병원이름</option>
						<option value="location" >지역</option>
						<option value="specialty" >진료과목</option>
					</select>
					<span class="material-symbols-outlined icon-arrow">keyboard_arrow_right</span>
				</div>
			    <div class="search-input-wrap">
			        <input type="text"  name="keyword" id="search-keyword" class="search-input"  value="${param.keyword}" placeholder="병원이름, 지역, 진료과 검색해보세요">
			        <button type="submit" class="search-button">
			            <span class="material-symbols-outlined">search</span>
			        </button>
			    </div>				
			</form>
			
			<section class="map-section">
				<div id="map" class="map-api">
					<p style="text-align: center">[지도 영역]</p>
				</div>
			</section>

			<section class="hospital-list-section">
				<ul class="list-container">
					<c:choose>
						<c:when test="${isEmpty}">
							<div class="no-result">
								<p class="isEmpty-text">
									<strong>‘${param.keyword}’</strong> 에 대한 검색 결과가 없습니다.
								</p>
							</div>
						</c:when>
						<c:otherwise>
							<c:forEach var="hospital" items="${hospitalList}">
								<li class="hospital-card" data-hnum="${hospital.hNum}">
									<div class="card-wrap">
										<div class="card-image">
											<img src="${hospital.hUrl}" alt="병원 이미지">
										</div>
										<div class="card-info">
											<div class="card-detail">
												<div class="top-title">
													<h3 class="hospital-title">${hospital.hTitle}</h3>
													<p class="hospital-specialty">${hospital.hDepartment}</p>
												</div>
												<div class="middle-state">
													<img src="/img/MedicalStatement_ing.png" alt="병원 상태">
													<p class="hospital-time">🕒 09:00 ~ 18:00</p>
												</div>
												<div class="bottom-info">
													<p class="hospital-location" id="location-${hospital.hNum}">${hospital.hAddress}</p>
													<sl-copy-button id="copyBtn" from="location-${hospital.hNum}" copy-label="클릭하여 복사하기" success-label="복사하였습니다." error-label="이런, 복사에 실패하였습니다!"> 
													</sl-copy-button>
												</div>
												<ul class="hospital-info-wrap">
													<li class="hospital-info">국가예방접종</li>
													<li class="hospital-info">주차장</li>
													<li class="hospital-info">전문의</li>
												</ul>
											</div>
											<div class="card-actions">
												<button class="call-btn" data-phone="${hospital.hTel}" data-name="${hospital.hTitle}">전화하기</button>
												<button class="booking-btn" >예약하기</button>
											</div>
										</div>
									</div>
								</li>														
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</ul>
			</section>
		</main>
	</div>
	<jsp:include page="/components/footer.jsp" />
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

//===== utils =====
const sleep = (ms) => new Promise(r => setTimeout(r, ms));
const jitter = (ms) => Math.floor(Math.random() * ms); // 0~ms 랜덤 지터

// localStorage 캐시 (주소 -> {lat,lng,ts})
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

/**
 * 순차 지오코딩 + 전역 백오프 + 캐시
 */
async function geocodeAll(addresses, map, {
  baseDelayMs = 800,        // 정상 간격(늘렸습니다)
  baseJitterMs = 300,       // 간격에 랜덤 지터 추가
  pauseOnErrorMs = 60_000,  // ERROR 시 전체 일시정지(1분)
  backoffStartMs = 10_000,  // 첫 백오프 10초
  backoffMaxMs = 120_000,   // 최대 2분
  maxRetriesPerAddress = 2, // 주소별 재시도 횟수
} = {}) {
  const geocoder = new kakao.maps.services.Geocoder();
  const bounds = new kakao.maps.LatLngBounds();
  const infoWindows = [];
  const seen = new Set();
  const cache = loadCache();

  // 중복 제거
  const unique = addresses.filter(a => !!a && !seen.has(a) && seen.add(a));

  // 전역 백오프/일시정지 상태
  let globalPauseUntil = 0;
  let nextBackoffMs = backoffStartMs;

  const useCached = (address) => {
    const c = cache[address];
    if (!c) return null;
    if (typeof c.lat !== 'number' || typeof c.lng !== 'number') return null;
    return c;
  };

  for (const address of unique) {
    // 전역 일시정지 중이면 재개 시점까지 대기
    const now = Date.now();
    if (globalPauseUntil > now) {
      await sleep(globalPauseUntil - now);
    }

    // 캐시 있으면 호출 없이 바로 마커
    const cached = useCached(address);
    if (cached) {
      const pos = new kakao.maps.LatLng(cached.lat, cached.lng);
      bounds.extend(pos);
      const marker = new kakao.maps.Marker({ map, position: pos, title: address });
      const iw = new kakao.maps.InfoWindow({ content: '<div class="kakao-iw">' + address + '</div>' });
      infoWindows.push(iw);
      kakao.maps.event.addListener(marker, 'click', () => {
        infoWindows.forEach(x => x.close());
        iw.open(map, marker);
      });
      continue; // 다음 주소
    }

    // 정상 호출 간격 + 지터
    await sleep(baseDelayMs + jitter(baseJitterMs));

    // 주소별 재시도 루프
    let attempt = 0;
    let done = false;

    while (!done && attempt <= maxRetriesPerAddress) {
      const { result, status } = await geocodeOnce(geocoder, address);

      if (status === kakao.maps.services.Status.OK) {
        const lat = parseFloat(result[0].y);
        const lng = parseFloat(result[0].x);
        const pos = new kakao.maps.LatLng(lat, lng);
        bounds.extend(pos);

        // 캐시에 저장
        cache[address] = { lat, lng, ts: Date.now() };
        saveCache(cache);

        const marker = new kakao.maps.Marker({ map, position: pos, title: address });
        const iw = new kakao.maps.InfoWindow({ content: '<div class="kakao-iw">' + address + '</div>' });
        infoWindows.push(iw);
        kakao.maps.event.addListener(marker, 'click', () => {
          infoWindows.forEach(x => x.close());
          iw.open(map, marker);
        });

        // 성공하면 전역 일시정지/백오프 해제
        globalPauseUntil = 0;
        nextBackoffMs = backoffStartMs;
        done = true;

      } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
        console.warn('[Geocode ZERO_RESULT]', address);
        done = true;

      } else { // kakao.maps.services.Status.ERROR (429 포함 가능)
        attempt++;

        // 전역 일시정지: 지금부터 pauseOnErrorMs 동안 큐 전체 멈춤
        globalPauseUntil = Date.now() + pauseOnErrorMs;

        console.warn(`[Geocode ERROR] global pause ${pauseOnErrorMs}ms; retry #${attempt} :`, address);

        if (attempt > maxRetriesPerAddress) {
          console.warn('[Geocode ERROR: give up]', address);
          break;
        }

        // 개별 백오프(추가 대기)도 줌
        await sleep(nextBackoffMs);
        nextBackoffMs = Math.min(nextBackoffMs * 2, backoffMaxMs);
      }
    }
  }

  if (!bounds.isEmpty()) {
    map.setBounds(bounds);
  }
}
async function initMap() {
	  const mapEl = document.getElementById('map');
	  if (!mapEl) return;

	  const map = new kakao.maps.Map(mapEl, {
	    center: new kakao.maps.LatLng(37.5665, 126.9780),
	    level: 5
	  });

	  const addresses = collectAddresses();
	  if (!addresses?.length) return;

	  await geocodeAll(addresses, map, {
	    baseDelayMs: 800,
	    baseJitterMs: 300,
	    pauseOnErrorMs: 60_000,   // 1분 멈춤
	    backoffStartMs: 10_000,
	    backoffMaxMs: 120_000,
	    maxRetriesPerAddress: 2
	  });
	}
// 🔄 이 시점에서 kakao가 아직 정의 안 됐으므로 SDK 동적 로딩
window.onload = loadKakaoMap;
</script>
</body>
</html>