<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신규 봉사 신청 목록</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<h2>봉사 신청 목록</h2>
	<div class="list-space align-right">
		<input type="button" value="홈으로" onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
	</div>
	<c:if test="${count == 0}">
	<div class="result-display">
		봉사 신청 내역이 없습니다.
	</div>
	</c:if>
	<c:if test="${count > 0}">
	<table>
		<tr>
			<th>신청자</th>
			<th>신청일</th>
			<th>봉사일</th>
			<th>봉사 시작 시간</th>
			<th>관리</th>
		</tr>
		<c:forEach var="volunteer" items="${list}">
		<tr>
			<td>${volunteer.vol_m_id}</td>
			<td>${volunteer.vol_reg_date}</td>
			<td>${volunteer.vol_date}</td>
			<td>${volunteer.vol_time}:00</td>
			<td><input type=button value="승인" onclick="location.href='confirmVolunteer.do?vol_num=${volunteer.vol_num}'"/>
			<input type=button value="삭제" onclick="location.href='notConfirmVolunteer.do?vol_num=${volunteer.vol_num}'"/></td>
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