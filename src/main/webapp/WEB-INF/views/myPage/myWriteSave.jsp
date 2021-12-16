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
<body> <h1>나의 글 쓴 목록을 보여주는 페이지 입니다.</h1>
<div align="center">
	<table border="1">
		<caption>review 글 쓴 목록 확인</caption>
		<tr>
			<td>id</td> <td>title</td>
		</tr>
	<c:forEach var="review" items="${reviewData }">
		<tr>
			<th>${review.id }</th> <th>${review.review_title }</th>
		</tr>
	</c:forEach>
	</table>
	<table border="1">
		<caption>qna 글 쓴 목록 확인</caption>
		<tr>
			<td>id</td> <td>title</td>
		</tr>
	<c:forEach var="qna" items="${qnaData}">
		<tr>
			<th>${qna.id }</th> 
			<th>
				<a href="${contextPath}/qna/contentView?qnaNo=${qna.qnaNo}">${qna.qnaTitle }</a>
			</th>
		</tr>
	</c:forEach>
	</table>
</div>
	
</body>
</html>