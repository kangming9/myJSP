<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>힘드냥 도울개</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="align-center">
		<input type="button" value="홈으로" 
			        onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
		<input type="button" value="신청" 
			        onclick="location.href='${pageContext.request.contextPath}/volunteer/volunteerUserForm.do'">
		<input type="button" value="취소" 
			        onclick="location.href='${pageContext.request.contextPath}/volunteer/volunteerCancelForm.do'">
	</div>
</body>
</html>