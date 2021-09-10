<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>입양후기 게시글상세</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<h2>입양 후기</h2>
	<p>
	<ul>
		<li>${after.after_title}</li>
		<li>${after.after_date}</li>
		<hr size="1" noshade="noshade" width="100%">
		<li>
		<br>
		<div class="align-center">
		<img src="${pageContext.request.contextPath}/upload/${after.after_photo}" class="detail-img">
		</div>
		<br>
		</li>
		<li>${after.after_content}</li>
	</ul>
	<hr size="1" noshade="noshade" width="100%">
	<div class="align-right">
	<input type="button" value="수정" onclick="location.href='afterModifyForm.do?after_num=${after.after_num}'"
		<c:if test="${user_num != after.after_member_num}">disabled="disabled"</c:if>
	>
	<input type="button" value="삭제" id="delete_btn" 
		<c:if test="${user_num != after.after_member_num}">disabled="disabled"</c:if>
	>
	<script type="text/javascript">
		var delete_btn = document.getElementById('delete_btn');
		delete_btn.onclick=function(){
			var choice = confirm('이 글을 삭제하시겠습니까?');
			if(choice){
				location.replace('afterDelete.do?after_num=${after.after_num}');
			}
		};
	</script>
	<input type="button" value="목록" onclick="location.href='list.do'">
	</div> 
</div>
</body>
</html>