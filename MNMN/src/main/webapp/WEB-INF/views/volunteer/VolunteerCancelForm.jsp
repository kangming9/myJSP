<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>힘드냥 도울개</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		var cancelChecked = 0;
		
		//취소일에 신청 여부 확인
		$("#request_check").click(function(){
			if($("#canceldate").val().trim() == ""){
				alert("날짜를 선택하세요");
				$("canceldate").focus();
				$("canceldate").val("");
				return;
			}
			
			if($("#canceltime").val().trim() == ""){
				alert("시간을 선택하세요");
				$("canceltime").focus();
				$("canceltime").val("");
				return;
			}
			
			$('#message_cancel').text("");
			
			$.ajax({
				url:"checkDateRequest.do",
				type:"post",
				data:{date:$("#canceldate").val(), time:$("#canceltime").val()},
				dataType:"json",
				cache:false,
				timeout:30000,
				success:function(param){
					if(param.result == "Requested"){
						cancelChecked = 1;
						$("#message_cancel").css("color", "blue").text("신청");
					}
					else if(param.result == "NotRequested"){
						cancelChecked = 0;
						$("#message_cancel").css("color", "red").text("미신청");
					}
					else{
						cancelChecked = 0;
						alert("오류 발생");
					}
				},
				error:function(){
					cancelChecked = 0;
					alert("네트워크 오류 발생");
				}
			});
		});
		
		$("#Cancel_form #canceldate").keydown(function(){
			cancelChecked = 0;
			$("#message_cancel").text("");
		});
		
		$('#Cancel_form').submit(function(){
			if($('#canceldate').val().trim()==''){
				alert('날짜를 입력하세요!');
				$('#canceldate').focus();
				$('#canceldate').val('');
				return false;
			}
			if($('#time').val().trim()==''){
				alert('시간을 입력하세요!');
				$('#canceltime').focus();
				$('#canceltime').val('');
				return false;
			}
			if(cancelChecked == 0){
				alert('해당 날짜에 취소할 봉사가 있는지 확인해주세요!');
				return false;
			}
		});
	});
</script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<h2>봉사활동 취소</h2>
	<form id="Cancel_form" action="volunteerCancel.do" method="post">
		<ul>	
		<li>
			<label for="date">봉사 신청일</label>
			<input type="date" name="canceldate" id="canceldate">
			<input type="button" value="봉사신청확인" id="request_check">
			<span id="message_cancel"></span>
		</li>
		<li>
			<label for="time">봉사 신청 시간</label>
			<input type="number" id="canceltime" name="canceltime" min="9" max="18" required>
		</li>
		</ul>
		<div class="align-center">
			<input type="submit" value="취소">
			<input type="button" value="홈으로" 
			        onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
		</div>
	</form>
</div>
</body>
</html>