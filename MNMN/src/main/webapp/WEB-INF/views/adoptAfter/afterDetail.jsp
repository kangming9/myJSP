<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>입양후기 게시글상세</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_adoptAfter.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_footer.css" type="text/css">
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<p>
	<div style="border: 1px solid; background: white;">
		<ul>
			<li class="tag">입양후기 게시판</li>
			<p>
			<h5 id="detailTitle">${after.after_title}</h5>
			<div id="detail_Id_Date">
			<span>${after.member_id}</span>
			<span id="detailDate">${after.after_date}</span>
			</div>
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
	</div>
	<p>
	<div class="align-right">
		<c:if test="${user_num == after.after_member_num}">
		<input type="button" value="수정" class="btn-style" onclick="location.href='afterModifyForm.do?after_num=${after.after_num}'">
		<input type="button" value="삭제" class="btn-style" id="delete_btn" >
		<script type="text/javascript">
			var delete_btn = document.getElementById('delete_btn');
			delete_btn.onclick=function(){
				var choice = confirm('이 글을 삭제하시겠습니까?');
				if(choice){
					location.replace('afterDelete.do?after_num=${after.after_num}');
				}
			};
		</script>
		</c:if>
		<input type="button" value="목록" class="btn-style-cancel" onclick="location.href='list.do'">
		</div>
		<p>
			<!-- footer 시작 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	<!-- footer 끝 -->
</div>
</body>
</html>