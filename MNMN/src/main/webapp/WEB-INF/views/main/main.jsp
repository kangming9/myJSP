<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>멍냥멍냥</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
</head>
<body>
<div class="page-main">
	<!-- header 시작 -->
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<!-- header 끝 -->
	<div class="container" id="about" style="background-color:#E8F0F2">
	  <div class="content" style="max-width:700px">
	    <span class="tag wide"  style="background-color:#053742; color:white">멍냥멍냥 입양센터</span>
	    <p>동물의 소중함과 동행의 가치를 널리 알리고, 함께 더불어 살아가는 삶을 위해 노력하는 유기동물 입양센터, 멍냥멍냥입니다. 오늘도 더 많은 생명에게 좋은 친구가 될 수 있도록, 따뜻한 가정의 품을 안겨줄 수 있도록 노력하겠습니다.</p>
	    <p>저희의 가치에 동감하고 함께 하고 싶으시다면 언제든 센터를 방문해주세요. 멍냥멍냥의 문은 언제나 활짝 열려있으며 많은 아이들이 여러분의 다정한 마음을 기다리고 있습니다. 한 번의 눈길, 한 시간의 봉사, 하나의 후원이 아이들에게 큰 힘이 됩니다. </p>
	    </div>
	    <img src="${pageContext.request.contextPath}/images/main.jpg" style="width:100%;max-width:1000px" class="w3-margin-top">
	    <p><strong>운영 시간:</strong> 매일 오전 8시부터 오후 10시까지.</p>
	    <p><strong>주소:</strong> 서울시 마포구 어딘가.</p>
	    <p><strong>문의:</strong> 02-1234-5678</p>
	</div>
</div>
</body>
</html>