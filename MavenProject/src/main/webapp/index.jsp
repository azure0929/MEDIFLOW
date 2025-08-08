<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MEDIFLOW</title>

<link rel="stylesheet" href="/css/common.css" />
<link rel="stylesheet" href="/css/index.css" />

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	$(() => {
		$('#selectpain-wrap').hide();
		
		$('.location-btn').on('click', function(e) {
			e.preventDefault();
			$('.location-btn').removeClass('active');
			$(this).addClass('active');
			
			const index = $(this).index();
	    if (index === 0 || index === 1 || index === 2) {
	      $('#selectlocation-wrap').fadeOut(200, () => {
	        $('#selectpain-wrap').fadeIn(300);
	      });
	    }
		})
		
		$('.pain-btn').on('click', function() {
			$('.pain-btn').removeClass('active');
			$(this).addClass('active');
		})
	})
</script>

</head>
<body>

	<div id="wrap">
		<jsp:include page="components/header.jsp" />
		<main class="main">
			<div class="content">
				<%
					if (session.getAttribute("loggedInMember") != null) {
				%>
				<div id="selectlocation-wrap">
					<div class="question">
						<h4 class="questioninfo">
							어느 지역으로 병원을 알아보시나요? <br />
							<span class="selectquestion">"지역을 선택해주세요."</span>
						</h4>
					</div>
					<div class="location-buttons">
						<button class="location-btn">마포구</button>
						<button class="location-btn">구로구</button>
						<button class="location-btn">성북구</button>
					</div>
				</div>
				<%
					} else {
				%>
				<p	>
					반갑습니다! <br />
					<span>메디플로우</span>입니다
				</p>
				<div class="link">
					<a href="/member/login.jsp">로그인</a>
					<a href="/member/memberRegister.jsp">회원가입</a>
				</div>
				<%
					}
				%>
				<div id="selectpain-wrap">
					<div class="question">
						<h4 class="questioninfo">
							아프신 부위를 선택해주세요.<br />
							<span class="selectquestion">“어디가 아프신가요?”</span>
						</h4>
					</div>
					<div class="pain-buttons">
						<button class="pain-btn" value="">목</button>
						<button class="pain-btn">허</button>
						<button class="pain-btn">머</button>
						<button class="pain-btn">어깨</button>
						<button class="pain-btn">치아</button>
						<button class="pain-btn">무릎</button>
						<button class="pain-btn">손목</button>
						<button class="pain-btn">배</button>
					</div>
				</div>
			</div>
		</main>
	</div>

</body>
</html>