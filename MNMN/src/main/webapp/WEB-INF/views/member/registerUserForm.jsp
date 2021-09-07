<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
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
	<h2>회원가입</h2>
	<form id="register_form" action="registerUser.do" method="post">
		<ul>
			<li>
				<label for="id">id</label>
				<input type="text" name="id" id="id" maxlength="12" autocomplete="off">
				<input type="button" value="중복확인" id="id_check">
				<span id="message_id"></span>
			</li>
			<li>
				<label for="name">이름</label>
				<input type="text" name="name" id="name" maxlength="10">
			</li>
			<li>
				<label for="passwd">비밀번호</label>
				<input type="password" name="passwd" id="passwd" maxlength="12">
			</li>
			<li>
				<label for="phone">전화번호</label>
				<input type="text" name="phone" id="phone" maxlength="15">
			</li>
		</ul>
		<div class="align-center">
			<input type="submit" value="등록">
			<input type="button" value="홈으로" 
			        onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
		</div>
	</form>
</div>
</body>
</html>



