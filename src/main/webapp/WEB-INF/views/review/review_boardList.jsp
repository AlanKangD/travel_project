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
<<<<<<< HEAD
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
=======
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
>>>>>>> 6e5821183581dcad68c3d0fa477fca163e981a3a
	</div>
	<div id="search_div"><!-- 리뷰 검색 기능 -->
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