<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>입양후기 작성폼</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
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
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<h2>입양 후기 글작성</h2>
	<form id="write_form" action="write.do" method="post" enctype="multipart/form-data">
		<ul>
			<li>
				<label for="after_title">제목</label>
				<input type="text" name="after_title" id="after_title" maxlength="30" placeholder="제목을 입력해 주세요.">
			</li>
			<li>
				<label for="after_content">내용</label>
				<textarea rows="30" cols="60" name="after_content" id="after_content" placeholder="입양된 아이들의 예쁜 모습을 담은 사진을 함께 올려주세요"></textarea>
			</li>
			<li>
				<label for="after_photo"></label>
				<input type="file" name="after_photo" id="after_photo" accept="image/gif,image/png,image/jpeg">
			</li>
		</ul>
		<div class="align-center">
			<input type="submit" value="등록">
			<input type="button" value="목록" onclick="location.href='list.do'">
		</div>
	</form>
</div>
</body>
</html>