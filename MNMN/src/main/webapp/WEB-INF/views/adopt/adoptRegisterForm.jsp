<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>입양 신청하기</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_adoptRegister.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_footer.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$('#adopt_register').submit(function(){
			//유효성 체크
			if($('#adopt_house').val().trim()==''){
				alert('주소를 입력하세요');
				$('#adopt_house').val('').focus();
				return false;
			}
			
			if($('#adopt_intro').val().trim()==''){
				alert('입양자 소개를 입력하세요');
				$('#adopt_intro').val('').focus();
				return false;
			}
			if($('input:checkbox[id="checktruth1"]').is(":checked") == false){
				alert('체크사항을 확인해 주세요');
				return false;
			}
			
			if($('input:checkbox[id="checktruth2"]').is(":checked") == false){
				alert('체크사항을 확인해 주세요');
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
	<div class="page-info">
		<span class="page-name">입양 신청서</span>
		<div class="info">가족이 되기 위해 상담에 필요한 정보를 작성하여 제출해주세요.</div>
	</div>
	<div class="list-space align-right">
		<input type="button" value="홈으로" onclick="location.href='${pageContext.request.contextPath}/main/main.do'" class="home btn">
	</div>
	<div class="register_form">
	<form action="adoptRegister.do" method="post" name="adopt_register" id="adopt_register">
		<h3>입양 신청서</h3>
		<input type="hidden" name="mem_num" id="user_num" value="${adopt.adopt_member_num}">
		<input type="hidden" name="pet_num" id="pet_num" value="${adopt.adopt_pet_num}">
		<div class="pet-info form-content">
	        <span><i class="fas fa-paw fa-2x"></i></span>
	        <ul>
	           <li><span class="info-title">등록 번호</span><span class="info-content">${adopt.adopt_pet_num}</span></li>
	           <li><span class="info-title">이름</span><span class="info-content">${adopt.adopt_pet_name}</span></li>
	        </ul>
      	</div>
		<hr size="1" noshade width="100%">
		<div class="user-info form-content">
			<span><i class="fas fa-user fa-2x"></i></span>
			<ul>
				<li><span class="info-title">아이디</span><span class="info-content">${adopt.adopt_member_id}</span></li>	
				<li><span class="info-title">이름</span><span class="info-content">${adopt.adopt_member_name}</span></li>
				<li><span class="info-title">주소</span><input type="text" name="adopt_house" id="adopt_house" class="input-text"></li>
				<li><span class="info-title">결혼 여부</span> 	
					<input type="radio" name="checkboxVal" id="checkMarried1" value="0" checked>미혼
					<input type="radio" name="checkboxVal" id="checkMarried2" value="1">결혼 예정
					<input type="radio" name="checkboxVal" id="checkMarried3" value="2">기혼<br>
				</li>
			</ul>
		</div>
		<hr size="1" noshade width="100%">
		<div class="form-content">
			<span><i class="fas fa-marker fa-2x"></i></span>
			<textarea rows="10" cols="30" placeholder="${adopt.adopt_pet_name}의 가족이 될 분을 소개를 해 주세요!" name="adopt_intro" id="adopt_intro" class="text-text"></textarea>
		</div>
		<hr size="1" noshade width="100%">
		<p>
			<input type="checkbox" name="checktruth" id="checktruth1"> 반려동물은 장난감이 아닌 가족입니다. 충분히 고려하시고 입양 신청 해주시기 바랍니다.
			<br><br>
			<input type="checkbox" name="checktruth" id="checktruth2"> 상기 입양신청서는 입양자 본인이 직접 작성하였으며, 사항 중 거짓이 없음을 확인합니다. 거짓으로 작성한 사실이 발견될 시 추후 입양 절차 중 불이익이 발생할 수 있습니다.
		</p>
		<div class="align-center">
			<input type="submit" value="제출하기" class="register btn">
		</div>
		<div class="align-center">
			<input type="button" value="취소" onclick="location.href='petList.do'" class="cancel btn">
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