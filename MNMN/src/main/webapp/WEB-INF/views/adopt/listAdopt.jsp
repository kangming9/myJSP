<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<c:if test="${check==false}">
	<script>
		alert('관리자 권한이 없습니다.');
		history.go(-1);
	</script>
</c:if> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>입양 신청자</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_memList.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_footer.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$('#search_form').submit(function(){
			if($('#keyword').val().trim()==''){
				alert('검색어를 입력하세요!');
				$('#keyword').val('').focus();
				return false;
			}
		});
	});
</script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="page-container">
	<span class="page-name">입양 신청자</span>
	<div class="list-container">
		<div class="top">
			<form id="search_form" action="listAdopt.do" method="get">
			<div class="search">
				<select name="keyfield">
						<option value="" selected>전체</option>
						<option value="1">심사대기</option>
						<option value="2">승인</option>
						<option value="3">반려</option>
				</select>
				<input type="submit" value="검색" class="submit btns">
			</div>
			</form>
			<div class="btn-container">
				<input type="button" value="목록" class="cancel btns" onclick="location.href='listAdopt.do'">
				<input type="button" value="홈으로" class="home btns" onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
			</div>
		</div>
	<c:if test="${count == 0}">
	<div class="result-display">
		입양 신청자가 없습니다.
	</div>
	</c:if>
	<c:if test="${count > 0}">
	<div class="tb-container">
	<table>
		<thead class="tb-header">
			<tr>
				<th>신청번호</th>
				<th>신청자</th>
				<th>희망입양동물</th>
				<th>신청일</th>
				<th>처리 상태</th>
				<th>신청서</th>
			</tr>
		</thead>
		<tbody class="tb-content">
		<c:forEach var="adopt" items="${list}">
		<tr>
			<td>${adopt.adopt_num}</td>
			<td><a href="${pageContext.request.contextPath}/member/detailUserForm.do?mem_num=${adopt.adopt_member_num}">${adopt.adopt_member_id}</a></td>
			<td><a href="petDetail.do?pet_num=${adopt.adopt_pet_num}">${adopt.adopt_pet_name}</a></td>
			<td>${adopt.adopt_date}</td>
			<td>
			<c:if test="${adopt.adopt_now == 0}">심사대기</c:if>
			<c:if test="${adopt.adopt_now == 1}">승인</c:if>
			<c:if test="${adopt.adopt_now == 2}">반려</c:if>
			</td>
			<td><input type=button value="보기" onclick="location.href='detailAdopt.do?adopt_num=${adopt.adopt_num}'" class="detail btns"/></td>
		</tr>
		</c:forEach>
		</tbody>
	</table>
	</div>
	<div class="align-center">
		${pagingHtml}
	</div>
	</c:if>
	</div>
	</div>
	<!-- footer 시작 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	<!-- footer 끝 -->
</div>
</body>
</html>