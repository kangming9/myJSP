<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>동물 상세 페이지</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
			$(document).ready(function(){
				//삭제 기능
				$('#delete_btn').on('click',function(){
					var choice = confirm('입양공고를 삭제 하시겠습니까?');
					if(choice){
						location.replace('deletePetDetail.do?pet_num=${pet.pet_num}');
					}
				});
			});
			
</script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<h2>${pet.pet_name}의 상세 정보</h2>
	<ul>
		<li>동물 번호 : ${pet.pet_num}</li>
		<li>동물 이름 : ${pet.pet_name}</li>
		<li>동물 종류 : ${pet.pet_type}</li>
		<li>등록일자 : ${pet.pet_date}</li>
	</ul>
	<hr size="1" noshade width="100%">
	<div class="align-center">
		<img src="${pageContext.request.contextPath}/upload/${pet.pet_photo}" class="detail-img">
	</div>
	<p>
		${pet.pet_detail}
	</p>
	<hr size="1" noshade width="100%">
	<div class="align-right">
		<%-- 관리자 등급(1) -> 수정, 삭제, 목록이 보여야 하고 / 관리자 아닌 멤버-> 입양신청, 목록 --%>
		<c:if test="${user_grade == 1}">
		<input type="button" value="수정" onclick="location.href='modifyPetDetailForm.do?pet_num=${pet.pet_num}'">
		<input type="button" value="삭제" name="delete_btn" id="delete_btn">
		</c:if>
		<input type="button" value="입양 신청" onclick="location.href='adoptRegister.do?pet_num=${pet.pet_num}'">
		<input type="button" value="목록" onclick="location.href='petList.do'">
	</div>
	
</div>
</body>
</html>