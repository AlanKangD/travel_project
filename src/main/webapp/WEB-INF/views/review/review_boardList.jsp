<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${contextPath }/assets/css/main.css" />
<style type="text/css">
.review_list_title {
	padding-left: 50px;
	width: 800px;
	height: 120px;
	margin: 0px;
	padding: 0px;
}
.review_title {
	padding-left: 50px;
	width: 100%;
	height: 75px;
	float: left;
}
.review_title_sub {
	padding-left: 50px;
	width: 100%;
	height: 45px;
	float: left;
}
.review_write_button_div {
	float: left;
	margin-top: 10px;
	margin-bottom: 10px;
}
.review_write_button {
	filter: drop-shadow(4px 4px 4px #666);
	position: fixed;
	left: 100px;
	top: 550px;
	border-radius: 50%;
	width: 100px;
	height: 100px;
}

</style>
<meta charset="utf-8">
<title>후기 게시판</title>
</head>
<body>
	<c:import url="../default/header.jsp" />
	<br>
	<div class="review_list_title">
		<div class="review_title">
			<h1 style="text-align: left">후기 게시판</h1>
		</div>
		<div class="review_title_sub">
			<p style="text-align: left;">회원님이 떠났던 여행지는 어땠나요 ?<br>
				자세한 여행 후기를 다른 회원님들에게도 공유해주세요 !<br>			
			</p>
		</div>
	</div>
	
	<div class="wrap" align="center" style="
	padding-right: 50px; padding-left: 50px; padding-top: 0px;">
	<br>
		<div class="review_write_button_div">
			<img src="${contextPath}/resources/img/review_write.png" class="review_write_button" onclick="location.href='${contextPath}/review/review_write'">
<%-- 			<button class="review_write_button" onclick="location.href='${contextPath}/review/review_write'">작성</button>
 --%>		</div>
		<table border="1">
			<tr>
				<th style="padding-top: 15px;">번호</th>
				<th>좋아요</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>
			<c:forEach var="list" items="${ boardList }">
				<tr>
					<td>${ list.review_no }</td>
					
					<td>
						<c:choose>
							<c:when test="${ list.review_like == 0 }">
								<img src="${contextPath}/resources/img/like_off.png" height="25" width="25"> 0
							</c:when>
							<c:otherwise>
								<img src="${contextPath}/resources/img/like_on.png" height="25" width="25"> ${list.review_like}
							</c:otherwise>
						</c:choose>
					</td>
					
					<td><a href="${contextPath}/review/review_content?review_no=${list.review_no}">${ list.review_title }
					<c:if test="${list.r_reply_count != 0}">
						<small><b>[&nbsp;<c:out value="${list.r_reply_count}"/>&nbsp;]</b></small>
					</c:if>
					</a></td>
					<td>${ list.id }</td>
					<td>${ list.review_date }</td>
					<td>${ list.review_hit_num }</td>
				</tr>
			</c:forEach>
		</table>	
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
	</div>
	
	<c:import url="../default/footer.jsp" />
</body>
</html>