<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${check==false}">
	<script>
		alert('관리자 권한이 없습니다.');
		history.go(-1);
	</script>
</c:if> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_memDetail.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_footer.css" type="text/css">
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script> 
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$('#detail_form').submit(function(){
			if($('#name').val().trim()==''){
				alert('이름을 입력하세요!');
				$('#name').val('').focus();
				return false;
			}
			if($('#phone').val().trim()==''){
				alert('전화번호를 입력하세요!');
				$('#phone').val('').focus();
				return false;
			}
		});
	});
</script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="page-container">
	<span class="page-name">회원 정보 수정</span>
	<div class="modify-container">
		<form action="detailUser.do" method="post" id="detail_form" class="modify-form">
		<div class="info-content">
		<h3>${member.member_id} 정보 수정</h3>
		<input type="hidden" name="mem_num" value="${member.member_num}">
		<ul>
			<li>
				<label for="grade"><i class="fas fa-paw"></i> 등급</label>
				<input type="radio" name="grade" value="1" id="grade1" <c:if test="${member.member_grade == 1}">checked</c:if>/>관리
				<input type="radio" name="grade" value="2" id="grade2" <c:if test="${member.member_grade == 2}">checked</c:if>/>입양
				<input type="radio" name="grade" value="3" id="grade3" <c:if test="${member.member_grade == 3}">checked</c:if>>일반
			</li>
			<li>
				<label for="name"><i class="fas fa-paw"></i> 이름</label>
				<input type="text" name="name" id="name" value="${member.member_detail_name}" maxlength="10">
			</li>
			<li>
				<label for="phone"><i class="fas fa-paw"></i> 휴대전화</label>
				<input type="text" name="phone" id="phone" value="${member.member_detail_phone}" maxlength="15">
			</li>
		</ul>
		<div class="btns">
			<input type="submit" value="수정하기" class="update_btn">
			<input type="button" value="목록" class="cancel_btn" onclick="location.href='memberList.do'">
		</div>
		</div>
	</form>
	</div>
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</div>
</body>
</html>
