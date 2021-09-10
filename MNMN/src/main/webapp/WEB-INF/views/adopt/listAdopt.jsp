<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신규 입양 신청 목록</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<h2>신규 입양 신청 목록</h2>
	<div class="list-space align-right">
		<input type="button" value="홈으로" onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
	</div>
	<c:if test="${count == 0}">
	<div class="result-display">
		입양 신청 내역이 없습니다.
	</div>
	</c:if>
	<c:if test="${count > 0}">
	<table>
		<tr>
			<th>신청자</th>
			<th>희망입양동물</th>
			<th>신청일</th>
		</tr>
		<c:forEach var="adopt" items="${list}">
		<tr>
			<td><a href="detailAdopt.do?adopt_num=${adopt.adopt_num}">${adopt.adopt_member_id}</a></td>
			<th>${adopt.adopt_pet_name}</th>
			<td>${adopt.adopt_date}</td>
		</tr>
		</c:forEach>
	</table>
	<div class="align-center">
		${pagingHtml}
	</div>
	</c:if>
</div>
</body>
</html>