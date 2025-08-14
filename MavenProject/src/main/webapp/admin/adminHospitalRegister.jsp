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
<link rel="stylesheet" href="/css/adminHospitalRegister.css" />

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<div class="wrapper">
 <%-- 사이드바 include --%>
    <jsp:include page="/components/sidebar.jsp" />
	<div class="main">
		<div class="top-bar">
			<div class="logout"><a href="/logout">로그아웃</a></div>
		</div>
		<form action="/admin/hospitalRegister" method="post" enctype="multipart/form-data" >
			<label class="text-label">이미지 등록<font size="2" color="red">※썸네일 사진으로 등록됩니다.</font></label>
			<div class="register-container">
				<label for="uploadFile" class="image-form" >
					<div class="image-upload">
							<p class="image-label">사진을 등록해 주세요.</p>
					        <img class="uploadImg" src="/img/fileUpload.webp" alt="사진을 등록해 주세요." />
					    <input id="uploadFile" name="uploadFile" type="file" style="display: none;"/>
					</div>
   				</label>
				<div class="data-container">
					<div class="textbox-container">
						<div class="form-row">
							<label class="text-label">진료과목</label>
							<input type="text" name="hDepartment" placeholder="진료과목을 입력해주세요.">
						</div>
						<div class="form-row">
							<label class="text-label">병원구역</label>
							<input type="text" name="hDistrict" placeholder="병원구역을 입력해주세요. ex) 마포구">
						</div>
						<div class="form-row">
							<label class="text-label">병원이름</label>
							<input type="text" name="hTitle" placeholder="병원이름을 입력해주세요.">
						</div>
						<div class="form-row">
							<label class="text-label">전화번호</label>
							<input type="text" name="hTel" placeholder="전화번호를 입력해주세요. ex) 02-123-4567">
						</div>
						<div class="form-row full-width">
							<label class="text-label">병원주소</label>
							<input type="text" name="hAddress" placeholder="병원주소를 입력해주세요.">
						</div>
					</div>
					<div class="textarea-container">
						<div class="form-row full-width">
							<label class="text-label">병원소개<font size="2" color="red">※글자는 최대 1000자 까지 작성 가능합니다.</font></label>
							<textarea name="hContent" placeholder="상세내용을 입력해주세요." cols="60" rows="10" maxlength="1000"></textarea>
						</div>
					</div>
				</div>
			</div>
			<div class="submit-container">
				<input type="submit" value="등록">
			</div>
		</form>
	</div>
</div>
</body>
<script>
$(function () {
    $('#uploadFile').on('change', function (e) {
      const file = e.target.files[0];
      const $label = $('.image-label');
      const $preview = $('.uploadImg');

      if (file) {
        const reader = new FileReader();

        reader.onload = function (e) {
          $preview.attr('src', e.target.result);
          $preview.css({
        	  width: '100%',
        	  height: '100%'
        	});
          $label.css('display','none');
        };

        reader.readAsDataURL(file);
      }
    });
 });
</script>
</html>