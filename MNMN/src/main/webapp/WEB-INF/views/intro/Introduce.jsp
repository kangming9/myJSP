<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>About 멍냥멍냥</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_intro.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_footer.css" type="text/css">
</head>
<body>
	<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="container">
		<span class="intro">About 멍냥멍냥</span>
		<div class="content">
			유기동물 입양센터<h3 style="color:white;">멍냥멍냥</h3>
			<h5>새 보금자리를 찾을 때까지 유기동물을 보호하고<br>
			새로운 가족과 함께 할 수 있는 자리를 마련하고 있습니다.</h5>
			<p id="adopt"><strong>사지 말고 입양하세요</strong></p>
			<p>함께 하면 더욱 쉽습니다.<br>
			센터 회원이 되면 다양한 방법으로 유기동물들을 도울 수 있습니다.<br>
			희망하시는 날짜에 봉사활동을 하실 수도,<br>
			소중하고 따뜻한 마음을 후원하실 수도,
			센터 아이들의 새로운 가족이 되어주실 수도 있습니다.</p>
			<div style="margin-top:50px;">
			<p>따뜻한 후원은 이렇게 쓰입니다.</p>
			<p id="money">열악한 환경의 유기동물 구조<br>
			센터 동물들의 입양 지원<br>
			동물보호 캠페인 및 교육</p>
			</div>
			<div style="margin-bottom:50px;">
			<p>반려동물을 사랑하고 유기동물을 걱정하는 여러분의 많은 관심이 필요합니다.</p>
			</div>
			<span id="donabtn" onclick="location.href='${pageContext.request.contextPath}/donation/donation.do'">후원하기</span>
		</div>
		
	</div>
	<!-- footer 시작 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	<!-- footer 끝 -->
	</div>
</body>
</html>