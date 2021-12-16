<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body> <h1>마이페이지 입니다 나의 정보를 확인하세요</h1>
	
	<a href="${contextPath }/myPage/myInfo?id=${userId}">나의 정보 확인</a>
	<a href="${contextPath }/myPage/myWriteSave?id=${userId}">글쓴 목록 확인</a>

</body>
</html>