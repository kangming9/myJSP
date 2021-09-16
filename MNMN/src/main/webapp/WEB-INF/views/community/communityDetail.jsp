<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글상세</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_comdetail.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_comReply.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_footer.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap/bootstrap.min.css">
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script> 
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		var currentPage;
		var count;
		var rowCount;
		
		//댓글 리스트
		function selectData(pageNum){
			currentPage = pageNum;
			
			if(pageNum==1){//댓글 목록 초기화
				$('#output').empty(); 
			}
			$('#loading').show(); //댓글 로딩이미지 보이게함
			
			$.ajax({
				type:'post',
				data:{pageNum:pageNum,com_num:$('#com_num').val()},
				url:'${pageContext.request.contextPath}/communityReply/listReply.do',
				dataType:'json',
				cache:false,
				timeout:30000,
				success:function(param){
					$('#loading').hide();
					count = param.count;
					rowCount = param.rowCount;
					
					$(param.list).each(function(index,item){
						var output = '<div class="item" id="replyList">';
						output += '<span>' + count + '</span>';
						output += '<span id="repltListId">' + item.member_id + '</span>';
						output += '<span id="repltListDate">' + item.re_date + '</span>';
						output += '<div class="sub-item">';
							//로그인 회원번호와 작성자 회원번호 일치
							if($('#user_num').val() == item.member_num){
								output += "<button id='modify-"+item.re_num+"' onclick=modifyfunc("+item.re_num+"); class='modify'><i class='fas fa-ellipsis-v fa-xs'></i></button>";
								output += '<div id="modify-choice-btn">';
								output += '<div id="modify-choice-'+item.re_num+'" style="display:none;">';
								output += '<input type="button" data-renum="'+item.re_num+'" data-memnum="'+item.member_num+'" value="수정" class="modify-btn">';
								output += '<input type="button" data-renum="'+item.re_num+'" data-memnum="'+item.member_num+'" value="삭제" class="delete-btn">';
								output += "<button id='modify-"+item.re_num+"' onclick=backfunc("+item.re_num+"); class='button9'>취소</button>";
								output += '</div>';
								output += '</div>';
							}
							output += '<p style="word-break:break-all;" id="replyListContent">' + item.re_content + '</p>';
						output += '<hr color="#d3e0e3" size="1"; width="100%">';
						output += '</div>';
						output += '</div">';
						
						//배열로 반환받은 태그 문서객체에 추가
						$('#output').append(output);
					});
					
					
					
					//페이지 button 처리
					if(currentPage>=Math.ceil(count/rowCount)){//currentPage가 큼 =다음 페이지 없음
						$('.paging-button').hide();
					}else{
						$('.paging-button').show();
					}
				},
				error:function(){
					alert('네트워크 오류 발생');
				}
			});
		}
		
		//페이지 처리 이벤트 연결
		$('.paging-button input').click(function(){
			selectData(currentPage + 1); //페이지 아니면 기존데이터 냅두고 페이지 붙임
		});
		
		//댓글 등록
		$('#re_form').submit(function(event){
			if($('#re_content').val().trim() == ''){
				alert('내용을 입력하세요!');
				$('#re_content').val('').focus();
				return false;
			}
			
			//form 이하의 태그에 입력한 데이터를 모두 읽어옴
			var form_data = $(this).serialize();
			
			//댓글 등록
			$.ajax({
				type:'post',
				data:form_data,
				url:'${pageContext.request.contextPath}/communityReply/writeReply.do',
				dataType:'json',
				cache:false,
				timeout:30000,
				success:function(param){
					if(param.result == 'logout'){
						alert('로그인해야 작성할 수 있습니다.');
					}else if(param.result == 'success'){
						//폼 초기화
						initForm();
						//댓글 작성이 성공하면 새로 삽입한 글을 포함해서 첫번째 페이지의 게시글을 다시 호출함
						selectData(1);
					}else{
						alert('등록시 오류 발생');
					}
				},
				error:function(){
					alert('네트워크 오류!');
				}
			});
			
			//기본 이벤트 제거
			event.preventDefault();
		});
		//댓글 작성 폼 초기화
		function initForm(){
			$('textarea').val('');
			$('#re_first .letter-count').text('300/300');
		}
		//댓글 글자수 체크
		$(document).on('keyup','textarea',function(){
			//입력한 글자
			var inputLength = $(this).val().length;
			
			if(inputLength > 300){//300글자 넘은 경우 자름
				$(this).val($(this).val().substring(0,300));
			}else{//300글자 이하인 경우
				var remain = 300 - inputLength;
				remain += '/300'; 
				
				if($(this).attr('id')=='re_content'){
					$('#re_first .letter-count').text(remain); //댓글 등록시 글자수
				}else{
					$('#mre_first .letter-count').text(remain); // 댓글 수정시 글자수
				}
			}
		});
		
		//댓글 수정버튼 클릭 시 수정폼
		$(document).on('click','.modify-btn',function(){
			var re_num = $(this).attr('data-renum'); //댓 번호
			var num = $(this).attr('data-memnum');
			var content = $(this).parents().find('#replyListContent').html();
			
			var modifyUI = '<form id="mre_form" style="padding:0; width:100%; border:none;">';
				modifyUI += '	<input type="hidden" name="re_num" id="mre_num" value="'+re_num+'">';
				modifyUI += '	<input type="hidden" name="mem_num" id="muser_num" value="'+num+'">';
				modifyUI += '  	<textarea rows="3" cols="50" name="re_content" id="mre_content" class="rep-content" style="width:100%; height:60px; resize:none; margin: 5px 0;">'+content+'</textarea>';
			    modifyUI += ' 	<div id="mre_first" style="text-align: right;"><span class="letter-count">300/300</span>&nbsp;';
				modifyUI += '  	<div id="mre_second" class="align-right" style="display: flex; float:right;">';
				modifyUI += '    	<input type="submit" value="수정" class="button9" onclick=backfunc("'+re_num+'");>';
				modifyUI += '    	<input type="button" value="취소" class="re-reset button9" onclick=backfunc("'+re_num+'");>';
				modifyUI += '  	</div>';
				modifyUI += '  	</div>';
				modifyUI += '</form>';
				
				initModifyForm(); //수정버튼 클릭시 기존 댓글 가림
				$(this).parents('.sub-item').hide();
				$(this).parents('.item').append(modifyUI);
				
				var inputLength = $('#mre_content').val().length;
				var remain = 300 - inputLength;
				remain += '/300';
				
				//문서 객체 반영
				$('#mre_first .letter-count').text(remain);
		});
		//수정폼에서 취소버튼 클릭시 수정폼 초기화
		$(document).on('click','.re-reset',function(){
			initModifyForm();
		});
		//댓글 수정 폼 초기화
		function initModifyForm(){
			$('.sub-item').show();
			$('#mre_form').remove();
		}
		//댓글 수정
		$(document).on('submit','#mre_form',function(event){
			if($('#mre_content').val().trim()==''){
				alert('내용을 입력하세요!');
				$('#mre_content').val('').focus();
				return false;
			}
			
			var form_data = $(this).serialize();//전체 데이터 뽑음
			
			//수정
			$.ajax({
				url:'${pageContext.request.contextPath}/communityReply/updateReply.do',
				type:'post',
				data:form_data,
				dataType:'json',
				cache:false,
				timeout:30000,
				success:function(param){
					if(param.result=='logout'){
						alert('로그인해야 수정할 수 있습니다.');
					}else if(param.result=='success'){
						$('#mre_form').parent().find('p').html($('#mre_content').val());
						//수정폼 삭제 및 초기화
						initModifyForm();
					}else if(param.result=='wrongAccess'){
						alert('타인의 글을 수정할 수 없습니다.');
					}else{
						alert('수정 오류 발생');
					}
				},
				error:function(){
					alert('네트워크 오류 발생');
				}
			});
			//기본 이벤트 제거
			event.preventDefault();
		});
		
		//댓글 삭제
		$(document).on('click','.delete-btn',function(){
			var re_num = $(this).attr('data-renum'); //댓글번호
			var num = $(this).attr('data-memnum'); //회원번호
	
			$.ajax({
				type:'post',
				url:'${pageContext.request.contextPath}/communityReply/deleteReply.do',
				data:{re_num:re_num,mem_num:num},
				dataType:'json',
				cache:false,
				timeout:30000,
				success:function(param){
					if(param.result == 'logout'){
						alert('로그인해야 삭제할 수 있습니다.');
					}else if(param.result == 'success'){
						alert('삭제 완료!');
						selectData(1);
					}else if(param.result == 'wrongAccess'){
						alert('타인의 글을 삭제할 수 없습니다.');
					}else{
						alert('삭제시 오류 발생');
					}
				},
				error:function(){
					alert('네트워크 오류 발생33');
				}
			});
		});
		
		//게시물 들어가면 댓글목록 처음 호출하게 함
		selectData(1);
	});
	
	function modifyfunc(re_num){//리스트에서 수정, 취소 버튼 뜨게함
		var mshow = '#modify-choice-'+re_num;
		var mhide = '#modify-'+re_num;
		$(mshow).show();
		$(mhide).hide();
	}
	
	function backfunc(re_num){//리스트에서 ...표시 뜨게함
		var mshow = '#modify-choice-'+re_num;
		var mhide = '#modify-'+re_num;
		$(mshow).hide();
		$(mhide).show();
	}
</script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="container">
	<div class="box">
	<h2 class="title">${com.com_title}</h2>
	<ul>
		<li>글번호 : ${com.com_num}</li>
		<li>작성자 : ${com.com_member_id}</li>
		<li>조회수 : ${com.com_hit}</li>
	</ul>
	<hr size="1" noshade width="90%">
	<p style="word-break:break-all;">
      ${com.com_content}
   </p>
	<hr size="1" noshade width="90%">
	<div class="align-right" id="btns">
		작성일 : ${com.com_date}
		<%-- 로그인한 회원번호 == 작성자 회원번호 --%>
		<c:if test="${user_num == com.com_member_num}">
		<input type="button" value="수정" onclick="location.href='updateCommunityForm.do?com_num=${com.com_num}'" class="btn-style">
		<input type="button" value="삭제" id="delete_btn" class="btn-style">	
		<script type="text/javascript">
			var delete_btn = document.getElementById('delete_btn');
			//이벤트 연결
			delete_btn.onclick=function(){
				var choice = confirm('삭제하시겠습니까?');
				if(choice){
					location.replace('deleteCommunity.do?com_num=${com.com_num}');
				}
			};
		</script>
		</c:if>
		<input type="button" value="목록" onclick="location.href='communityList.do'" class="btn-style-cancel">
	</div>
	</div>
	<!-- 댓글 목록 시작 -->
	<div id="output"></div>
	<div class="paging-button" style="display:none;">
		<input type="button" class="btn btn-secondary btn-sm" value="다음글 보기">
	</div>
	<div id="loading" style="display: none;">
		<img src="${pageContext.request.contextPath}/images/ajax-loader.gif">
	</div>
	<!-- 댓글 목록 끝 -->
	<!-- 댓글 시작 -->
	<div id="reply_div">
		<form id="re_form">
			<input type="hidden" name="com_num" value="${com.com_num}" id="com_num">
			<input type="hidden" name="com_member_num" value="${user_num}" id="user_num">
			<textarea rows="3" cols="50" name="re_content" id="re_content" class="rep-content"
			   <c:if test="${empty user_num}">disabled="disabled"</c:if>
			><c:if test="${empty user_num}">로그인해야 작성할 수 있습니다.</c:if></textarea>
			<c:if test="${!empty user_num}">
			<div id="re_second" class="align-right">
				<input type="submit" class="btn btn-danger btn-sm" value="전송">
			</div>
			<div id="re_first">
				<span class="letter-count">300/300</span>
			</div>	
			</c:if>
		</form>
	</div>
	<!-- 댓글 끝 -->
</div>
	<!-- footer 시작 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	<!-- footer 끝 -->
</div><!-- 같은 배경 안하실 거면 이걸 댓글 시작 전으로 옮겨주세요 -->
</body>
</html>














