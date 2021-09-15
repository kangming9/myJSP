<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>입양후기 게시판 글수정 폼</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_adoptAfter.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_footer.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap/bootstrap.min.css">
<script type="text/javascript">
	$(document).ready(function(){
		$('#modify_form').submit(function(){
			if($('#after_title').val().trim()==''){
				alert('제목을 입력해주세요.');
				$('#after_title').val('').focus();
				return false;
			}
			if($('#after_content').val().trim()==''){
				alert('내용을 입력해주세요.');
				$('#after_content').val('').focus();
				return false;
			}
		
		});
	});
</script>
<style type="text/css">
 *:focus { outline:none; }
</style>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<p>
		<p class="tag">입양후기 게시판</p>
		<form id="modify_form" action="afterModify.do" method="post" enctype="multipart/form-data">
			<input type="hidden" name="after_num" value="${after.after_num}">
			<ul id="ul_border">
				<li>
		            <input type="text" name="after_title" id="after_title" maxlength="20" 
		                  value="${after.after_title}" placeholder="제목을 입력해 주세요.">
	            </li>
	            <hr noshade="noshade">
				<li>
						<br>
						<div contenteditable="true">
						<img src="${pageContext.request.contextPath}/upload/${after.after_photo}" class="detail-img" id="modify_img">
						</div>
						<br>
						<textarea rows="20" cols="50" name="after_content" id="after_content" 
						          placeholder="입양된 아이들의 예쁜 모습을 담은 사진을 함께 올려주세요" >${after.after_content}</textarea>
				</li>
			</ul>
			 <hr noshade="noshade">
			<div class="align-right">
				<label for="after_photo" class="btn btn-outline-dark">파일업로드</label>
					<input type="file" name="after_photo" id="after_photo" accept="image/gif,image/png,image/jpeg">
				<input type="submit" value="등록" class="btn btn-outline-dark">
				<input type="button" value="목록" class="btn btn-outline-dark" onclick="location.href='list.do'">
			</div>
		</form>
			<!-- footer 시작 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	<!-- footer 끝 -->
	</div>
	<p>
</body>
</html>