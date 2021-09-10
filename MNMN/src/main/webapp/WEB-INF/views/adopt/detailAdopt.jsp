<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>입양신청서</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<h2>입양신청서</h2>
	<ul>
		<li>신청번호 : ${adopt.adopt_num}</li>
		<li>신청인 : ${adopt.adopt_member_id}</li>
		<c:choose> 
			<c:when test="${adopt.adopt_married == 0}">
				<li>결혼여부 : 미혼</li> 
			</c:when> 
			<c:when test="${adopt.adopt_married == 1}">
				<li>결혼여부 : 결혼예정 </li>
			</c:when>
			<c:when test="${adopt.adopt_married == 2}">
				<li>결혼여부 : 기혼 </li>
			</c:when>  
		</c:choose> 
		<li>거주형태 : ${adopt.adopt_house}</li>
		<li>신청일 : ${adopt.adopt_date}</li>
	</ul>
	<hr size="1" noshade width="100%">
	<p>
		${adopt.adopt_intro}
	</p>
	<hr size="1" noshade width="100%">
	<div class="align-right">
		<input type="button" value="승인" onclick="location.href='approveAdopt.do'">
		<input type="button" value="반려" onclick="location.href='rejectAdopt.do'">
		<input type="button" value="목록" onclick="location.href='listAdopt.do'">
	</div>
</div>
</body>
</html>