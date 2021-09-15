<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신규 봉사 신청자</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_mypage.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_footer.css" type="text/css">
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<h2>신규 봉사 신청자</h2>
	<div class="list-space align-right">
		<input type="button" value="홈으로" onclick="location.href='${pageContext.request.contextPath}/main/main.do'" class="home_btn">
	</div>
	<c:if test="${count == 0}">
	<div class="result-display">
		신규 봉사 신청자가 없습니다.
	</div>
	</c:if>
	<c:if test="${count > 0}">
	<div class="tb-container">
		<table>
			<thead class="tb-header">
				<tr>
					<th>신청자</th>
					<th>신청일</th>
					<th>봉사일</th>
					<th>봉사 시작 시간</th>
					<th>확인</th>
				</tr>
			</thead>
			<tbody class="tb-content">
			<c:forEach var="volunteer" items="${list}">
			<tr>
				<td>${volunteer.vol_m_id}</td>
				<td>${volunteer.vol_reg_date}</td>
				<td>${volunteer.vol_date}</td>
				<td>${volunteer.vol_time}:00</td>
				<td><input type=button value="승인" onclick="location.href='confirmVolunteer.do?vol_num=${volunteer.vol_num}'" class="update_btn"/>
				<input type=button value="불승인" onclick="location.href='notConfirmVolunteer.do?vol_num=${volunteer.vol_num}'" class="update_btn"/></td>
			</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>
	<div class="align-center">
		${pagingHtml}
	</div>
	</c:if>
		<!-- footer 시작 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	<!-- footer 끝 -->
</div>
</body>
</html>