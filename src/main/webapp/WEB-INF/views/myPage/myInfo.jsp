<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${contextPath }/assets/css/main.css" />
<style type="text/css">
</style>
<meta charset="UTF-8">
<title>내 정보</title>
</head>
<body>
<c:import url="../default/header.jsp" />
	<div class="wrap" align="center"
		style="padding-left: 50px; padding-right: 50px;">
		<div align="center">
			<table border="1">
				<tr>
					<td><b>아이디</b></td> <td><b>비밀번호</b></td> <td><b>이메일</b></td> <td><b>주소</b></td>
				</tr>
				<tr>
					<td>${myInfo.id}</td> <td>${myInfo.pw}</td> <td>${myInfo.email}</td> <td>${myInfo.addr1 },${myInfo.addr2 },${myInfo.addr3 }</td>		 	
				</tr>
			</table>
			<strong style="font-size: 20px;"><a href="${contextPath }/myPage/ModifyForm?id=${myInfo.id }">수정하기</a></strong> &emsp;
			<strong style="font-size: 20px;"><a href="${contextPath }/myPage/Delete?id=${myInfo.id }">삭제하기</a></strong>
		</div>
		<hr>
	</div>
	<c:import url="../default/footer.jsp" />
</body>
</html>