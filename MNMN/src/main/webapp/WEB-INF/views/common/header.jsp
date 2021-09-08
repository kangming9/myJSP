<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<h1 class="align-center">멍냥멍냥</h1>
<div class="align-right">
	<a href="">About멍냥멍냥</a>
	<a href="${pageContext.request.contextPath}/volunteer/volunteerUser.do">힘드냥 도울개</a>
	<a href="">기다리개</a>
	<a href="">찾았냥</a>
	<a href="">멍냥토크</a>
	<c:if test="${!empty user_num}">
		[<span>${user_id}</span>]
		<a href="${pageContext.request.contextPath}/member/logout.do">로그아웃</a>
	</c:if>
	<c:if test="${empty user_num}">
		<a href="${pageContext.request.contextPath}/member/registerUserForm.do">회원가입</a>
		<a href="${pageContext.request.contextPath}/member/loginForm.do">로그인</a>
	</c:if>
	<c:if test="${!empty user_num && user_grade > 0}">
		<a href="${pageContext.request.contextPath}/member/myPage.do">마이페이지</a>
	</c:if>
</div>