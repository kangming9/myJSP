<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>반려동물 정보 수정</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		
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
	<h2>동물 수정 폼</h2>
	<form action="modifyPetDetail.do" method="post" enctype="multipart/form-data" id="modify_form" >
		<ul>
			<li>
				<label for="name">이름</label>
				<input type="text" name="name" id="name" maxlength="50" value="${pet.pet_name}">
			</li>
			<li>
				<label for="type">종류</label>
				<input type="text" name="type" id="type" maxlength="50" value="${pet.pet_type}">
			</li>
			<li>
				<label for="detail">소개글</label>
				<textarea rows="5" cols="30" name="detail" id="content">${pet.pet_detail}</textarea>
			</li>
			<li>
				<label for="photo">사진</label>
				<img src="${pageContext.request.contextPath}/upload/${pet.pet_photo}" width="100" height="100">
			</li>
		</ul>
		<div class="align-center">
			<input type="submit" value="수정">
			<input type="button" value="취소" onclick="location.href='petList.do'">
		</div>
	</form>
</div>
</body>
</html>