<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_mypage.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_footer.css" type="text/css">
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script> 
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$('#delete_form').submit(function(){
			if($('#id').val().trim()==''){
				alert('아이디를 입력하세요!');
				$('#id').val('').focus();
				return false;
			}
			if($('#passwd').val().trim()==''){
				alert('비밀번호를 입력하세요!');
				$('#passwd').val('').focus();
				return false;
			}
			if($('#cpasswd').val().trim()==''){
				alert('비밀번호 확인을 입력하세요!');
				$('#cpasswd').val('').focus();
				return false;
			}
			if($('#passwd').val()!=$('#cpasswd').val()){
				alert('아이디와 비밀번호를 정확히 입력해 주세요.');
				$('#cpasswd').val('').focus();
				return false;
			}
		});
		
		//비밀번호 확인 후 재수정하면 비밀번호 확인 및 메시지 초기화
		$('#passwd').keyup(function(){
			$('#cpasswd').val('');
			$('#message_id').text('');
		});
		
		//비밀번호와 비밀번호 확인 일치 여부 확인
		$('#cpasswd').keyup(function(){
			if($('#passwd').val() == $('#cpasswd').val()){
				$('#message_id').css('color','blue').text('비밀번호 일치');
			}else{
				$('#message_id').css('color','red').text('비밀번호 불일치');
			}
		});
		
	});
</script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="page-container">
	<span class="page-name">회원 탈퇴</span>
	<div class="modify-container">
	<form action="deleteUser.do" method="post" id="delete_form" class="modify-form">
		<div class="info-content">
		<h3>탈퇴 확인 </h3>
		<ul>
			<li>
				<label for="id"><i class="fas fa-paw"></i> 아이디</label>
				<input type="text" name="id" id="id" maxlength="12">
			</li>
			<li>
				<label for="passwd"><i class="fas fa-paw"></i> 비밀번호</label>
				<input type="password" name="passwd" id="passwd" maxlength="12">
			</li>
			<li>
				<label for="cpasswd"><i class="fas fa-paw"></i> 비밀번호 확인</label>
				<div class="cpass"><input type="password" name="cpasswd" id="cpasswd" maxlength="12">
				<div id="message_id"></div></div>
			</li>
		</ul>
		<div class="btns">
			<input type="submit" value="탈퇴하기" class="update_btn">
			<input type="button" value="취소" onclick="location.href='myPage.do'" class="cancel_btn">
		</div>
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