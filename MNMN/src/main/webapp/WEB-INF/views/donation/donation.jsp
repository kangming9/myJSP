<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>멍냥멍냥 후원</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_donation.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_footer.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
	$("birth").value = "1990-01-01";
	
	$('#donation_form').submit(function(){
		if($('#name').val()==''){
			alert('이름을 입력하세요!');
			$('#name').focus();
			$('#name').val('');
			return false;
		}
		if($('#birth').val()==''){
			alert('생년월일을 입력하세요!');
			$('#birth').focus();
			$('#birth').val('');
			return false;
		}
		if($('#addr').val()==''){
			alert('주소를 입력하세요!');
			$('#addr').focus();
			$('#addr').val('');
			return false;
		}
		if($('#phone').val()==''){
			alert('전화번호를 입력하세요!');
			$('#phone').focus();
			$('#phone').val('');
			return false;
		}
		if($('#email').val()==''){
			alert('이메일을 입력하세요!');
			$('#email').focus();
			$('#email').val('');
			return false;
		}
		
		if($('#money').val()==''){
			alert('후원금액을 입력하세요!');
			$('#money').focus();
			$('#money').val('');
			return false;
		}
		if($('#bank').val()==''){
			alert('은행명을 입력하세요!');
			$('#bank').focus();
			$('#bank').val('');
			return false;
		}
		if($('#account').val()==''){
			alert('계좌번호를 입력하세요!');
			$('#account').focus();
			$('#account').val('');
			return false;
		}
		if($('#acname').val()==''){
			alert('예금주명을 입력하세요!');
			$('#acname').focus();
			$('#acname').val('');
			return false;
		}
	});
});
</script>
</head>
<body>
	<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="container_don">
		<div id="form">
			<form id ="donation_form" action="donationDo.do" method="post" class="don-form">
				<span class="form_title">후원자 정보</span>
				<ul>
					<li>
					<label>성명(단체명)</label>
					<input type="text" name="name" id="name">
					</li>
					<li>
					<label>생년월일</label>
					<input type="date" name="birth" id="birth">
					</li>
					<li>
					<label>주소</label>
					<input type="text" name="addr" id="addr">
					</li>
					<li>
					<label>전화번호</label>
					<input type="tel" name="phone" id="phone" size="27" pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}" />
					<select name="susin_m" id="susin_m">
						<option>수신 동의</option>
						<option>수신 거부</option>
					</select>
					</li>
					<li>
					<label>이메일</label>
					<input type="email" name="email" id="email">
					<select name="susin_e" id="susin_e">
						<option>수신 동의</option>
						<option>수신 거부</option>
					</select>
					</li>
				</ul>
				
				<br><br>
				<span class="form_title">후원자 계좌 정보</span><br>
				<ul>
				<li>
				<label>후원 구분</label>
				<select name="division" id="division">
					<option>정기 후원</option>
					<option>일시 후원</option>
				</select>
				</li>
				<li>
				<label>후원금액</label>
				<input type="number" name="money" id="money" value="1000" min="1000" step="1000"> 원
				</li>
				<li>
				<label>은행명</label>
				<input type="text" name="bank" id="bank">
				</li>
				<li>
				<label>계좌번호</label>
				<input type="text" name="account" id="account">
				</li>
				<li>
				<label>예금주명</label>
				<input type="text" name="acname" id="acname">
				</li>
				</ul>
				<div>
				<input type="submit" id="submit" value="후원">
				</div>
			</form>
		</div>
		<div id="explain">
		<span id="ex_title">후원 관련 안내</span>
		<p>
		최근 물품 후원과 관련된 문의가 많이 오고 있습니다.<br>
		사료, 간식, 모래, 배변패드 뿐 아니라 헌 이불, 휴지, 물티슈 등 다양한 물건들이 센터에 필요합니다.<br>
		소량이라도 좋으니 물품 후원을 원하시는 분들은 센터로 전화 문의 부탁드립니다.<br> 
		보내주신 물품들은 센터 아이들과 구조될 아이들의 따뜻한 하루를 위해 사용됩니다.
		</p>
		</div>
	</div>
	<!-- footer 시작 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	<!-- footer 끝 -->
	</div>
</body>
</html>