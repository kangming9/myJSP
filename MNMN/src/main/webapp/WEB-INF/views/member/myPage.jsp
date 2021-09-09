<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$('#photo_btn').click(function(){
			$('#photo_choice').show();
			$(this).hide();
		});
		
		//이미지 미리 보기
		var photo_path;
		var my_photo;
		$('#photo').change(function(){
			var photo = document.getElementById('photo');
			my_photo = photo.files[0];
			if(my_photo){
				var reader = new FileReader();
				reader.readAsDataURL(my_photo);
				
				reader.onload=function(){
					photo_path = $('.my-photo').attr('src');//이미지 미리보기 전 이미지 저장
					$('.my-photo').attr('src',reader.result);
				};
			}
		});
		
		//이미지 전송
		$('#photo_submit').click(function(){
			if($('#photo').val()==''){
				alert('파일을 선택하세요!');
				$('#photo').focus();
				return;
			}
			
			//파일 전송
			var form_data = new FormData();
			form_data.append('photo',my_photo);
			$.ajax({
				data:form_data,
				type:'post',
				url:'updateMyPhoto.do',
				dataType:'json',
				contentType:false,
				enctype:'multipart/form-data',
				processData:false,
				success:function(param){
					if(param.result == 'logout'){
						alert('로그인 후 사용하세요!');
					}else if(param.result == 'success'){
						alert('프로필 사진이 수정되었습니다.');
						$('#photo').val('');
						$('#photo_choice').hide();
						$('#photo_btn').show();
					}else{
						alert('파일 전송 오류 발생');
					}
				},
				error:function(){
					alert('네트워크 오류 발생');
				}
			});
			
		});
		
		//이미지 미리보기 취소
		$('#photo_reset').click(function(){
			//이미지 미리보기 전 이미지로 되돌리기
			$('.my-photo').attr('src',photo_path);
			$('#photo').val('');
			$('#photo_choice').hide();
			$('#photo_btn').show();
		});
		
	});
</script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<h2>회원정보</h2>
	<div class="mypage-div">
		<h3>프로필 사진</h3>
		<ul>
			<li>
				<c:if test="${empty member.member_detail_photo}">
				<img src="${pageContext.request.contextPath}/images/default_profile.png" width="100" height="100" class="my-photo">
				</c:if>
				<c:if test="${!empty member.member_detail_photo}">
				<img src="${pageContext.request.contextPath}/upload/${member.member_detail_photo}" width="100" height="100" class="my-photo">
				</c:if>
			</li>
			<li>
				<div class="align-center">
					<input type="button" value="수정" id="photo_btn">
				</div>
				<div id="photo_choice" style="display:none;">
					<input type="file" id="photo" accept="image/gif,image/png,image/jpeg"><br>
					<input type="button" value="전송" id="photo_submit">
					<input type="button" value="취소" id="photo_reset">
				</div>
			</li>
		</ul>
		<c:if test="${user_grade == 1}">
		<h3>관리자 메뉴</h3>
		<ul>
			<li>
				<input type="button" value="신규 입양 신청 확인" onclick="location.href='${pageContext.request.contextPath}/adopt/listAdopt.do'">
			</li>
			</br>
			<li>
				<input type="button" value="신규 봉사 신청 확인" onclick="location.href='${pageContext.request.contextPath}/volunteer/listVolunteer.do'">
			</li>
		</ul>
		</c:if>
		<h3>회원 탈퇴</h3>
		<ul>
			<li>
				<input type="button" value="회원탈퇴" onclick="location.href='deleteUserForm.do'">
			</li>
		</ul>
	</div>
	<div class="mypage-div">
		<h3>연락처</h3>
		<ul>
			<li>이름 : ${member.member_detail_name}</li>
			<li>전화번호 : ${member.member_detail_phone}</li>
			<li>가입일 : ${member.member_detail_reg_date}</li>
			<li>최근 정보 수정일 : ${member.member_detail_new_date}</li>
			<li><input type="button" value="연락처 수정" onclick="location.href='modifyUserForm.do'"></li>
		</ul>
		<h3>비밀번호 수정</h3>
		<ul>
			<li>
				<input type="button" value="비밀번호 수정" onclick="location.href='modifyPasswordForm.do'">
			</li>
		</ul>
	</div>
</div>
</body>
</html>