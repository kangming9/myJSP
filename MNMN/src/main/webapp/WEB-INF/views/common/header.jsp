<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
	<div id="headerdiv">
		<div class="logo common">
			<a href="${pageContext.request.contextPath}/main/main.do">
			<img alt="멍냥멍냥 입양센터 로고" src="${pageContext.request.contextPath}/images/MN_logo.png" width=200px>
			</a>
		</div>
	
		<div class="menu common">
		<a href="${pageContext.request.contextPath}/intro/introduce.do">About멍냥멍냥</a>
		<a href="${pageContext.request.contextPath}/volunteer/volunteerForm.do">힘드냥 도울개</a>
		<a href="${pageContext.request.contextPath}/adopt/petList.do">기다리개</a>
		<a href="${pageContext.request.contextPath}/adoptAfter/list.do">찾았냥</a>
		<a href="${pageContext.request.contextPath}/board/list.do">멍냥토크</a>
		</div>
		
		<div class="login common">
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
	</div>