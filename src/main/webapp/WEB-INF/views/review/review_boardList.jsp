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
<body>
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
			</tr>
			<c:forEach var="list" items="${ boardList }">
				<tr>
					<td>${ list.review_no }</td>
					<td><a href="${contextPath}/review/review_content?review_no=${list.review_no}">${ list.review_title }
					<c:if test="${list.r_reply_count != 0}">
						<small><b>[&nbsp;<c:out value="${list.r_reply_count}"/>&nbsp;]</b></small>
					</c:if>
					</a></td>
					<td>${ list.id }</td>
					<td>${ list.review_date }</td>
					<td>${ list.review_hit_num }</td>
					<td>${ list.review_like }</td>
				</tr>
			</c:forEach>
		</table>	
		<hr>
		<table border="1">
		<tr>
			<td colspan="7">
			<div align="center">
				<c:forEach var="num" begin="1" end="${ repeat }">
					<a href="review_content?num=${num}">[${num}]</a>
				</c:forEach>
			</div>
			</td>
		</tr>
		</table>
		<input type="button" value="리뷰 작성" onclick="location.href='${contextPath}/review/review_write'">	
	</div>
	
	<c:import url="../default/footer.jsp" />
</body>
</html>