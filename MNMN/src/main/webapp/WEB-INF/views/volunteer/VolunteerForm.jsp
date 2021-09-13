<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>힘드냥 도울개</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_volunteer.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(function(){
	function c(){
		p();
		
		var e=h();
		var r=0;
		var u=false;
		
		l.empty();
		
		while(!u){
			if(s[r]==e[0].weekday){
			u=true
			}else{
				l.append('<div class="blank"></div>');
				r++
			}
		}
		for(var c=0;c<42-r;c++){
			if(c>=e.length){
				l.append('<div class="blank"></div>')
			}else{

				var v=e[c].day;
				var m=g(new Date(t,n-1,v))?'<div class="today">':"<div>";
				
				var str = m+""+v + "(";
				var newstr = Voldata(str);
				console.log(newstr);
				
			}
		}
		
		a.find("h1").text(i[n-1]+" "+t);
		
		d()
	}
	
	
	function Voldata(str){ 
		
		$.ajax({
			url:"checkDateVol.do",
			type:"post",
			data:{"date":datecheck},
			dataType:"json",
			async:false,
			cache:false,
			timeout:30000,
			success:function(param){
				if(param.result){
					var idate = (param.result).toString();
					dateVol = idate;
					str += dateVol;
					str += ")"+"</div>";
					
					console.log("고친 데이터 : " + str);
					l.append(str);
				}else{
					alert("오류 발생");
				}
			},
			error:function(){
				alert("네트워크 오류 발생");
			}
			
		});
				
		return str;
	};
	
	
	function h(){
		var e=[];
		for(var r=1;r<v(t,n)+1;r++){
			e.push({day:r,weekday:s[m(t,n,r)]})
		}
		return e
	}
	
	function p(){
		f.empty();
		for(var e=0;e<7;e++){
			f.append("<div>"+s[e]+"</div>")
		}
	}
	
	function d(){
		var t;
		var n=$("#calendar").css("width",e+"px");
		n.find(t="#calendar_weekdays, #calendar_content").css("width",e+"px").find("div").css({width:e/7+"px",height:e/7+"px","line-height":e/7+"px"});
		n.find("#calendar_header").css({height:e*(1/7)+"px"}).find('#left').css("line-height",e*(1/7)+"px");
		n.find("#calendar_header").css({height:e*(1/7)+"px"}).find('#right').css("line-height",e*(1/7)+"px")
	}
	function v(e,t){
		return(new Date(e,t,0)).getDate()
	}
	
	function m(e,t,n){
		return(new Date(e,t-1,n)).getDay()
	}
	
	function g(e){
		return y(new Date)==y(e)
	}
	
	function y(e){
		
		datecheck = e.getFullYear()+"/"+(e.getMonth()+1)+"/"+e.getDate();
		
		return datecheck;
	}
	
	function b(){
		var e=new Date;
		t=e.getFullYear();
		n=e.getMonth()+1
	}
	
	var datecheck = "1999/01/01";
	var e=480;
	var t=2013;
	var n=9;
	var r=[];
	var i=["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"];
	var s=["일","월","화","수","목","금","토"];
	var u=$("#calendar");
	var a=u.find("#calendar_header");
	var f=u.find("#calendar_weekdays");
	var l=u.find("#calendar_content");
	var dateVol = 0;
	
	b();
	c();
	a.find("#left").on("click",function(){
														var e=$(this);
														var r=function(e){
															n=e=="next"?n+1:n-1;
															if(n<1){n=12; t--}
															else if(n>12){n=1; t++}
															c()
														};
														r("previous")
									})
	a.find("#right").on("click",function(){
														var e=$(this);
														var r=function(e){
															n=e=="next"?n+1:n-1;
															if(n<1){n=12; t--}
															else if(n>12){n=1; t++}
															c()
														};
														r("next")
									})
	})
</script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	
	<div class="container" style="background-color:#E8F0F2">
	
		<div><span class="tag wide"  style="background-color:#A2DBFA; color:white">봉사활동 신청 및 취소</span></div>
	
	<div id="calendar">
	    <div id="calendar_header">
	    	<i class="fas fa-chevron-left" id="left"></i>
	    		<h1></h1>
	    	<i class="fas fa-chevron-right" id="right"></i>
	    </div>
	    <div id="calendar_weekdays"></div>
	    <div id="calendar_content"></div>
	</div>
	
	<div class="align-center vol_button_group">
		<input type="button" value="신청하기" class="button_vol" id="req_vol"
			        onclick="location.href='${pageContext.request.contextPath}/volunteer/volunteerUserForm.do'">
		<input type="button" value="취소하기" class="button_vol" id="can_vol"
			        onclick="location.href='${pageContext.request.contextPath}/volunteer/volunteerCancelForm.do'"><br>
	</div>
	<div class="align-center">
		<input type="button" value="홈으로" id="button_home"
			        onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
	</div>
</div>
</div>
</body>
</html>