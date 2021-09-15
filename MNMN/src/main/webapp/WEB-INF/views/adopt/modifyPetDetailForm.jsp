<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>반려동물 정보 수정</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_pet.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_footer.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$('#photo_btn').click(function(){
			$('#photo_choice').show();
			$(this).hide();
		});
		
		//이미지 미리 보기
		var photo_path;
		var pet_photo;
		var new_photo;
		$('#photo').change(function(){
			var photo = document.getElementById('photo');
			pet_photo = photo.files[0];
			new_photo = pet_photo.name;
			if(pet_photo){
				var reader = new FileReader();
				reader.readAsDataURL(pet_photo);
				
				reader.onload=function(){
					photo_path = $('.pet-photo').attr('src');//이미지 미리보기 전 이미지 저장
					$('.pet-photo').attr('src',reader.result);
				};
			}
		});
		
		//이미지 전송
		$('#photo_submit').click(function(){
			if($('#photo').val()==''){
				alert('파일을 선택하세요!');
				$('#photo').focus();
				return;
			}
			alert('사진이 변경되었습니다.');
		});
		
		//이미지 미리보기 취소
		$('#photo_reset').click(function(){
			//이미지 미리보기 전 이미지로 되돌리기
			$('.pet-photo').attr('src',photo_path);
			$('#photo').val('');
			$('#photo_choice').hide();
			$('#photo_btn').show();
		});
		
		
		$('#modify_form').submit(function(){
			if($('#name').val().trim()==''){
				alert('이름을 입력하세요!');
				$('#name').val('').focus();
				return false;
			}
			if($('#type').val().trim()==''){
				alert('품종을 입력하세요!');
				$('#type').val('').focus();
				return false;
			}
			if($('#content').val().trim()==''){
				alert('소개글을 입력하세요!');
				$('#content').val('').focus();
				return false;
			}
			
		});
		
	});
</script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="wrap">
	<h2 class="title">동물 친구 정보 수정</h2>
	<form class="form-css" action="modifyPetDetail.do" method="post" enctype="multipart/form-data" id="modify_form" >
		<input type="hidden" name="num" value="${pet.pet_num}">
		<ul class="form-content">
			<li>
				<label for="name">이름</label>
				<input type="text" name="name" id="name" maxlength="50" value="${pet.pet_name}">
			</li>
			<li>
				<label for="type">종류</label>
				<input type="text" name="type" id="type" maxlength="50" value="${pet.pet_type}">
			</li>
			<li>
				<label for="detail" id="detail">소개글</label>
				<textarea rows="5" cols="27" name="detail" id="content">${pet.pet_detail}</textarea>
			</li>
			<li>
				<label for="photo" id="photo-modify-label">사진</label>
				<img src="${pageContext.request.contextPath}/upload/${pet.pet_photo}" width="100" height="100" class="pet-photo">
			</li>
			<li>
				<div class="align-center">
					<input type="button" value="변경" id="photo_btn" class="btn-style-modify">
				</div>
				<div id="photo-choice-btn">
				<div id="photo_choice" style="display:none;">
					<input type="file" id="photo" name="photoname" accept="image/gif,image/png,image/jpeg"><br>
					<input type="button" value="전송" id="photo_submit" class="btn-style">
					<input type="button" value="취소" id="photo_reset" class="btn-style-cancel">
				</div>
				</div>
			</li>
		</ul>
		<div class="form-button">
		<div class="align-center">
			<input type="submit" value="수정" class="btn-style">
			<input type="button" value="취소" onclick="location.href='petList.do'" class="btn-style-cancel">
		</div>
		</div>
	</form>
	</div>
		<!-- footer 시작 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	<!-- footer 끝 -->
</div>
</body>
</html>