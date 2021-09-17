<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>멍냥멍냥</title>

<script>
	
	function ButtonOne(){
		document.getElementById('intro1').style.display = "inline";
		document.getElementById('intro2').style.display ="none";
		document.getElementById('intro3').style.display ="none";
		document.getElementById('intro4').style.display ="none";
		document.getElementById('intro5').style.display ="none";
		
		document.getElementById('main_btn1').style.backgroundColor ="#39A2DB";
		document.getElementById('main_btn2').style.backgroundColor ="#A2DBFA";
		document.getElementById('main_btn3').style.backgroundColor ="#A2DBFA";
		document.getElementById('main_btn4').style.backgroundColor ="#A2DBFA";
		document.getElementById('main_btn5').style.backgroundColor ="#A2DBFA";
	}
	function ButtonTwo(){
		document.getElementById('intro2').style.display = "inline";
		document.getElementById('intro1').style.display ="none";
		document.getElementById('intro3').style.display ="none";
		document.getElementById('intro4').style.display ="none";
		document.getElementById('intro5').style.display ="none";
		
		document.getElementById('main_btn2').style.backgroundColor ="#39A2DB";
		document.getElementById('main_btn1').style.backgroundColor ="#A2DBFA";
		document.getElementById('main_btn3').style.backgroundColor ="#A2DBFA";
		document.getElementById('main_btn4').style.backgroundColor ="#A2DBFA";
		document.getElementById('main_btn5').style.backgroundColor ="#A2DBFA";
	}
	function ButtonThree(){
		document.getElementById('intro3').style.display = "inline";
		document.getElementById('intro1').style.display ="none";
		document.getElementById('intro2').style.display ="none";
		document.getElementById('intro4').style.display ="none";
		document.getElementById('intro5').style.display ="none";
		
		document.getElementById('main_btn3').style.backgroundColor ="#39A2DB";
		document.getElementById('main_btn1').style.backgroundColor ="#A2DBFA";
		document.getElementById('main_btn2').style.backgroundColor ="#A2DBFA";
		document.getElementById('main_btn4').style.backgroundColor ="#A2DBFA";
		document.getElementById('main_btn5').style.backgroundColor ="#A2DBFA";
	}
	function ButtonFour(){
		document.getElementById('intro4').style.display = "inline";
		document.getElementById('intro1').style.display ="none";
		document.getElementById('intro2').style.display ="none";
		document.getElementById('intro3').style.display ="none";
		document.getElementById('intro5').style.display ="none";
		
		document.getElementById('main_btn4').style.backgroundColor ="#39A2DB";
		document.getElementById('main_btn1').style.backgroundColor ="#A2DBFA";
		document.getElementById('main_btn2').style.backgroundColor ="#A2DBFA";
		document.getElementById('main_btn3').style.backgroundColor ="#A2DBFA";
		document.getElementById('main_btn5').style.backgroundColor ="#A2DBFA";
	}
	function ButtonFive(){
		document.getElementById('intro5').style.display = "inline";
		document.getElementById('intro1').style.display ="none";
		document.getElementById('intro2').style.display ="none";
		document.getElementById('intro3').style.display ="none";
		document.getElementById('intro4').style.display ="none";
		
		document.getElementById('main_btn5').style.backgroundColor ="#39A2DB";
		document.getElementById('main_btn1').style.backgroundColor ="#A2DBFA";
		document.getElementById('main_btn2').style.backgroundColor ="#A2DBFA";
		document.getElementById('main_btn3').style.backgroundColor ="#A2DBFA";
		document.getElementById('main_btn4').style.backgroundColor ="#A2DBFA";
	}
</script>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_main.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_footer.css" type="text/css">
</head>
<body>
<div class="page-main">
	<!-- header 시작 -->
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<!-- header 끝 -->
	<div class="container" id="about">
	  <div class="content" style="max-width:700px">
	    <span class="tag wide"  style="background-color:#A2DBFA; color:white">멍냥멍냥 입양센터</span>
	    <p>안녕하세요. 유기동물 입양센터, <strong>멍냥멍냥</strong>입니다.동물들과 공존하는 삶의 소중함과 그 가치를 널리 알리고, 함께 더불어 살아가는 삶을 위해 항상 힘쓰겠습니다. 오늘도 더 많은 생명에게 좋은 친구가 될 수 있도록, 따뜻한 가정의 품을 안겨줄 수 있도록 노력하겠습니다.</p>
	    <p>저희의 가치에 동감하고 함께 하고 싶으시다면 언제든 센터를 방문해주세요. 멍냥멍냥의 문은 언제나 활짝 열려있으며 많은 아이들이 여러분의 다정한 마음을 기다리고 있습니다. 한 번의 눈길, 한 시간의 봉사, 하나의 후원이 아이들에게 큰 힘이 됩니다. </p>
	    </div>
	    <img src="${pageContext.request.contextPath}/images/main.jpg" style="width:100%;max-width:1000px" class="w3-margin-top">
	    <p><strong>운영 시간:</strong> 매일 오전 8시부터 오후 10시까지.</p>
	    <p><strong>주소:</strong> 서울시 마포구 어딘가.</p>
	    <p><strong>문의:</strong> 02-1234-5678</p>
	    <img src="${pageContext.request.contextPath}/images/main2.jpg" style="width:100%;max-width:1000px" class="w3-margin-top">
	    <div style="margin:20px 0px"><span class="tag wide"  style="background-color:#A2DBFA; color:white">멍냥멍냥 게시판</span></div>
	    <div class="intro">
	    	<button id="main_btn1" onclick="ButtonOne()">소개할개<i class="far fa-smile-wink"></i></button>
	    	<button id="main_btn2" onclick="ButtonTwo()">힘드냥<i class="fas fa-paw fa-xs"></i>도울개</button>
	    	<button id="main_btn3" onclick="ButtonThree()">기다리개<i class="fas fa-user"></i></button>
	    	<button id="main_btn4" onclick="ButtonFour()">찾았냥<i class="fas fa-paw fa-xs"></i></button>
	    	<button id="main_btn5" onclick="ButtonFive()">멍냥토크<i class="fas fa-comment"></i></button>
	    	<div id="main_intro">
	    		<div id="intro1" style="display:inline;">소개할개는 유기동물 입양센터 멍냥멍냥에 대해 소개하는 공간입니다.<br>
	    		멍냥멍냥에서 어떤 일을 하고 있는지, 어떻게 하면 함께 할 수 있는지, 어디에 위치해 있는지, 가족분들의 후원이 어디에 쓰이고 있는지 등에 대해 적혀있습니다.</div>
	    		<div id="intro2" style="display:none;">힘드냥도울개는 센터에 도움을 주시고 싶으신 분들을 위한 공간입니다.<br>
	    		원하시는 경우, 멍냥멍냥에 직접 방문하셔서 봉사활동을 하실 수 있습니다. 오전 9시부터 오후 6시까지 신청 가능하며 회원으로 가입된 경우에만 가능합니다.
	    		동물 친구들을 만나보실 수도 있고, 어떤 환경에서 지내고 있는지도 두 눈으로 확인 가능하니 기다리개에서 가족으로 함께하고 싶은 친구가 있다면 직접 만나보시면 좋을 것 같습니다.</div>
	    		<div id="intro3" style="display:none;">기다리개는 가족을 기다리고 있는 친구들을 소개하는 공간입니다.<br>
	    		열악한 환경에서 구조되었거나 유기된 경험이 있는 등 아픈 상처를 가진 멍냥친구들이 기다리고 있습니다. 센터에 머물면서 새로운 가족을 기다리고 있는 사랑스러운 친구들이 많이 있습니다.
	    		마음이 가는 멍냥친구가 있다면 센터로 문의를 주시거나 봉사활동을 신청해 한 번쯤 직접 만나보시는 것도 좋은 방법입니다.
	    		쉬운 일은 아니지만 충분한 가치가 있는 일이니 신중히 생각하시고 새로운 가족을 맞이해보시는 건 어떨까요?</div>
	    		<div id="intro4" style="display:none;">찾았냥은 멍냥센터를 통해 가족의 연을 맺은 회원분들을 위한 공간입니다.<br>
	    		기다리개나 봉사활동을 통해 마음이 가는 멍냥친구와 평생을 함께하기로 약속한 많은 회원분들의 소식이 궁금할 때가 종종 있습니다.
	    		멍냥센터에서 지내던 친구들이 가족들과 어떤 시간을 보내고 있는지 알려주고 싶으시다면 사진과 함께 어떤 날들을 보내고 있는지 남겨주세요.
	    		새로운 가족과 행복한 날들을 보내는 멍냥친구들의 모습은 멍냥멍냥 입양센터 직원들에게는 큰 힘이, 새로운 가족을 맞이하고 싶은 다른 회원분들껜 하나의 계기가 되기도 합니다.</div>
	    		<div id="intro5" style="display:none;">멍냥토크는 센터의 회원분들을 위한 공간입니다.<br>
	    		꼭 멍냥친구들의 소식을 들려주는 일이 아니더라도 각종 건의, 문의, 잡담 등 하고 싶은 이야기가 많으실 우리 회원님들만의 자유로운 게시판이 필요할 것 같아 개설하였습니다.
	    		올려주신 건의나 문의는 틈틈이 확인하고 답변을 드리고 있으며, 올려주시는 각종 소식과 이야기들은 멍냥센터 직원들도 재미있게 보고 있습니다.
	    		센터와 회원들과 소통하고 싶다면 작은 이야기라도 좋으니 멍냥토크에 남겨주세요. </div>
	    	</div>
	   	</div>
	</div>
	<!-- footer 시작 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	<!-- footer 끝 -->
</div>
</body>
</html>