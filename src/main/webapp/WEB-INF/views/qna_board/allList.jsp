<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>    
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js" integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js" integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous"></script>
<link rel="stylesheet" href="${contextPath }/assets/css/main.css" />
<style type="text/css">
#main {width: 80%; margin-left: 5%; margin-right: 5%;}

 .search_area{
    display: inline-block;
    margin-top: 30px;
    margin-left: 250px;
  }
  .search_area select{
   	 height: 30px;
     width: 110px;
  }
  .search_area input{
     height: 30px;
     width: 250px;
  }
  a { text-decoration: none; }
  
  .answerComplete{
  	background-color: #FAF4C0;
  }
  .answerYet{
  	background-color: #86E57F;
  }
  .searchDiv{
  	margin-top: 50px;
  	margin-left: 40px;
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
	function loginpopup(url,name){
	      var popHeight=290;
	      var popWidth=230;
	      var winHeight=document.body.clientHeight;
	      var winWidth=document.body.clientWidth;
	      var winX=window.screenLeft;
	      var winY=window.screenTop;
	      
	      var popX=winX+(winWidth-popWidth)/2;
	      var popY=winY+(winHeight-popHeight)/4;
	      window.open(url, "pop",  "top="+popY+", left="+popX+",width="+popWidth+",height="+popHeight+", scrollbars=yes,resizable=yes");
	   }
</script>
</head>
<body>

<c:import url="../default/header.jsp" />
<div id="main">
<div class="board_head" style="display: flex;">
	
	<c:choose>
		<c:when test="${param.num == null }">
			<c:set var="num" value="1"/>
		</c:when>
		<c:otherwise>
			<c:set var="num" value="${param.num }"/>
		</c:otherwise>
	</c:choose>

	<div>
		<h1>QnA게시판</h1>
		궁금한 부분이 있으면 해결해드립니다.<p>
		총 ${dataCount}개의 글  ( Page ${num } / ${repeat} )
	</div>
	
	<div class="searchDiv">
	<form id="selectFo" method="get" action="${contextPath}/qna/allList" class="search_area">
	    <select name="searchOption">
		    	<option value="all"<c:if test='${searchOption == "all"}'>selected</c:if> >전체</option>
		        <option value="tc"<c:if test='${searchOption == "tc"}'>selected</c:if> >제목+내용</option>
		        <option value="title"<c:if test='${searchOption == "title"}'>selected</c:if> >제목</option>
		        <option value="content"<c:if test='${searchOption == "content"}'>selected</c:if> >내용</option>
		        <option value="id"<c:if test='${searchOption == "id"}'>selected</c:if> >작성자</option>
	    </select>
	    <input name="keyword" id="keyword" value="${keyword }">
	    <button type="button" onclick="selectFunc()">검색</button>
	</form>
	</div>
	
</div>

<div align="center">

<table class="table">
  <thead>
    <tr>
      <th scope="col">No.</th>
      <th scope="col">제목</th>
      <th scope="col">작성자</th>
      <th scope="col">작성일</th>
      <th scope="col">조회수</th>
      <th scope="col">상태</th>
    </tr>
  </thead>
  <tbody>
  
 	 <c:forEach var="dto" items="${noticeList}">
		<tr style="background-color: #BDBDBD;">
			<th scope="row">
				&lt; 공지 &gt; 
			</th>
			<td>						
				<a href="${contextPath}/qna/contentView?qnaNo=${dto.qnaNo}">
				<b>${dto.qnaTitle}</b>
				</a> 
				<c:if test="${dto.saveDate >= nowday}">	
					<span class="badge bg-secondary">New</span>								
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
				<c:set var="boardNum" value="${dataCount - ((num-1) * 8) }"/>
				<c:forEach var="dto" items="${qnaList}">
					<tr>
						<th scope="row">
							${boardNum}
						</th>
						<td>						
								<a href="${contextPath}/qna/contentView?qnaNo=${dto.qnaNo}&num=${num}&searchOption=${searchOption}&keyword=${keyword}">
								${dto.qnaTitle}
								</a> 
							<c:if test="${dto.qnaPwd != null}">
								<img src="${contextPath }/resources/img/lock.svg" 
																width="12px" height="12px">
							</c:if>	
							<c:if test="${dto.saveDate >= nowday}">	
								<span class="badge bg-secondary">New</span>															
							</c:if>
						</td>
						<td>${dto.id}</td>
						<td>
							${dto.viewDate}
						</td>
						<td>${dto.qnaHit}</td>
						<td>
							<c:if test="${dto.repCheck == '답변완료'}">
								<span class="answerComplete ">답변완료</span>
							</c:if>
							<c:if test="${dto.repCheck == '답변예정'}">
								<span class="answerYet">답변예정</span>
							</c:if>
						</td>
					</tr>
					<c:set var="boardNum" value="${boardNum-1 }"></c:set>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</tbody>	
</table>
		
	<div class="page_wrap">
		 <div class="page_nation">
			<c:choose>
				<c:when test="${num != 1 }">
					<a class="arrow pprev" href="${contextPath}/qna/allList?num=1&searchOption=${searchOption}&keyword=${keyword}"></a>
				</c:when>
				<c:otherwise>
					<a class="arrow pprev"></a>
				</c:otherwise>
			</c:choose>
			
			<c:choose>
				<c:when test="${num > 1 }">
					<a class="arrow prev" href="${contextPath}/qna/allList?num=${num - 1}&searchOption=${searchOption}&keyword=${keyword}"></a>
				</c:when>
				<c:otherwise>
					<a class="arrow prev"></a>
				</c:otherwise>
			</c:choose>
			
				<c:forEach var="cnt" begin="${beginPage}" end="${endPage}">
					<c:choose>
					<c:when test="${num == cnt }">
						<a class="active" href="${contextPath}/qna/allList?num=${cnt}&searchOption=${searchOption}&keyword=${keyword}">${cnt}</a>
					</c:when>
					<c:otherwise>
						<a href="${contextPath}/qna/allList?num=${cnt}&searchOption=${searchOption}&keyword=${keyword}">${cnt}</a>
					</c:otherwise>
					</c:choose>
				</c:forEach>
			
			<c:choose>
				<c:when test="${num < repeat}">
					<a class="arrow next" href="${contextPath}/qna/allList?num=${num + 1}&searchOption=${searchOption}&keyword=${keyword}"></a>
				</c:when>
				<c:otherwise>
					<a class="arrow next"></a>
				</c:otherwise>
			</c:choose>
			
			<c:choose>
				<c:when test="${num != repeat}">
					 <a class="arrow nnext" href="${contextPath}/qna/allList?num=${repeat}&searchOption=${searchOption}&keyword=${keyword}"></a>
				</c:when>
				<c:otherwise>
					 <a class="arrow nnext"></a>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
			<div align="right">	
			<button type="button" onclick="location.href='${contextPath}/qna/writeForm'">문의하기</button>
			</div>
		</div>
	</div>
<c:import url="../default/footer.jsp" />

</body>
</html>