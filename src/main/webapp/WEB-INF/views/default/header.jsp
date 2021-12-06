<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
<li><a href="/index">HOME</a></li>
<li><a href="${contextPath }/member/memberInfo">회원 정보</a></li>
<li><a href="login">로그인</a></li>

    </ul>
</nav>
</div>
</div>
</body> </html>
