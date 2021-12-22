<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript">
function parentRefresh(){
	fo.submit()
}
function registerForm(url,name){
	var popHeight=1000;
	var popWidth=1000;
	var winHeight=document.body.clientHeight;
	var winWidth=document.body.clientWidth;
	var winX=window.screenLeft;
	var winY=window.screenTop;
	
	var popX=winX+(winWidth-popWidth)/40;
	var popY=winY+(winHeight-popHeight)/40;
	window.resizeTo(1750,950)
	window.open(url, "pop",  "top="+popY+", left="+popX+",width="+popWidth+",height="+popHeight+", scrollbars=yes,resizable=yes");
}
</script>
<style type="text/css">
text{
font-family: 'Gothic A1', sans-serif;
}
</style>
</head>
<body>
${ss}    <!-- 로그인 성공시 팝업창 닫힘 -->
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
		<form id='fo' action="${contextPath }/member/loginChk" method="post"> 
			<input type="text" name="id" placeholder="로그인할 아이디 입력"> <br>
			<input type="password" name="pw" placeholder="로그인할 비밀번호 입력"> <br>
			<a href="javascript:registerForm('${contextPath }/member/registerForm','registerForm');">회원가입</a>
			<input type="button" value="로그인"  onclick="parentRefresh()">
		</form>
		</c:if>
	</div>


</body>
</html>