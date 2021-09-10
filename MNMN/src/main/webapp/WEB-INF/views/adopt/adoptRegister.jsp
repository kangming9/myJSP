<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>입양 신청 폼</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<h2>입양 신청서</h2>
	<ul>
		<li>동물 번호 : ${adopt.adopt_pet_num}</li>
		<li>동물 이름 : ${adopt.adopt_pet_name }</li>
		<li>입양자 아이디 : ${adopt.adopt_member_id}</li>	
		<li>입양자명 : <input type="text" name="name" id="name"></li>
		<li>입양 신청 날짜 : <input type="date" name="adopt_date" id="adopt_date"></li>
		<li>입양자 주소 : <input type="text" name="adopt_house" id="adopt_house"></li>
		<li>입양자 결혼 여부 : 	<br>
			<input type="checkbox" value="미혼">미혼<br>
			<input type="checkbox" value="기혼">기혼<br>
			<input type="checkbox" value="결혼 예정">결혼 예정<br>
		</li>
	</ul>
		<hr size="1" noshade>
		<p>
			입양자 소개 : <br><br>
			<textarea rows="5" cols="30" placeholder="${adopt.adopt_pet_name}의 가족이 될 분을 소개를 해 주세요" name="adopt_intro" id="adopt_intro"></textarea>
		</p>
	<div class="align-right">
		<input type="submit" value="신청">
		<input type="button" value="목록" onclick="location.href='petList.do'">
	</div>
</div>
</body>
</html>