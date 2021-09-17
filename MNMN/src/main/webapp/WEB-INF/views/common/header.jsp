<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script> 
<script src="https://use.fontawesome.com/releases/v5.10.1/js/all.js"></script>
<script src="https://use.fontawesome.com/releases/v5.12.0/js/all.js"></script>
	<div id="login-menu">
		<ul>
			<c:if test="${!empty user_num}">
				<li><i class="fas fa-dog"></i><span class="user-id"> ${user_id}님 </span></li>
				<li><a href="${pageContext.request.contextPath}/member/logout.do">로그아웃</a></li>
			</c:if>
			<c:if test="${empty user_num}">
				<li><a href="${pageContext.request.contextPath}/member/registerUserForm.do">회원가입</a></li>
				<li><a href="${pageContext.request.contextPath}/member/loginForm.do">로그인</a></li>
			</c:if>
			<c:if test="${!empty user_num && user_grade > 0}">
				<li><a href="${pageContext.request.contextPath}/member/myPage.do">마이페이지</a></li>
			</c:if>
		</ul>
	</div>
	<div class="logo">
		<a href="${pageContext.request.contextPath}/main/main.do">
			<img alt="멍냥멍냥 입양센터 로고" src="${pageContext.request.contextPath}/images/MN_logo.png">
		</a>
	</div>
	<nav class="menu">
		<a href="${pageContext.request.contextPath}/intro/introduce.do">소개할개</a>
		<a href="${pageContext.request.contextPath}/volunteer/volunteerForm.do">힘드냥<i class="fas fa-paw fa-xs"></i>도울개</a>
		<a href="${pageContext.request.contextPath}/adopt/petList.do">기다리개</a>
		<a href="${pageContext.request.contextPath}/adoptAfter/list.do">찾았냥</a>
		<a href="${pageContext.request.contextPath}/community/communityList.do">멍냥토크</a>
	</nav>