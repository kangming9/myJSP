<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>동물 상세 페이지</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_pet.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_footer.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
			$(document).ready(function(){
				//삭제 기능
				$('#delete_btn').on('click',function(){
					var choice = confirm('입양공고를 삭제 하시겠습니까?');
					if(choice){
						location.replace('deletePetDetail.do?pet_num=${pet.pet_num}');
					}
				});
				
				
				//입양 중복 체크
				
				$("#r-g-btn").click(function(event) {
					event.preventDefault(); // 버튼의 원래 이벤트 무효
					$.ajax({
						url:'CheckDuplicatedAdopt.do',
						type:'get',
						data:{
							user_num:$('#user_num').val(),
							pet_num:$('#check_pet_num').val()
						},
						dataType:'json',
						cache:false,
						timeout:30000,
						success:function(param){
							if(param.result == 'NotDuplicated'){
								alert('입양 시작');
							}else if(param.result == 'Duplicated'){
								alert('이미 입양 신청 기록이 있습니다.');
							}else{
								alert('입양 중복 체크 오류');
								event.preventDefault(); // 버튼의 원래 이벤트 무효
							}
						},
						error:function(){
							alert('네트워크 오류 발생');
						}
					});
				});
				
					
				});
				
				
			});
			
</script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="wrap">
	<h2 class="title">${pet.pet_name}의 상세 정보</h2>
	<div class="detail-half-container">
	<div class="detail-half">
		<img src="${pageContext.request.contextPath}/upload/${pet.pet_photo}" class="detail-main-image">
	</div>
	<div class="detail-half details-half--border">
		<div class="pet-details">
			<div class="detail-title"><h2>${pet.pet_name}</h2></div>
			<div class="detail-description">
			<div class="detail-sub">
			<input type="hidden" value="${user_num}" id="user_num">
			<span class="detail-description-text" id="check_pet_num">등록번호 : ${pet.pet_num}</span><br>
			<span class="detail-description-text">동물 종류 : ${pet.pet_type}</span><br>
			<span class="detail-description-text">등록일자 : ${pet.pet_date}</span>
				</div>
				<div class="detail-content">
					${pet.pet_detail}
				</div>
			</div>
			<div class="buttons">
		<%-- 관리자 등급(1) -> 수정, 삭제, 목록이 보여야 하고 / 관리자 아닌 멤버-> 입양신청, 목록 --%>
		<c:if test="${user_grade == 1}">
			<input type="button" value="수정" onclick="location.href='modifyPetDetailForm.do?pet_num=${pet.pet_num}'" class="btn-style">
			<input type="button" value="삭제" name="delete_btn" id="delete_btn" class="btn-style">
			<input type="button" value="목록" onclick="location.href='petList.do'" class="btn-style-cancel">
			</c:if>
			<c:if test="${user_grade > 1 || user_grade == null}">
			<input type="button" value="입양 신청" id="r-g-btn" onclick="location.href='adoptRegisterForm.do?pet_num=${pet.pet_num}'" class="btn-style">
			<input type="button" value="목록" onclick="location.href='petList.do'" class="btn-style-cancel">
		</c:if>
		</div>
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


