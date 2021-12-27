<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${contextPath }/assets/css/main.css" />
<style type="text/css">
.mp-div {
	margin-top: auto;
	position: relative;
	text-align: left;
	width: 100%;
	height: 120px;
	float: left;
}
.mp-div-title {
}
.mp-div-sub {
	position: absolute;
	top: 57px;
	height: 43px;
}
</style>
<meta charset="UTF-8">
<title>마이 페이지</title>
</head>
<body>
<c:import url="../default/header.jsp" />
	<div class="wrap" align="center"
		style="padding-left: 50px; padding-right: 50px;">
		<div class="mp-div">
			<div class="mp-div-title">
				<h1>MY PAGE</h1>
			</div>
			<div class="mp-div-sub">
				<p>회원님의 일정과 개인 정보를 가지고 있어요.</p>
			</div>
		</div>
		<hr>
		<img src="${contextPath}/resources/img/cal.png" width="23px;" height="23px"> <a href="${contextPath }/myPage/calendar?id=${userId}">&nbsp;
			<strong style="font-size:22px;">나의 일정 확인</strong></a>
		<hr>
		<img src="${contextPath}/resources/img/info.png" width="23px;" height="23px"> <a href="${contextPath }/myPage/myInfo?id=${userId}">&nbsp;
			<strong style="font-size:22px;">나의 정보 확인</strong></a>
		<hr>
		<img src="${contextPath}/resources/img/pencil.png" width="23px;" height="23px"> <a href="${contextPath }/myPage/myWriteSave?id=${userId}">&nbsp;
			<strong style="font-size:22px;">글쓴 목록 확인</strong></a>
		<hr>
	</div>
<c:import url="../default/footer.jsp" />
</body>
</html>