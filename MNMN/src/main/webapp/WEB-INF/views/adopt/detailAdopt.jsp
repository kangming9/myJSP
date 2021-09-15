<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>입양신청서 확인</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_adoptRegister.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_footer.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){

		$('#reject_btn').click(function(){
			$('#reject_container').show();
		});
		
		$('#reject_form').submit(function(){
			if($('#reason').val().trim()==''){
				alert('반려 사유를 입력하세요!');
				$('#reason').val('').focus();
				return false;
			}
		});
		
		$('#reject_reset').click(function(){
			$('#reject_container').hide();
		});
	});
</script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<h2>입양신청서 확인</h2>
	<div class="register_form">
		<h3>입양신청서</h3>
		<div class="form-content detail">
		<ul>
			<li><span class="info-title">신청 번호</span><span class="info-content">${adopt.adopt_num}</span></li>
			<li><span class="info-title">신청인</span><span class="info-content">${adopt.adopt_member_id}</span></li>
			<li><span class="info-title">반려희망동물</span><span class="info-content">${adopt.adopt_pet_name}</span></li>
			<c:choose> 
				<c:when test="${adopt.adopt_married == 0}">
					<li><span class="info-title">결혼여부</span><span class="info-content">미혼</span></li> 
				</c:when> 
				<c:when test="${adopt.adopt_married == 1}">
					<li><span class="info-title">결혼여부</span><span class="info-content">결혼예정</span></li>
				</c:when>
				<c:when test="${adopt.adopt_married == 2}">
					<li><span class="info-title">결혼여부</span><span class="info-content">기혼</span></li>
				</c:when>  
			</c:choose> 
			<li><span class="info-title">주소</span><span class="info-content">${adopt.adopt_house}</span></li>
			<li><span class="info-title">신청일</span><span class="info-content">${adopt.adopt_date}</span></li>
		</ul>
		</div>
		<hr size="1" noshade width="100%">
		<p class="intro-content">
			${adopt.adopt_intro}
		</p>
		<hr size="1" noshade width="100%">
		<div class="align-right">
			<input type="button" value="승인" onclick="location.href='approveAdopt.do?adopt=${adopt.adopt_num}&pet=${adopt.adopt_pet_num}&mem=${adopt.adopt_member_num}'" class="approve btn">
			<input type="button" value="반려" id="reject_btn" class="reject btn">
			<input type="button" value="목록" onclick="location.href='listAdopt.do'" class="list btn">
		</div>
	</div>
	<br>
	<div class="page-main" id="reject_container" style="display:none;">
		<h2>반려 처리</h2>
		<div class="reject-form">
		<h3>사유</h3>
		<form id="reject_form" action="rejectAdopt.do" method="post">
			<input type="hidden" name="adopt" value="${adopt.adopt_num}">
			<textarea rows="5" cols="65" name="reason" id="reason"></textarea>
			<div class="align-center">
				<input type="submit" value="제출" id="reject_submit" class="approve btn">
				<input type="button" value="취소" id="reject_reset" class="list btn">
			</div>
		</form>
		</div>
	</div>
		<!-- footer 시작 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	<!-- footer 끝 -->
</div>
</body>
</html>