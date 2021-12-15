<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript">
setTimeout(function(){
	opener.document.getElementById('Id').value=$('#Id').val();
	opener.location.reload(); //부모창 리프레쉬
	self.close(); //현재창 닫기
},100000); //1000당 1초
</script>
<style type="text/css">
text{
font-family: 'Gothic A1', sans-serif;
}
</style>
</head>
<body>
	<div align="center">
		<c:choose>
			<c:when test="${adminId != null}">
				관리자님 환영합니다!
			</c:when>
			<c:when test="${userId != null }">
				${userId } 님 환영합니다!
			</c:when>
		</c:choose>
	
		<c:if test="${userId == null && adminId == null}">
		<form action="${contextPath }/member/loginChk" method="post"> 
			<input type="text" name="id" placeholder="로그인할 아이디 입력"> <br>
			<input type="password" name="pw" placeholder="로그인할 비밀번호 입력"> <br>
			<a href="${contextPath }/member/registerForm" onclick="window.open('http://localhost:8085/root/member/registerForm','회원가입','width=#,height=#'); return false">회원가입</a>
			<input type="submit" value="로그인" id="setTimeout">
		</form>
		</c:if>
	</div>


</body>
</html>