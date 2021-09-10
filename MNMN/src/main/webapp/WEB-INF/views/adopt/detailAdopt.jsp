<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>입양신청서</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
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
	<h2>입양신청서</h2>
	<ul>
		<li>신청번호 : ${adopt.adopt_num}</li>
		<li>신청인 : ${adopt.adopt_member_id}</li>
		<li>반려희망동물 : ${adopt.adopt_pet_name}</li>
		<c:choose> 
			<c:when test="${adopt.adopt_married == 0}">
				<li>결혼여부 : 미혼</li> 
			</c:when> 
			<c:when test="${adopt.adopt_married == 1}">
				<li>결혼여부 : 결혼예정 </li>
			</c:when>
			<c:when test="${adopt.adopt_married == 2}">
				<li>결혼여부 : 기혼 </li>
			</c:when>  
		</c:choose> 
		<li>거주형태 : ${adopt.adopt_house}</li>
		<li>신청일 : ${adopt.adopt_date}</li>
	</ul>
	<hr size="1" noshade width="100%">
	<p>
		${adopt.adopt_intro}
	</p>
	<hr size="1" noshade width="100%">
	<div class="align-right">
		<input type="button" value="승인" onclick="location.href='approveAdopt.do?adopt=${adopt.adopt_num}&pet=${adopt.adopt_pet_num}'">
		<input type="button" value="반려" id="reject_btn">
		<input type="button" value="목록" onclick="location.href='listAdopt.do'">
	</div>
	<br>
	<div class="page-main" id="reject_container" style="display:none;">
		<h2>반려 처리</h2>
		<form id="reject_form" action="rejectAdopt.do" method="post">
			<input type="hidden" name="adopt" value="${adopt.adopt_num}">
			<ul>
				<li>
					<label for="reason">사유</label>
					<textarea rows="5" cols="30" name="reason" id="reason"></textarea>
				</li>
			</ul>
			<div class="align-center">
				<input type="submit" value="제출" id="reject_submit">
				<input type="button" value="취소" id="reject_reset">
			</div>
		</form>
	</div>
</div>
</body>
</html>