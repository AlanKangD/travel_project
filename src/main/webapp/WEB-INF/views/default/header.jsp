<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
function loginpopup(url,name){
	var popHeight=290;
	var popWidth=230;
	var winHeight=document.body.clientHeight;
	var winWidth=document.body.clientWidth;
	var winX=window.screenLeft;
	var winY=window.screenTop;
	
	var popX=winX+(winWidth-popWidth)/2;
	var popY=winY+(winHeight-popHeight)/2;
	
	window.open(url, "pop",  "top="+popY+", left="+popX+",width="+popWidth+",height="+popHeight+", scrollbars=yes,resizable=yes");
}
</script>
<style type="text/css">
* { margin: 0; }
.wrap { width: 1000px; margin: auto; }
.header { width: 1000px; background-color: white; }
.navdiv{width:100%; background-color: olive; }
nav{ background-color: olive;width: 1000px; }
nav ul { list-style: none; display: flex; justify-content: flex-end; }
nav ul li { margin: 0 3px; padding: 10px 10px; }
nav ul li a { text-decoration: none; color: white; }
nav ul li a:hover {
    color: orange; padding-bottom: 3px; /* a태그 밑줄과 글씨 간격*/
    border-bottom: 1px solid orange; transition: all 0.25s;
}
.title {    /*오른, 아래, 번짐*/
    text-shadow: 10px 10px 15px black; font-size: 70pt;
    text-align: center; margin-top: 0px; padding-bottom: 20px;
    color:burlywood; font-family:Gabriola;
}
.content{ margin-top: 50px; }
</style> </head> <body>
<div class="wrap">
    <div class="header"> <h1 class="title">CARE LAB</h1> </div>
</div>
<div class="navdiv">
<div class="wrap">
<nav>
    <ul>
<li><a href="${contextPath }/index">HOME</a></li>
<li><a href="${contextPath }/member/memberInfo">회원 정보</a></li>
<c:choose>
	<c:when test="${userId == null && adminId == null }">
		<li><a href="javascript:loginpopup('${contextPath }/member/loginForm','loginpopup');">로그인</a></li>
	</c:when>
	<c:otherwise>
		<li><a href="${contextPath }/member/logout">로그아웃</a></li>
	</c:otherwise>
</c:choose>
<li><a href="${contextPath }/qna/allList">QnA게시판</a></li>
    </ul>
</nav>
</div>
</div>
</body> </html>
