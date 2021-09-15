<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 완료</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_signup.css" type="text/css">
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="result-display">
		<div class="result-content">
			<div>회원가입이 완료되었습니다.<br></div>
			<input type="button" value="홈으로" onclick="location.href='${pageContext.request.contextPath}/main/main.do'" class="home_btn">
		</div>
	</div>
</div>
</body>
</html>