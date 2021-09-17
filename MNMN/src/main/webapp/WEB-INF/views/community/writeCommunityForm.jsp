<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 글쓰기</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_com_write_modify.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_footer.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		//이벤트 연결
		$('#write_form').submit(function(){
			if($('#title').val().trim()==''){
				alert('제목을 입력하세요!');
				$('#title').val('').focus();
				return false;
			}
			if($('#content').val().trim()==''){
				alert('내용을 입력하세요!');
				$('#content').val('').focus();
				return false;
			}
			if($('#title').val().length > 60){
				alert("제목의 길이가 너무 깁니다!");
				$('#title').val('').focus();
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
	<h2 class="title">게시판 글쓰기</h2>
	<hr size="1" width="90%">
	<form id="write_form" action="writeCommunity.do" method="post" class="form-css">
		<ul>
			<li class="li-background">
				<label for="title" class="label-detail">
					<span class="line-color">&ensp;</span>&ensp;&ensp; 제목
				</label>
				<input type="text" name="com_title" id="title" size="33" maxlength="50">
			</li>
			<li class="li-background">
				<label for="content" class="label-detail"><span class="line-color">&ensp;</span>&ensp;&ensp; 내용</label>
				<textarea rows="5" cols="30" name="com_content" id="content" placeholder="회원 간 욕설이나 폭력적인 언어는 삼가해 주세요"></textarea>
			</li>
		</ul>
		<div class="align-center">
			<input type="submit" value="등록" class="btn-style">
			<input type="button" value="목록" onclick="location.href='communityList.do'" class="btn-style-cancel">
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