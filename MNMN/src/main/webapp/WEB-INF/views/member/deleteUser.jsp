<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${check == true}">    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴 완료</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_signup.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_footer.css" type="text/css">
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="result-display">
		<div class="result-content">
			<div>회원 탈퇴가 완료되었습니다.</div>
			<input type="button" value="홈으로" onclick="location.href='${pageContext.request.contextPath}/main/main.do'" class="home_btn">
		</div>
	</div>
		<!-- footer 시작 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	<!-- footer 끝 -->
</div>
</body>
</html>
</c:if>
<c:if test="${check == false}">
	<script>
		alert('아이디와 비밀번호를 정확히 입력해 주세요.');
		history.go(-1);
	</script>
</c:if>