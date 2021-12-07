<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <c:set var="contextPath" value="${pageContext.request.contextPath }"/>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<body>review_boardList.jsp입니다
	<c:import url="../default/header.jsp" />
	
	<div class="wrap" align="center">
		<table border="1">
			<tr>
				<th>글번호</th>
				<th>글제목</th>
				<th>작성자</th>
				<th>작성시간</th>
				<th>조회수</th>
				<th>좋아요</th>
				<th>댓글수</th>
			</tr>
			<c:forEach var="list" items="${ boardList }">
				<tr>
					<td>${ list.review_no }</td>
					<td><a href="${contextPath}/review/review_content?review_no=${list.review_no}">${ list.review_title }</a></td>
					<td>${ list.id }</td>
					<td>${ list.review_date }</td>
					<td>${ list.review_hit_num }</td>
					<td>${ list.review_like }</td>
					<td>미구현</td>
				</tr>
			</c:forEach>
		</table>	
		<hr>
		<input type="button" value="리뷰 작성" onclick="location.href='${contextPath}/review/review_write'">	
	</div>
	
	<c:import url="../default/footer.jsp" />
</body>
</html>