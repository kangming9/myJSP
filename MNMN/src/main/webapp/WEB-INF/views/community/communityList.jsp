<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 목록</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_comList.css" type="text/css">
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="container">
	<span id="title">게시판 목록</span>
	<div class="list-space align-right">
		<input class="button" type="button" value="글쓰기" onclick="location.href='writeCommunityForm.do'"
			<c:if test="${empty user_num}">disabled="disabled"</c:if>
		>
		<input class="button" type="button" value="목록" onclick="location.href='communityList.do'">
		<input class="button" type="button" value="홈으로" onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
	</div>
	<c:if test="${count == 0}">
	<div class="result-display">
		등록된 게시물이 없습니다.
	</div>
	</c:if>
	<c:if test="${count > 0}">
	<table>
		<tr>
			<th class="th">글번호</th>
			<th class="th">제목</th>
			<th class="th">작성자</th>
			<th class="th">작성일</th>
			<th class="th">조회</th>
		</tr>
		<c:forEach var="com" items="${list}">
		<tr>
			<td class="td" id="num">${com.com_num}</td>
			<td class="td" id="tit"><a id="title-css" href="communityDetail.do?com_num=${com.com_num}">${com.com_title}</a></td>
			<td class="td" id="member">${com.com_member_id }</td>
			<td class="td" id="date">${com.com_date}</td>
			<td class="td" id="see">${com.com_hit}</td>
		</tr>
		</c:forEach>
	</table>
	<div class="align-center">
		${pagingHtml}
	</div>
	</c:if>
	</div>
</div>
</body>
</html>