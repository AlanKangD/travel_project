<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <c:set var="contextPath" value="${pageContext.request.contextPath }"/>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
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
			r_select_form.submit();
		}
	}
</script>
</head>
<body>
   <c:import url="../default/header.jsp" />
   <div class="wrap" align="center">
   
   <c:choose>
      <c:when test="${param.num == null }">
         <c:set var="num" value="1"/>
      </c:when>
      <c:otherwise>
         <c:set var="num" value="${param.num }"/>
      </c:otherwise>
   </c:choose>

	<div>
	   <h1>여행 후기게시판</h1>
	   자신만의 여행후기를 기록해보세요!<p>
	   총 ${dataCount}개의 글  ( Page ${num } / ${repeat} )
	</div>
	<div id="search_div">
		<form id="r_select_form" method="get" action="${contextPath }/review/review_boardList">
			<select name="r_search_option">
				<option value="all"<c:if test='${r_search_option == "all" }'>selected</c:if> >전체</option>
				<option value="tc"<c:if test='${r_search_option == "tc" }'>selected</c:if> >제목+내용</option>
				<option value="title"<c:if test='${r_search_option == "title" }'>selected</c:if> >제목</option>
				<option value="content"<c:if test='${r_search_option == "content" }'>selected</c:if> >내용</option>
				<option value="id"<c:if test='${r_search_option == "id" }'>selected</c:if> >작성자</option>
			</select>
			<input name="keyword" id="keyword" value="${keyword }">
			<button type="button" onclick="selectFunc()">검색</button>
		</form>
	</div>
   
      <table border="1">
         <tr>
            <th>글번호</th>
            <th>글제목</th>
            <th>작성자</th>
            <th>작성시간</th>
            <th>조회수</th>
            <th>좋아요</th>
         </tr>
         <c:set var="boardNum" value="${dataCount - ((num-1) * 5) }"/>
         <c:forEach var="list" items="${ boardList }">
            <tr>
               <td>${ boardNum }</td>
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
            <c:set var="boardNum" value="${boardNum-1 }"/>
         </c:forEach>
      </table>   
      <hr>
         <div align="center">
         <c:choose>
            <c:when test="${num != 1 }">
               <button type="button" onclick=
               "location.href='${contextPath}/review/review_boardList?num=1'">
               &laquo; </button>
            </c:when>
            <c:otherwise>
               <button type="button" disabled>≪</button>
            </c:otherwise>
         </c:choose>
         
         <c:choose>
            <c:when test="${num > 1 }">
               <button type="button" onclick=
               "location.href='${contextPath}/review/review_boardList?num=${num - 1}'">
                &lt;</button>
            </c:when>
            <c:otherwise>
               <button type="button" disabled>&lt;</button>
            </c:otherwise>
         </c:choose>
         
         <c:forEach var="cnt" begin="${beginPage}" end="${ endPage }">
               <c:choose>
               <c:when test="${num == cnt }">
                  <a href="${contextPath}/review/review_boardList?num=${cnt}"><b>[${cnt}]</b></a>
               </c:when>
               <c:otherwise>
                  <a href="${contextPath}/review/review_boardList?num=${cnt}">[${cnt}]</a>
               </c:otherwise>
               </c:choose>
         </c:forEach>
         
         <c:choose>
            <c:when test="${num < repeat}">
               <button type="button" onclick=
               "location.href='${contextPath}/review/review_boardList?num=${num + 1}'">
                &gt; </button>
            </c:when>
            <c:otherwise>
               <button type="button" disabled>&gt;</button>
            </c:otherwise>
         </c:choose>
         
         <c:choose>
            <c:when test="${num != repeat}">
               <button type="button" onclick=
               "location.href='${contextPath}/review/review_boardList?num=${repeat}'">
                &raquo; </button>
            </c:when>
            <c:otherwise>
               <button type="button" disabled>≫</button>
            </c:otherwise>
         </c:choose>
         
         </div>
      <input type="button" value="리뷰 작성" onclick="location.href='${contextPath}/review/review_write'">   
   </div>
   
   <c:import url="../default/footer.jsp" />
</body>
</html>