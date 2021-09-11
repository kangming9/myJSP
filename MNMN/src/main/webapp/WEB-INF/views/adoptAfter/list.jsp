<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>입양후기 게시판목록</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<h2>입양후기 게시판</h2>
	<div class="list-space align-right">
		<input type="button" value="글쓰기" onclick="location.href='${pageContext.request.contextPath}/adoptAfter/writeForm.do'"
			<c:if test="${empty user_num || user_grade=='3' || user_grade=='1'}">disabled="disabled"</c:if>
		>
	</div>
	<c:if test="${count == 0}">
	<div class="result-display">
		등록된 게시물이 없습니다.
	</div>
	</c:if>
	<c:if test="${count > 0 }">
	<table>
		<c:forEach var="adoptAfter" items="${list}">
		<tr>
			<td>
			<img src="${pageContext.request.contextPath}/upload/${adoptAfter.after_photo}" class="detail-img">
			</td>
			<td><a href="afterDetail.do?after_num=${adoptAfter.after_num}">${adoptAfter.after_title}</a></td>
			<td id="content">${adoptAfter.after_content}</td>
			<td>${adoptAfter.after_date}</td>
		</tr>
		</c:forEach>
	</table>
	</c:if>
	<div class="align-center">
		${pagingHtml}
	</div>
</div>
</body>
</html>