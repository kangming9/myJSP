<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${check}">
	<script>
		alert('입양 신청이 완료되었습니다.');
		location.href='petList.do';
	</script>
</c:if>
<c:if test = "${count < 60 && user_grade != 2}">
	<script>
		alert('봉사활동 60시간 이상인 경우에만 입양이 가능합니다.');
		history.go(-1);
	</script>
</c:if>
<c:if test="${checkCount > 0 }">
	<script>
		alert('이미 입양 신청이 완료되었습니다.');
		history.go(-1);
	</script>

</c:if>