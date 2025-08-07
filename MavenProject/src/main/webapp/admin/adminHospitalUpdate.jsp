<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="activeMenu" value="hospital" scope="request"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>

<link rel="stylesheet" href="/css/common.css" />
<link rel="stylesheet" href="/css/adminHospitalUpdate.css" />

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
/* h1 {
	color: var(--primary-color);
} */

</style>
</head>
<body>
<div class="wrapper">
 <%-- 사이드바 include --%>
    <jsp:include page="/components/sidebar.jsp" />
	<div class="main">
		<div class="top-bar">
			<div class="logout"><a href="/logout">로그아웃</a></div>
		</div>
		<form id="myForm" action="/admin/hospitalUpdate" method="post" enctype="multipart/form-data" >
			<label class="text-label">이미지</label>
			<div class="register-container">
				<div class="image-upload">
			        <img class="uploadImg" src="${hospital.hUrl}"/>
				</div>
				<div class="data-container">
					<div class="textbox-container">
						<div class="form-row">
							<input type="hidden" name="hNum" value="${hospital.hNum}">
							<label class="text-label">진료과목</label>
							<input type="text" name="hDepartment" placeholder="진료과목을 입력해주세요." value="${hospital.hDepartment}">
						</div>
						<div class="form-row">
							<label class="text-label">병원구역</label>
							<input type="text" name="hDistrict" placeholder="병원구역을 입력해주세요. ex) 마포구" value="${hospital.hDistrict}">
						</div>
						<div class="form-row">
							<label class="text-label">병원이름</label>
							<input type="text" name="hTitle" placeholder="병원이름을 입력해주세요." value="${hospital.hTitle}">
						</div>
						<div class="form-row">
							<label class="text-label">전화번호</label>
							<input type="text" name="hTel" placeholder="전화번호를 입력해주세요. ex) 02-123-4567" value="${hospital.hTel}">
						</div>
						<div class="form-row full-width">
							<label class="text-label">병원주소</label>
							<input type="text" name="hAddress" placeholder="병원주소를 입력해주세요." value="${hospital.hAddress}">
						</div>
					</div>
					<div class="textarea-container">
						<div class="form-row full-width">
							<label class="text-label">병원소개<font size="2" color="red">※글자는 최대 1000자 까지 작성 가능합니다.</font></label>
							<textarea name="hContent" placeholder="상세내용을 입력해주세요." cols="60" rows="10" maxlength="1000">${hospital.hContent}</textarea>
						</div>
					</div>
				</div>
			</div>
			<div class="submit-container">
				<input type="submit" value="수정">
			</div>
		</form>
	</div>
</div>
<!-- 모달창   -->
<div id="myModal" class="modal" style="display: none;">
	<div class="modal-content">
		<div class="modal-title">
				<p>정보가 수정되었습니다.</p>
		</div>
		<div class="modal-button">
				<button id="confirmNo">닫기</button>	
		</div>
	</div>
</div>
</body>
<script>
let formRef = null;
$('#myForm').on('submit',function(e){
	e.preventDefault();
	formRef=this;
	$('#myModal').show();
});

$('#confirmNo').click(function(){
    $('#myModal').hide(); // 모달 닫기
    formRef.submit(); // 수동으로 폼 제출
  });
</script>
</html>