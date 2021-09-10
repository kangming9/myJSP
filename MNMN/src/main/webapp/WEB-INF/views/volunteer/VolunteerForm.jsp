<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>힘드냥 도울개</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="align-center vol_button_group">
		<input type="button" value="신청" class="button_vol" id="req_vol"
			        onclick="location.href='${pageContext.request.contextPath}/volunteer/volunteerUserForm.do'">
		<input type="button" value="취소" class="button_vol" id="can_vol"
			        onclick="location.href='${pageContext.request.contextPath}/volunteer/volunteerCancelForm.do'"><br>
	</div>
	<div class="align-center">
		<input type="button" value="홈으로" id="button_home"
			        onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
	</div>
</body>
</html>