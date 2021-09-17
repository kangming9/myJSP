<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>힘드냥 도울개</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_vol.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_footer.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		var fullChecked=0;
		var alreadyChecked=0;
		var checked = 0;
		
		//신청 날짜 인원 초과 체크
		$("#date_check").click(function(){
			if($("#date").val() == ""){
				alert("날짜를 선택하세요");
				$("date").focus();
				$("date").val("");
				return;
			}
			
			if($("#time").val() == ""){
				alert("시간을 선택하세요");
				$("time").focus();
				$("time").val("");
				return;
			}
			
			var nyear = new Date().getFullYear();
			var nmonth = new Date().getMonth() + 1;
			var nday = new Date().getDate();
			
			var date = $("#date").val();
			date = date + "";
			var date_arr = date.split("-");
			
			var now = new Date(nyear, nmonth, nday);
			var pick = new Date(date_arr[0], date_arr[1], date_arr[2]);
			
			if(now >= pick)
				alert("지난 날짜는 신청이 불가능합니다:(");

			
			$('#message_date').text("");	
			$('#message_already').text("");
			
			$.ajax({
				url:"checkDateFull.do",
				type:"post",
				async:false,
				data:{date:$("#date").val(), time:$("#time").val()},
				dataType:"json",
				cache:false,
				timeout:30000,
				success:function(param){
					if(param.result == "LessThan"){
						fullChecked = 1;
					}
					else if(param.result == "MoreThan"){
						fullChecked = 0;
					}
					else{
						fullChecked = 0;
						alert("오류 발생");
					}
				},
				error:function(){
					fullChecked = 0;
					alert("네트워크 오류 발생");
				}
			});
			
			
			$.ajax({
				url:"checkAlready.do",
				type:"post",
				async:false,
				data:{date:$("#date").val(), time:$("#time").val()},
				dataType:"json",
				cache:false,
				timeout:30000,
				success:function(param){
					if(param.result == "Yet"){
						alreadyChecked = 1;
						
					}
					else if(param.result == "Already"){
						alreadyChecked = 0;
					}
					else{
						alreadyChecked = 0;
						alert("오류 발생");
					}
				},
				error:function(){
					alreadyChecked = 0;
					alert("네트워크 오류 발생");
				}
			});
			
			if (fullChecked == 1){
				if(alreadyChecked == 1){
					checked = 1;
					$("#message_date").css("color", "blue").text("신청 가능");
					$('#message_already').css("color", "blue").text("선택하신 날짜와 시간에 봉사 신청이 가능합니다:D");
				}else{
					checked = 0;
					$("#message_date").css("color", "red").text("신청 불가");
					$('#message_already').css("color", "red").text("이미 신청해주신 봉사 내역이 있습니다:(");
				}
			}else if(fullChecked == 0){
				if(alreadyChecked == 1){
					checked = 0;
					$("#message_date").css("color", "red").text("신청 불가");
					$('#message_already').css("color", "red").text("이미 많은 봉사자분들이 선택해주신 날짜입니다:(");
				}else{
					checked = 0;
					$("#message_date").css("color", "red").text("신청 불가");
					$('#message_already').css("color", "red").text("이미 신청해주신 봉사 내역이 있습니다:(");
				}
			}
		
			if(now >= pick){
				checked = 0;
				$("#message_date").css("color", "red").text("신청 불가");
				$('#message_already').css("color", "red").text("지나간 날짜와 오늘은 신청이 불가능합니다:(");
			}
		});
		
		$('#volunteer_form #date').keydown(function(){
	         checked = 0;
	    });
	      
	    $('#volunteer_form #time').keydown(function(){
	         checked = 0;
	    });
				
		$('#volunteer_form').submit(function(){
			if($('#date').val()==''){
				alert('날짜를 입력하세요!');
				$('#date').focus();
				$('#date').val('');
				return false;
			}
			if($('#time').val()==''){
				alert('시간을 입력하세요!');
				$('#time').focus();
				$('#time').val('');
				return false;
			}
			if(checked == 0){
				alert('해당 날짜에 봉사가 가능한지 확인해주세요!');
				return false;
			}
		});
	});
</script>
</head>
<body>
<div class="page-main">
	<!-- header 시작 -->
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
		<!-- header 끝 -->
	<div class="container">
	<span id="title">봉사활동 신청</span>
	<div id="form"><form id="volunteer_form" action="volunteerUser.do" method="post">

			<label for="date">봉사 신청일</label><br>
			<input type="date" name="date" id="date"><br>
			<input class="button" type="button" value="봉사가능확인" id="date_check"><br>
			<span id="message_date"></span><br><br>
			<label for="time">봉사 시작 시간</label><br>
			<input type="number" id="time" name="time" min="9" max="18" required><br>
			<span id="message_already"></span>

		<div class="align-center">
			<input class="button" type="submit" value="신청">
			<input class="button"  type="button" value="홈으로" 
			        onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
		</div>
	</form>
	</div>
	</div>
		<!-- footer 시작 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	<!-- footer 끝 -->
</div>
</body>
</html>