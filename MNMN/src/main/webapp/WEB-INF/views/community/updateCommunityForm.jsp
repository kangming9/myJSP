<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_com_write_modify.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_footer.css" type="text/css">
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
	<div class="container">
	<div class="box">
	<h2 class="title">게시글 수정</h2>
	<hr size="1" width="90%">
	<form action="updateCommunity.do" method="post" id="update_form" class="form-css">
		<input type="hidden" name="com_num" value="${com.com_num}">
		<input type="hidden" name="com_member_num" value="${user_num}">
		<ul>
			<li class="li-background">
				<label for="content" class="label-detail"><span class="line-color">&ensp;</span>&ensp;&ensp; 제목</label>
				<input type="text" name="com_title" id="com_title" size="33" maxlength="50" value="${com.com_title}">
			</li>
			<li class="li-background">
				<label for="content" class="label-detail"><span class="line-color">&ensp;</span>&ensp;&ensp; 내용</label>
				<textarea rows="5" cols="30" name="com_content" id="com_content">${com.com_content}</textarea>
			</li>
		</ul>
		<div class="align-center">
			<input type="submit" value="수정" class="btn-style">
			<input type="button" value="취소" onclick="location.href='communityList.do'" class="btn-style-cancel">
		</div>
	</form>
	</div>
</div>
	<!-- footer 시작 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	<!-- footer 끝 -->
</div>
</body>
</html>