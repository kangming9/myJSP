<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		//유효성 체크
		$('#update_form').submit(function(){
			if($('#com_title').val().trim()==''){
				alert('제목을 입력하세요!');
				$('#com_title').val('').focus();
				return false;
			}
			if($('#com_content').val().trim()==''){
				alert('글 내용을 입력하세요!');
				$('#com_content').val('').focus();
				return false;
			}
			
		});
		
	});
</script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<h2>게시글 수정</h2>
	<form action="updateCommunity.do" method="post" enctype="multipart/form-data" id="update_form" >
		<input type="hidden" name="com_num" value="${com.com_num}">
		<input type="hidden" name="com_member_num" value="${user_num}">
		<ul>
			<li>
				<label for="com_title">제목</label>
				<input type="text" name="com_title" id="com_title" maxlength="50" value="${com.com_title}">
			</li>
			<li>
				<label for="com_content">소개글</label>
				<textarea rows="5" cols="30" name="com_content" id="com_content">${com.com_content}</textarea>
			</li>
		</ul>
		<div class="align-center">
			<input type="submit" value="게시글 수정">
			<input type="button" value="취소" onclick="location.href='communityList.do'">
		</div>
	</form>
</div>
</body>
</html>