<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>        
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신규 동물친구 등록</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		
		$('#register_form').submit(function(){
			if($('#name').val().trim()==''){
				alert('이름을 입력하세요!');
				$('#name').val('').focus();
				return false;
			}
			if($('#type').val().trim()==''){
				alert('종을 입력하세요!');
				$('#type').val('').focus();
				return false;
			}
			if($('#content').val().trim()==''){
				alert('소개글을 입력하세요!');
				$('#content').val('').focus();
				return false;
			}
			if($('#photo').val().trim()==''){
				alert('사진을 첨부하세요!');
				$('#photo').val('').focus();
				return false;
			}
		});
		
	});
</script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<h2>신규 동물친구 등록</h2>
	<form id="register_form" action="registerPet.do" method="post" enctype="multipart/form-data">
		<ul>
			<li>
				<label for="name">이름</label>
				<input type="text" name="name" id="name" maxlength="50">
			</li>
			<li>
				<label for="type">종류</label>
				<input type="text" name="type" id="type" maxlength="50">
			</li>
			<li>
				<label for="detail">소개글</label>
				<textarea rows="5" cols="30" name="detail" id="content"></textarea>
			</li>
			<li>
				<label for="photo">사진</label>
				<input type="file" name="photo" id="photo">
			</li>
		</ul>
		<div class="align-center">
			<input type="submit" value="등록">
			<input type="button" value="취소" onclick="location.href='petList.do'">
		</div>
	</form>
</div>
</body>
</html>