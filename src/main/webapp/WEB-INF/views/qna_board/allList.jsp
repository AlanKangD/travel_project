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
  .pageNonClick{
    color: #BDBDBD;
    padding-left: 10px;padding-right: 10px;padding-top: 5px;padding-bottom: 5px;
  }
  .pageClick{
    color: #BDBDBD;
    background-color:#003399;
    padding-left: 10px;padding-right: 10px;padding-top: 5px;padding-bottom: 5px;
  }
  .pageBut button{
  	 border: 0;
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
	    <button type="button" class="btn btn-secondary" onclick="selectFunc()">검색</button>
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
				&lt;공지&gt; 
			</th>
			<td>						
				<a href="${contextPath}/qna/contentView?qnaNo=${dto.qnaNo}">
				${dto.qnaTitle}
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
		
			<div align="center" class="pageBut">
			<c:choose>
				<c:when test="${num != 1 }">
					<button type="button" onclick=
					"location.href='${contextPath}/qna/allList?num=1&searchOption=${searchOption}&keyword=${keyword}'">
					&laquo; </button>
				</c:when>
				<c:otherwise>
					<button type="button" disabled>≪</button>
				</c:otherwise>
			</c:choose>
			
			<c:choose>
				<c:when test="${num > 1 }">
					<button type="button" onclick=
					"location.href='${contextPath}/qna/allList?num=${num - 1}&searchOption=${searchOption}&keyword=${keyword}'">
					 &lt;</button>
				</c:when>
				<c:otherwise>
					<button type="button" disabled>&lt;</button>
				</c:otherwise>
			</c:choose>
			
				<c:forEach var="cnt" begin="${beginpage}" end="${endPage}">
					<c:choose>
					<c:when test="${num == cnt }">
						<a class="pageClick" href="${contextPath}/qna/allList?num=${cnt}&searchOption=${searchOption}&keyword=${keyword}">${cnt}</a>
					</c:when>
					<c:otherwise>
						<a class="pageNonClick" href="${contextPath}/qna/allList?num=${cnt}&searchOption=${searchOption}&keyword=${keyword}">${cnt}</a>
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
					 &raquo; </button>
				</c:when>
				<c:otherwise>
					<button type="button" disabled>≫</button>
				</c:otherwise>
			</c:choose>
			</div>
			<div align="right">	
			<button type="button" class="btn btn-dark" onclick="location.href='${contextPath}/qna/writeForm'">문의하기</button>
			</div>
		</div>
	</div>
<c:import url="../default/footer.jsp" />

</body>
</html>