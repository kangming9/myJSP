<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>입양 동물 리스트</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_pet.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_footer.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$('#search_form').submit(function(){
			if($('#keyword').val().trim()==''){
				alert('검색어를 입력하세요!');
				$('#keyword').val('').focus();
				return false;
			}
		});
	});
</script>
</head>
<body>		
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="wrap-list">
	<h2 class="title">입양 동물 리스트</h2>
	<form class="search-form" id="search_form" action="petList.do" method="get" style="border:none;">
		<ul class="align-center">
			<li>
				<select name="keyfield">
					<option value="1">이름</option>
					<option value="2">종류</option>
				</select>
			</li>
			<li>
				<input type="search" size="16" name="keyword" id="keyword">
			</li>
			<li>
				<input type="submit" value="검색" class="btn-style-cancel">
			</li>
		</ul>
	</form>
	<c:if test="${user_grade == 1}">
	<div id="register-button">
		<input type="button" value="동물 등록" onclick="location.href='registerPetForm.do'"class="btn-style">
	</div>
	</c:if>
	<!-- 등록된 입양 예정 동물이 없는 경우 -->
	<c:if test="${count == 0}">
	<div class="result-display">
		모든 친구들이 가족을 만났어요!
	</div>
	</c:if>
	<!-- 끝 -->
	<!-- 등록된 입양 예정 동물이 있는 경우 -->
	<c:if test="${count > 0}">
	<div id="container">
	<div class="row">
	<c:forEach var="pet" items="${list}">
	<div class="col-sm-12 col-md-6 col-xl-4">
		<div class="card">
			<a href="petDetail.do?pet_num=${pet.pet_num}"><img src="${pageContext.request.contextPath}/upload/${pet.pet_photo}" class="rounded-circle mb-3"></a>
			<div class="card-body">
			${pet.pet_num}<br>
			COMMENT : <br>
			${pet.pet_name}	/ ${pet.pet_type}<br>
			${pet.pet_date}
			</div>
		</div>
	</div>
	</c:forEach>
	</div>
	</div>
	<!-- 끝 -->
	<div class="align-center">
		${pagingHtml}
	</div>
	</c:if>
</div>
	<!-- footer 시작 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	<!-- footer 끝 -->
</div>
</body>
</html>