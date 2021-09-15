<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_login.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_footer.css" type="text/css">
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script> 
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$('#login_form').submit(function(){
			if($('#id').val().trim()==''){
				alert('아이디를 입력하세요!');
				$('#id').focus();
				$('#id').val('');
				return false;
			}
			if($('#passwd').val().trim()==''){
				alert('비밀번호를 입력하세요!');
				$('#passwd').focus();
				$('#passwd').val('');
				return false;
			}
		});
	});
</script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="login-container">
		<form id="login_form" action="login.do" method="post" autocomplete="off">
			<h3>어서오시개</h3>
			<div class="logo"><img alt="멍냥멍냥 입양센터 로고" src="${pageContext.request.contextPath}/images/MN_logo.png" width=200px></div>
			<div class="login-content">
				<div class="align-center field">
					<label for="id"><i class="fas fa-user fa-lg"></i></label>
					<input type="text" name="id" id="id" maxlength="12" placeholder="ID">
				</div>
				<div class="align-center field">
					<label for="passwd"><i class="fas fa-lock fa-lg"></i></label>
					<input type="password" name="passwd" id="passwd" maxlength="12" placeholder="PASSWORD">
				</div>
				<div class="align-center">
					<input type="submit" value="로그인" class="sign btn">
				</div>
				<div class="align-center">
					<input type="button" value="회원가입" onclick="location.href='registerUserForm.do'" class="signup"> l
					<input type="button" value="홈으로" onclick="location.href='${pageContext.request.contextPath}/main/main.do'" class="cancel">
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