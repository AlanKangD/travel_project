<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
	function selectFunc() {
		var keyword = document.getElementById('keyword').value;
		console.log(keyword);
		console.log(keyword.length);
		
		if(keyword.length < 2){
			alert('검색시 2글자 이상 입력해주세요');
		}else{
			selectFo.submit();
		}
		
	}
</script>
</head>
<body>

<c:import url="../default/header.jsp" />
<div class="wrap">
<div align="center">

<h1>QnA</h1>
궁금한 부분이 있으면 해결해드립니다.<p>

	<c:choose>
		<c:when test="${param.num == null }">
			<c:set var="num" value="1"/>
		</c:when>
		<c:otherwise>
			<c:set var="num" value="${param.num }"/>
		</c:otherwise>
	</c:choose>

총 ${dataCount}개의 글  ( 페이지 ${num } / ${repeat} )
<form id="selectFo" method="get" action="${contextPath}/qna/allList">
    <select name="searchOption">
	    	<option value="all"<c:if test='${searchOption == "all"}'>selected</c:if> >전체</option>
	        <option value="tc"<c:if test='${searchOption == "tc"}'>selected</c:if> >제목+내용</option>
	        <option value="title"<c:if test='${searchOption == "title"}'>selected</c:if> >제목</option>
	        <option value="content"<c:if test='${searchOption == "content"}'>selected</c:if> >내용</option>
	        <option value="id"<c:if test='${searchOption == "id"}'>selected</c:if> >작성자</option>
    </select>
    <input name="keyword" id="keyword" value="${keyword }">
    <input type="button" onclick="selectFunc()" value="검색">
</form>
<table border="1">
		<tr>
			<th>No.</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
			<th>답변여부</th>
		</tr>
		
		<c:forEach var="dto" items="${noticeList}">
					<tr>
						<td>
							&lt;공지&gt; 
						</td>
						<td>						
							<a href="${contextPath}/qna/contentView?qnaNo=${dto.qnaNo}">
							${dto.qnaTitle}
							</a> 
							<c:if test="${dto.saveDate >= nowday}">	
								<img src="${contextPath }/resources/img/new.png" 
																width="15px" height="15px">								
							</c:if>
						</td>
						<td>관리자</td>
						<td>	
							${dto.viewDate}
						</td>
						<td>${dto.qnaHit}</td>
						<td>
							답변완료
						</td>
					</tr>
				</c:forEach>		
		
		<c:choose>
			<c:when test="${qnaList.size() == 0}">
				<tr>
					<th colspan="6">등록된 글이 없습니다.</th>
				</tr>
			</c:when>
			<c:otherwise>
				<c:set var="boardNum" value="${dataCount - ((num-1) * 4) }"/>
				<c:forEach var="dto" items="${qnaList}">
					<tr>
						<td>
							${boardNum}
						</td>
						<td>						
								<a href="${contextPath}/qna/contentView?qnaNo=${dto.qnaNo}">
								${dto.qnaTitle}
								</a> 
							<c:if test="${dto.qnaPwd != null}">
								<img src="${contextPath }/resources/img/lock.svg" 
																width="12px" height="12px">
							</c:if>	
							<c:if test="${dto.saveDate >= nowday}">	
								<img src="${contextPath }/resources/img/new.png" 
																width="15px" height="15px">								
							</c:if>
						</td>
						<td>${dto.id}</td>
						<td>
							${dto.viewDate}
						</td>
						<td>${dto.qnaHit}</td>
						<td>
							${dto.repCheck}
						</td>
					</tr>
					<c:set var="boardNum" value="${boardNum-1 }"></c:set>
				</c:forEach>
			</c:otherwise>
		</c:choose>
		
		<tr>
			<td colspan="6">
				<div align="left">
				
				<c:choose>
					<c:when test="${num != 1 }">
						<button type="button" onclick=
						"location.href='${contextPath}/qna/allList?num=1&searchOption=${searchOption}&keyword=${keyword}'">
						 &lt;&lt; </button>
					</c:when>
					<c:otherwise>
						<button type="button" disabled>&lt;&lt;</button>
					</c:otherwise>
				</c:choose>
				
				<c:choose>
					<c:when test="${num > 1 }">
						<button type="button" onclick=
						"location.href='${contextPath}/qna/allList?num=${num - 1}&searchOption=${searchOption}&keyword=${keyword}'">
						 &lt; </button>
					</c:when>
					<c:otherwise>
						<button type="button" disabled>&lt;</button>
					</c:otherwise>
				</c:choose>
				
					<c:forEach var="cnt" begin="${beginpage}" end="${endPage}">
						<c:choose>
						<c:when test="${num == cnt }">
							<a href="${contextPath}/qna/allList?num=${cnt}&searchOption=${searchOption}&keyword=${keyword}"><b>[${cnt}]</b></a>
						</c:when>
						<c:otherwise>
							<a href="${contextPath}/qna/allList?num=${cnt}&searchOption=${searchOption}&keyword=${keyword}">[${cnt}]</a>
						</c:otherwise>
						</c:choose>
					</c:forEach>
				
				<c:choose>
					<c:when test="${num < repeat}">
						<button type="button" onclick=
						"location.href='${contextPath}/qna/allList?num=${num + 1}&searchOption=${searchOption}&keyword=${keyword}'">
						 &gt; </button>
					</c:when>
					<c:otherwise>
						<button type="button" disabled>&gt;</button>
					</c:otherwise>
				</c:choose>
				
				<c:choose>
					<c:when test="${num != repeat}">
						<button type="button" onclick=
						"location.href='${contextPath}/qna/allList?num=${repeat}&searchOption=${searchOption}&keyword=${keyword}'">
						 &gt;&gt; </button>
					</c:when>
					<c:otherwise>
						<button type="button" disabled>&gt;&gt;</button>
					</c:otherwise>
				</c:choose>

				
				</div>	
				<button onclick="location.href='${contextPath}/qna/writeForm'">글작성</button>
			</td>
		</tr>
</table>
</div>
</div>
<c:import url="../default/footer.jsp" />

</body>
</html>