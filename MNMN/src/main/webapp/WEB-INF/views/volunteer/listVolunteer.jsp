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
<title>봉사 신청자</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_memList.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_footer.css" type="text/css">
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="page-container">
	<span class="page-name">봉사 신청자</span>
	<div class="list-container">
		<div class="top">
			<form id="search_form" action="listVolunteer.do" method="get">
			<div class="search">
				<select name="keyfield">
						<option value="" selected>전체</option>
						<option value="1">처리대기</option>
						<option value="2">승인</option>
						<option value="3">반려</option>
				</select>
				<input type="submit" value="검색" class="submit btns">
			</div>
			</form>
			<div class="btn-container">
				<input type="button" value="목록" class="cancel btns" onclick="location.href='listVolunteer.do'">
				<input type="button" value="마이페이지" class="home btns" onclick="location.href='${pageContext.request.contextPath}/member/myPage.do'">
			</div>
		</div>
	<c:if test="${count == 0}">
	<div class="result-display">
		봉사 신청자가 없습니다.
	</div>
	</c:if>
	<c:if test="${count > 0}">
	<div class="tb-container">
		<table>
			<thead class="tb-header">
				<tr>
					<th>신청번호</th>
					<th>신청자</th>
					<th>신청일</th>
					<th>봉사일</th>
					<th>봉사 시간</th>
					<th>처리 상태</th>
					<th>확인</th>
				</tr>
			</thead>
			<tbody class="tb-content">
			<c:forEach var="volunteer" items="${list}">
			<tr>
				<td>${volunteer.vol_num}</td>
				<td><a href="${pageContext.request.contextPath}/member/detailUserForm.do?mem_num=${volunteer.vol_m_num}">${volunteer.vol_m_id}</a></td>
				<td>${volunteer.vol_reg_date}</td>
				<td>${volunteer.vol_date}</td>
				<td>${volunteer.vol_time}:00</td>
				<td>
				<c:if test="${volunteer.vol_checked == 0}">처리대기</c:if>
				<c:if test="${volunteer.vol_checked == 1}">승인</c:if>
				<c:if test="${volunteer.vol_checked == 2}">불승인</c:if>
				</td>
				<td>
					<c:if test="${volunteer.vol_checked == 0}">
					<input type=button value="승인" onclick="location.href='confirmVolunteer.do?vol_num=${volunteer.vol_num}'" class="detail btns"/>
					<input type=button value="불승인" onclick="location.href='notConfirmVolunteer.do?vol_num=${volunteer.vol_num}'" class="detail btns"/></td>
					</c:if>
				</td>
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