<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>입양 동물 리스트</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
</head>
<body>			
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<h2>입양 동물 리스트</h2>
	<c:if test="${user_grade == 1}">
	<div class="align-right">
		<input type="button" value="동물 등록" onclick="location.href='registerPetForm.do'">
		<input type="button" value="동물 수정" onclick="location.href=''">
		<input type="button" value="동물 삭제" onclick="location.href=''">
	</div>
	</c:if>
	<c:if test="${count == 0}">
	<div class="result-display">
		모든 친구들이 가족을 만났어요!
	</div>
	</c:if>
	<c:if test="${count > 0}">
	<table>
	<c:forEach var="pet" items="${list}">
		<tr>
			<td width="300px"><a href="petDetail.do?pet_num=${pet.pet_num}"><img src="${pageContext.request.contextPath}/upload/${pet.pet_photo}" class="list-img"></a></td>
			<td>${pet.pet_num}<br>
			${pet.pet_name}<br>
			${pet.pet_date}</td>
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