<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>입양후기 작성폼</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_adoptAfter.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap/bootstrap.min.css">
<script type="text/javascript">
	$(document).ready(function(){
		$('#write_form').submit(function(){
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
			if($('#after_photo').val().trim()==''){
				alert('사진을 첨부해주세요.');
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
	<P>
	<p class="tag">입양후기 게시판</p>
	<form id="write_form" action="write.do" method="post" enctype="multipart/form-data">
		<ul id="ul_border">
			<li>
				<input type="text" name="after_title" id="after_title" maxlength="30" placeholder="제목을 입력해 주세요.">
			</li>
			<hr noshade="noshade">
			<li>
				<textarea rows="20" cols="50" name="after_content" id="after_content" placeholder="입양된 아이들의 예쁜 모습을 담은 사진을 함께 올려주세요"></textarea>
			</li>
		</ul>
		<hr noshade="noshade">
		<div class="align-right">
			<label for="after_photo" class="btn btn-outline-dark">파일업로드</label>
				<input type="file" name="after_photo" id="after_photo" accept="image/gif,image/png,image/jpeg">
			<input type="submit" value="등록" class="btn btn-outline-dark">
			<input type="button" value="목록" onclick="location.href='list.do'" class="btn btn-outline-dark">
		</div>
	</form>
</div>
<p>
</body>
</html>