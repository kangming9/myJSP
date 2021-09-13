<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글상세</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		var currentPage;
		var count;
		var rowCount;
		//댓글 목록
		function selectData(pageNum){
			currentPage = pageNum;
			
			if(pageNum == 1){
				//처음 호출시는 해당 ID의 div의 내부 내용물을 제거
				$('#output').empty();
			}
			
			//로딩 이미지 노출
			$('#loading').show();
			
			$.ajax({
				type:'post',
				data:{pageNum:pageNum,board_num:$('#board_num').val()},
				url:'listReply.do',
				dataType:'json',
				cache:false,
				timeout:30000,
				success:function(param){
					//로딩 이미지 감추기
					$('#loading').hide();
					count = param.count;
					rowCount = param.rowCount;
					
					$(param.list).each(function(index,item){
						var output = '<div class="item">';
						output += '<h4>' + item.id + '</h4>';
						output += '<div class="sub-item">';
						output += '<p>' + item.re_content + '</p>';
						output += item.re_date;
						//로그인한 회원번호와 작성자의 회원번호 일치 여부 체크
						if($('#user_num').val() == item.mem_num){//로그인한 회원번호와 작성자 회원번호 일치
							output += ' <input type="button" data-renum="'+item.re_num+'" data-memnum="'+item.mem_num+'" value="수정" class="modify-btn">';
							output += ' <input type="button" data-renum="'+item.re_num+'" data-memnum="'+item.mem_num+'" value="삭제" class="delete-btn">';
						}
						output += '<hr size="1" noshade width="100%">';
						output += '</div>';
						output += '</div>';
						
						//문서 객체에 추가
						$('#output').append(output);
					});
					
					//page button 처리
					if(currentPage>=Math.ceil(count/rowCount)){
						//다음 페이지가 없음
						$('.paging-button').hide();
					}else{
						//다음 페이지가 존재
						$('.paging-button').show();
					}
				},
				error:function(){
					alert('네트워크 오류 발생');
				}
			});
			
		}
		//페이지 처리 이벤트 연결(다음 댓글 보기 버튼 클릭시 데이터 추가)
		$('.paging-button input').click(function(){
			selectData(currentPage + 1);
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
				url:'writeReply.do',
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
		//textarea에 내용 입력시 글자수 체크
		$(document).on('keyup','textarea',function(){
			//입력한 글자 구함
			var inputLength = $(this).val().length;
			
			if(inputLength > 300){//300자를 넘어선 경우
				$(this).val($(this).val().substring(0,300));
			}else{//300자 이하인 경우
				var remain = 300 - inputLength;
				remain += '/300';
				if($(this).attr('id') == 're_content'){
					//등록폼 글자수
					$('#re_first .letter-count').text(remain);
				}else{
					//수정폼 글자수
					$('#mre_first .letter-count').text(remain);
				}
			}
		});
		//댓글 수정 버튼 클릭시 수정폼 노출
		
		//수정폼에서 취소 버튼 클릭시 수정폼 초기화
		
		//댓글 수정 폼 초기화
		
		//댓글 수정
		//댓글 삭제
		$(document).on('click','.delete-btn',function(){
			//댓글 번호
			var re_num = $(this).attr('data-renum');
			//작성자 회원 번호
			var num = $(this).attr('data-memnum');
			
			$.ajax({
				type:'post',
				url:'deleteReply.do',
				data:{re_num:re_num,mem_num:mem_num},
				dataType:'json',
				cache:false,
				timeout:30000,
				success:function(param){
					if(param.result == 'logout'){
						alert('로그인 해야 삭제할 수 있습니다.');
					}else if(param.result == 'success'){
						alert('삭제 완료');
						selectData(1);
					}else if(param.result == 'wrongAccess'){
						alert('타인의 글을 삭제할 수 없습니다');
					}
				},
				error:function(){
					alert('오류 발생');
				}
			});
			
		});
		
		//초기 데이터(목록) 호출
		selectData(1);
	});
</script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<h2>게시판 글상세</h2>
	<ul>
		<li>글번호 : ${com.com_num}</li>
		<li>글제목 : ${com.com_title}</li>
		<li>조회수 : ${com.com_hit}</li>
	</ul>
	<hr size="1" noshade width="100%">
	<p>
		${board.content}
	</p>
	<hr size="1" noshade width="100%">
	<div class="align-right">
		작성일 : ${com.com_date}
		<%-- 로그인한 회원번호와 작성자 회원번호가 일치해야 수정,삭제 가능 --%>
		<c:if test="${user_num == com.com_member_num}">
		<input type="button" value="수정" onclick="location.href='updateForm.do?board_num=${com.com_num}'">
		<input type="button" value="삭제" id="delete_btn">	
		<script type="text/javascript">
			var delete_btn = document.getElementById('delete_btn');
			//이벤트 연결
			delete_btn.onclick=function(){
				var choice = confirm('삭제하시겠습니까?');
				if(choice){
					location.replace('delete.do?board_num=${board.board_num}');
				}
			};
		</script>
		</c:if>
		<input type="button" value="목록" onclick="location.href='list.do'">
	</div>
	<!-- 댓글 시작 -->
	<div id="reply_div">
		<span class="re-title">댓글 달기</span>
		<form id="re_form">
			<input type="hidden" name="com_num" value="${com.com_num}" id="board_num">
			<input type="hidden" name="com_member_num" value="${user_num}" id="user_num">
			<textarea rows="3" cols="50" name="com_content" id="com_content" class="rep-content"
			   <c:if test="${empty user_num}">disabled="disabled"</c:if>
			><c:if test="${empty user_num}">로그인해야 작성할 수 있습니다.</c:if></textarea>
			<c:if test="${!empty user_num}">
			<div id="re_first">
				<span class="letter-count">300/300</span>
			</div>	
			<div id="re_second" class="align-right">
				<input type="submit" value="전송">
			</div>
			</c:if>
		</form>
	</div>
	<!-- 댓글 목록 출력 시작 -->
	<div id="output"></div>
	<div class="paging-button" style="display:none;">
		<input type="button" value="다음글 보기">
	</div>
	<div id="loading" style="display:none;">
		<img src="${pageContext.request.contextPath}/images/ajax-loader.gif">
	</div>
	<!-- 댓글 목록 출력 끝 -->
	<!-- 댓글 끝 -->
</div>
</body>
</html>














