<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${contextPath }/assets/css/main.css" />
<style type="text/css">
.info-list-1 {
	width: 80%;
}
.info-list-2 {
	width: 80%;
}
</style>
<meta charset="UTF-8">
<title>내가 쓴 글</title>
</head>
<body>
<c:import url="../default/header.jsp" />
	<div class="wrap" align="center"
		style="padding-left: 50px; padding-right: 50px;">
	<div class="info-list-1">
		<table border="1">
		<caption><strong style="font-size: 20px;">리뷰 게시판에서 작성한 글들을 모아봤어요.</strong></caption>
			<tr>
				<td><b>아이디</b></td> <td><b>제목</b></td>
			</tr>
			<c:forEach var="review" items="${reviewData}">
			<tr>
				<td>${review.id}</td> 
				<td>
					<a href="${contextPath}/review/review_content?review_no=${review.review_no }">${review.review_title }</a>
				</td>
			</tr>
			</c:forEach>
		</table>
	</div>
	<br>
	<div class="info-list-2">
	<table border="1">
		<caption><strong style="font-size: 20px;">QnA 게시판에서 작성한 글들을 모아봤어요.</strong></caption>
		<tr>
			<td><b>아이디</b></td> <td><b>제목</b></td>
		</tr>
		<c:forEach var="qna" items="${qnaData}">
		<tr>
			<td>${qna.id}</td> 
				<td>
					<a href="${contextPath}/qna/contentView?qnaNo=${qna.qnaNo}">${qna.qnaTitle }</a>
				</td>
			</tr>
		</c:forEach>
	</table>	
	</div>
	</div>
<c:import url="../default/footer.jsp" />
</body>
</html>