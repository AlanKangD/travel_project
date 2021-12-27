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
.page_wrap {
	text-align:center;
	font-size:0;
 }
.page_nation {
	display:inline-block;
}
.page_nation .none {
	display:none;
}
.page_nation a {
	display:block;
	margin:0 3px;
	float:left;
	border:1px solid #e6e6e6;
	width:28px;
	height:28px;
	line-height:28px;
	text-align:center;
	background-color:#fff;
	font-size:13px;
	color:#999999;
	text-decoration:none;
}
.page_nation .arrow {
	border:1px solid #ccc;
}
.page_nation .pprev {
	background:#f8f8f8 url('${contextPath}/resources/arrow/page_pprev.png') no-repeat center center;
	margin-left:0;
}
.page_nation .prev {
	background:#f8f8f8 url('${contextPath}/resources/arrow/page_prev.png') no-repeat center center;
	margin-right:7px;
}
.page_nation .next {
	background:#f8f8f8 url('${contextPath}/resources/arrow/page_next.png') no-repeat center center;
	margin-left:7px;
}
.page_nation .nnext {
	background:#f8f8f8 url('${contextPath}/resources/arrow/page_nnext.png') no-repeat center center;
	margin-right:0;
}
.page_nation a.active {
	background-color:#42454c;
	color:#fff;
	border:1px solid #42454c;
}
</style>
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
         <div class="page_wrap">
		 <div class="page_nation">
         <c:choose>
            <c:when test="${num != 1 }">
               <a class="arrow pprev" href="${contextPath}/review/review_boardList?num=1"></a>
            </c:when>
            <c:otherwise>
               <a class="arrow pprev"></a>
            </c:otherwise>
         </c:choose>
         
         <c:choose>
            <c:when test="${num > 1 }">
                <a class="arrow prev" href="${contextPath}/review/review_boardList?num=${num - 1}"></a>
            </c:when>
            <c:otherwise>
               <a class="arrow prev"></a>
            </c:otherwise>
         </c:choose>
         
         <c:forEach var="cnt" begin="${beginPage}" end="${ endPage }">
               <c:choose>
               <c:when test="${num == cnt }">
                  <a class="active" href="${contextPath}/review/review_boardList?num=${cnt}"><b>${cnt}</b></a>
               </c:when>
               <c:otherwise>
                  <a href="${contextPath}/review/review_boardList?num=${cnt}">${cnt}</a>
               </c:otherwise>
               </c:choose>
         </c:forEach>
         
         <c:choose>
            <c:when test="${num < repeat}">
                <a class="arrow next" href="${contextPath}/review/review_boardList?num=${num + 1}"></a>
            </c:when>
            <c:otherwise>
               <a class="arrow next"></a>
            </c:otherwise>
         </c:choose>
         
         <c:choose>
            <c:when test="${num != repeat}">
                <a class="arrow nnext" href="${contextPath}/review/review_boardList?num=${repeat}"></a>
            </c:when>
            <c:otherwise>
                <a class="arrow nnext"></a>
            </c:otherwise>
         </c:choose>
         </div>
         </div>
      <input type="button" value="리뷰 작성" onclick="location.href='${contextPath}/review/review_write'">   
   </div>
   
   <c:import url="../default/footer.jsp" />
</body>
</html>