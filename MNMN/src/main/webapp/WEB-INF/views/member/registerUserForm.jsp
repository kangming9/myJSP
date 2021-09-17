<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_login.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_signup.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_footer.css" type="text/css">
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script> 
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		var idChecked = 0;
		
		//아이디 중복 체크
		$('#id_check').click(function(){
			if($('#id').val().trim()==''){
				alert('아이디를 입력하세요!');
				$('#id').focus();
				$('#id').val('');
				return;
			}
			
			$('#message_id').text('');
			
			$.ajax({
				url:'checkDuplicatedId.do',
				type:'post',
				data:{id:$('#id').val()},
				dataType:'json',
				cache:false,
				timeout:30000,
				success:function(param){
					if(param.result == 'idNotFound'){
						idChecked = 1;
						$('#message_id').css('color','blue').text('등록 가능한 아이디 입니다.');
					}else if(param.result == 'idDuplicated'){
						idChecked = 0;
						$('#message_id').css('color','red').text('이미 등록된 아이디 입니다.');
						$('#id').val('').focus();
					}else{
						idChecked = 0;
						alert('아이디 중복 체크 오류 발생');
					}
				},
				error:function(){
					idChecked = 0;
					alert('네트워크 오류 발생');
				}
			});
		});
		//아이디 중복 안내 메시지 초기화 및 아이디 중복 값 초기화
		$('#register_form #id').keydown(function(){
			idChecked = 0;
			$('#message_id').text('');
		});
		
		//회원 정보 등록 유효성 체크
		$('#register_form').submit(function(){
			if($('#id').val().trim()==''){
				alert('아이디를 입력하세요!');
				$('#id').focus();
				$('#id').val('');
				return false;
			}
			if(idChecked==0){
				alert('아이디 중복 확인을 하세요!');
				return false;
			}
			if($('#name').val().trim()==''){
				alert('이름을 입력하세요!');
				$('#name').focus();
				$('#name').val('');
				return false;
			}
			if($('#passwd').val().trim()==''){
				alert('비밀번호를 입력하세요!');
				$('#passwd').focus();
				$('#passwd').val('');
				return false;
			}
			if($('#phone').val().trim()==''){
				alert('전화번호를 입력하세요!');
				$('#phone').focus();
				$('#phone').val('');
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
		<span class="page-name">환영하개</span>
		<div class="form-container">
			<form id="register_form" action="registerUser.do" method="post" autocomplete="off">
				<div class="info-content">
					<h3>회원가입</h3>
					<div class="logo-login"><img alt="멍냥멍냥 입양센터 로고" src="${pageContext.request.contextPath}/images/MN_logo_white.png" width=200px></div>
					<div class="login-content">
						<div class="align-center field">
							<label for="id"><i class="fas fa-user fa-lg"></i></label>
							<div class="ids"><input type="text" name="id" id="id" maxlength="12" autocomplete="off" placeholder="ID">
							<div id="message_id"></div></div>
							<input type="button" value="중복확인" id="id_check">
						</div>
						<div class="align-center field">
							<label for="name"><i class="far fa-id-card fa-lg"></i></label>
							<input type="text" name="name" id="name" maxlength="10" placeholder="NAME">
						</div>
						<div class="align-center field">
							<label for="passwd"><i class="fas fa-lock fa-lg"></i></label>
							<input type="password" name="passwd" id="passwd" maxlength="12" placeholder="PASSWORD">
						</div>
						<div class="align-center field">
							<label for="phone"><i class="fas fa-phone fa-lg"></i></label>
							<input type="text" name="phone" id="phone" maxlength="15" placeholder="PHONE NUMBER">
						</div>
						<div class="align-center">
							<input type="submit" value="회원가입" class="sign btn">
						</div>
						<div class="align-center">
							<input type="button" value="로그인" onclick="location.href='loginForm.do'" class="signup"> l
							<input type="button" value="홈으로" onclick="location.href='${pageContext.request.contextPath}/main/main.do'" class="cancel">
						</div>
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



