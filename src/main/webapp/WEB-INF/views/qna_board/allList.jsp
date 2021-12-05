<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<c:import url="../default/header.jsp" />

<h1>QnA</h1>
궁금한 부분이 있으면 해결해드립니다.<p>

<table border="1" style="width: 500px;">
		<tr>
			<th>답변여부</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>
				
		<c:choose>
			<c:when test="${qnaList.size() == 0}">
				<tr>
					<th colspan="4">등록된 글이 없습니다.</th>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach var="dto" items="${qnaList}">
					<tr>
						<td>
							${dto.repCheck}
						</td>
						<td>						
							<a href="${contextPath}/qna/contentView?qnaNo=${dto.qnaNo}">
							${dto.qnaTitle}
							</a> 
						<c:if test="${dto.qnaPwd != null}">
							<img src="${contextPath }/resources/img/lock.svg" 
															width="12px" height="12px">
						</c:if>	
						<c:if test="${dto.saveDate == nowday}">	
							<img src="${contextPath }/resources/img/new.png" 
															width="15px" height="15px">								
						</c:if>
						</td>
						<td>${dto.id}</td>
						<td>${dto.saveDate}</td>
						<td>${dto.qnaHit}</td>
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
		
		<tr>
			<td colspan="5">
				<div align="left">
				
				<c:choose>
					<c:when test="${param.num == null }">
						<c:set var="num" value="1"/>
					</c:when>
					<c:otherwise>
						<c:set var="num" value="${param.num }"/>
					</c:otherwise>
				</c:choose>
				
				<c:choose>
					<c:when test="${num > 1 }">
						<button type="button" onclick=
						"location.href='${contextPath}/qna/allList?num=${num - 1}'">
						 &lt; </button>
					</c:when>
					<c:otherwise>
						<button type="button" disabled>&lt;</button>
					</c:otherwise>
				</c:choose>
				
					<c:forEach var="cnt" begin="1" end="${repeat}">
						<c:choose>
						<c:when test="${num == cnt }">
							<a href="${contextPath}/qna/allList?num=${cnt}"><b>[${cnt}]</b></a>
						</c:when>
						<c:otherwise>
							<a href="${contextPath}/qna/allList?num=${cnt}">[${cnt}]</a>
						</c:otherwise>
						</c:choose>
					</c:forEach>
				
				<c:choose>
					<c:when test="${num < repeat}">
						<button type="button" onclick=
						"location.href='${contextPath}/qna/allList?num=${num + 1}'">
						 &gt; </button>
					</c:when>
					<c:otherwise>
						<button type="button" disabled>&gt;</button>
					</c:otherwise>
				</c:choose>
				
				</div>	
				<button onclick="location.href='${contextPath}/qna/writeForm'">글작성</button>
			</td>
		</tr>
	
</table>

<c:import url="../default/footer.jsp" />

</body>
</html>