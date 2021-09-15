<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_mypage.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_footer.css" type="text/css">
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script> 
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$('#modify_form').submit(function(){
			if($('#name').val().trim()==''){
				alert('이름을 입력하세요!');
				$('#name').focus();
				$('#name').val('');
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
	<div class="modify-page">
	<div class="modify-container">
	<form action="modifyUser.do" method="post" id="modify_form" class="modify-form">
		<div class="info-content">
		<h3>회원 정보 수정</h3>
		<ul>
			<li>
				<label for="name"><i class="fas fa-paw"></i> 이름</label>
				<input type="text" name="name" id="name" value="${member.member_detail_name}" maxlength="10">
			</li>
			<li>
				<label for="phone"><i class="fas fa-paw"></i> 전화번호</label>
				<input type="text" name="phone" id="phone" value="${member.member_detail_phone}" maxlength="15">
			</li>
		</ul>
		</div>
		<div class="btns">
			<input type="submit" value="수정하기" class="update_btn">
			<input type="button" value="취소" onclick="location.href='myPage.do'" class="cancel_btn">
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