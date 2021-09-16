<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_mypage.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_footer.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$('#profile_nav').click(function(){
			$(this).css('background-color','#E8F0F2');
			$('#account_nav').css('background-color','#FFFFFF');
			$('#admin_nav').css('background-color','#FFFFFF');
			$('#deactivate_nav').css('background-color','#FFFFFF');
			$('#profile').show();
			$('#account').hide();
			$('#admin').hide();
			$('#deactivate').hide();
			
			return false;
		});
		
		$('#account_nav').click(function(){
			$('#profile_nav').css('background-color','#FFFFFF');
			$(this).css('background-color','#E8F0F2');
			$('#admin_nav').css('background-color','#FFFFFF');
			$('#deactivate_nav').css('background-color','#FFFFFF');
			$('#profile').hide();
			$('#account').show();
			$('#admin').hide();
			$('#deactivate').hide();
			
			return false;
		});
		
		$('#admin_nav').click(function(){
			$('#profile_nav').css('background-color','#FFFFFF');
			$('#account_nav').css('background-color','#FFFFFF');
			$(this).css('background-color','#E8F0F2');
			$('#deactivate_nav').css('background-color','#FFFFFF');
			$('#profile').hide();
			$('#account').hide();
			$('#admin').show();
			$('#deactivate').hide();
			
			return false;
		});
		
		$('#deactivate_nav').click(function(){
			$('#profile_nav').css('background-color','#FFFFFF');
			$('#account_nav').css('background-color','#FFFFFF');
			$('#admin_nav').css('background-color','#FFFFFF');
			$(this).css('background-color','#E8F0F2');
			$('#profile').hide();
			$('#account').hide();
			$('#admin').hide();
			$('#deactivate').show();
			
			return false;
		});
		
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
	<div class="page-container">
		<span class="page-name">마이페이지</span>
		<div class="mypage-container">
		<div class="mypage-nav">
			<ul>
				<li><a href="#profile" id="profile_nav">프로필</a></li>
				<li><a href="#account" id="account_nav">계정 관리</a></li>
				<c:if test="${user_grade == 1}"><li><a href="#admin" id="admin_nav">관리자 메뉴</a></c:if>
				<li><a href="#deactivate" id="deactivate_nav">회원 탈퇴</a></li>
			</ul>
		</div>
		<div class="mypage-div">
			<div id="profile">
				<h3>프로필</h3>
				<span class="info">자유롭게 프로필 사진을 등록하세요.<br>프로필 사진은 언제든 변경할 수 있습니다.</span>
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
						<div>
							<input type="button" value="수정하기" id="photo_btn" class="update_btn">
						</div>
						<div id="photo_choice" style="display:none;">
							<input type="file" id="photo" accept="image/gif,image/png,image/jpeg"><br>
							<input type="button" value="전송" id="photo_submit">
							<input type="button" value="취소" id="photo_reset">
						</div>
					</li>
				</ul>
			</div>
			<div id="account" style="display:none;">
				<h3>계정 관리</h3>
				<span class="info">회원님의 정보를 확인하고 수정할 수 있습니다.</span>
				<div class="info-content">
					<div class="sub">계정 정보</div>
					<ul>
						<li><span class="title">아이디</span> <span class="title-info">${user_id}</span></li>
						<li>
							<span class="title">비밀번호</span> <span class="title-info"><input type="password" value="${member.member_detail_pw}" disabled="disabled"></span>
						</li>
					</ul>
					<input type="button" value="수정하기" onclick="location.href='modifyPasswordForm.do'" class="update_btn">
				</div>
				<div class="info-content">
					<div class="sub">회원 정보</div>
					<ul>
						<li><span class="title">이름</span>  ${member.member_detail_name}</li>
						<li><span class="title">휴대전화</span> ${member.member_detail_phone}</li>
					</ul>
					<input type="button" value="수정하기" onclick="location.href='modifyUserForm.do'" class="update_btn">
				</div>
				<div class="info-content">
					<div class="sub">활동 정보</div>
					<ul>
						<c:if test="${user_grade != 1}">
						<li><span class="title">봉사</span>  ${member.member_volunteer} 시간</li>
						<li><span class="title">입양</span>  ${member.member_adopt} 회</li>
						</c:if>
						<li><span class="title">가입일</span>  ${member.member_detail_reg_date}</li>
						<li><span class="title">마지막 정보 수정일</span> ${member.member_detail_new_date}</li>
					</ul>
				</div>
			</div>
			<c:if test="${user_grade == 1}">
			<div id="admin" style="display:none;">
				<h3>관리자 메뉴</h3>
				<span class="info">회원 및 입양/봉사 신청을 관리하세요.</span>
				<ul>
					<li>
						<input type="button" value="회원 관리" onclick="location.href='memberList.do'" class="check_btn">
					</li>
					<li>
						<input type="button" value="신규 입양  관리" onclick="location.href='${pageContext.request.contextPath}/adopt/listAdopt.do'" class="check_btn">
					</li>
					<li>
						<input type="button" value="신규 봉사 관리" onclick="location.href='${pageContext.request.contextPath}/volunteer/listVolunteer.do'" class="check_btn">
					</li>
				</ul>
			</div>
			</c:if>
			<div id="deactivate" style="display:none;">
				<h3>회원 탈퇴</h3>
				<span class="info">이 기능은 재사용 및 복구가 불가능 하오니 신중하게 선택하시길 바랍니다.</span>
				<ul>
					<li>
						<input type="button" value="탈퇴하기" onclick="location.href='deleteUserForm.do'" class="deactivate_btn">
					</li>
				</ul>
			</div>
		</div>
		</div>
	</div>
	<!-- footer 시작 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	<!-- footer 끝 -->
</div>
</body>
</html>