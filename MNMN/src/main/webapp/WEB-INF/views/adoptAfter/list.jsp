<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>입양후기 게시판목록</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_adoptAfter.css" type="text/css">
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
	<article class="cards">
		<div class="row">
      <c:forEach var="adoptAfter" items="${list}">
      <div class="col-sm-12 col-md-6 col-xl-4" id="detail_card">
	      <div>
	         <h1><a href="afterDetail.do?after_num=${adoptAfter.after_num}">${adoptAfter.after_title}</a></h1>
	      </div>
	      <img src="${pageContext.request.contextPath}/upload/${adoptAfter.after_photo}" class="afterpet-img">
	      <div>
	         <span id="content">${adoptAfter.after_content}</span>
	         <small>${adoptAfter.after_date}</small>
	      </div>
      </div>
      </c:forEach>
      </div>
   </article>
	</c:if>
	<div class="align-center">
		${pagingHtml}
	</div>
</div>
</body>
</html>