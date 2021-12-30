<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
function loginpopup(url,name){
	var popHeight=400;
	var popWidth=350;
	var winHeight=document.body.clientHeight;
	var winWidth=document.body.clientWidth;
	var winX=window.screenLeft;
	var winY=window.screenTop;
	
	var popX=winX+(winWidth-popWidth)/2;
	var popY=winY+(winHeight-popHeight)/2;
	
	window.open(url, "pop",  "top="+popY+", left="+popX+",width="+popWidth+",height="+popHeight+", scrollbars=yes,resizable=yes");
}
</script>
<style type="text/css">
.wrapp { width: 100%; height:0px; margin: auto; background-color: #066289;
text-align: center; padding-top:0px  }
}
</style> 
<script>

	function myList(){
		$.ajax({
			url : "${pageContext.request.contextPath}/main/getMyList",
			type : "get",
			dataType : "json",
			success : function(list){
				console.log(list)
				let html = "";
				list.forEach(function(data){
					var mainImageFile = data.image
					html += "<img style='width:150px; height:100px' src='${pageContext.request.contextPath}/main/download?imageFile="+mainImageFile+" '><br>"	
					html += " "+data.place
					html += "<button style='background-color: white' onclick='deleteList("+data.listNo+")' >삭제</button><br> "
				})
				$("#replyList").html(html)
			}, error : function(){
			}
		})
	}
	
	function deleteList(listNo){
		console.log(listNo)
		$.ajax({
			url : "${pageContext.request.contextPath}/main/deleteList?listNo="+listNo,
			type : "delete",
			dataType : "json",
			success : function(data){
				if(data.result == true){
					myList();
				}else{
					alert('삭제 실패!');
				}
			},error : function(){
				alert("에러로 들어감")
			}
		})
	}
	

</script>
</head> 
<body >
	<div class="wrapp">
    <div><img src="${contextPath}/resources/img/traduler-logo.png" width="20%" style="margin-top: 30px;"></div> 
	<header id="header">
		<nav>
			<ul>
				<li onclick="myList()"><a href="#menu">Menu</a></li>
			</ul>
		</nav>
	</header>	
	<nav id="menu">
	<h3>유저아이디 : ${userId }</h3>
		<h2>Menu</h2>
		<ul>
			<li><a href="${contextPath }/index">HOME</a></li>
			<c:if test="${adminId != null }">
				<li><a href="${contextPath }/member/memberInfo">회원 정보</a></li>
			</c:if>
			<c:choose>
				<c:when test="${userId == null && adminId == null }">
					<li><a href="javascript:loginpopup('${contextPath }/member/loginForm','loginpopup');">로그인</a></li>
				</c:when>
				<c:otherwise>
				<li><a href="${contextPath }/member/logout">로그아웃</a></li>
				</c:otherwise>
			</c:choose>
			<li><a href="${contextPath }/review/review_boardList">리뷰 게시판</a></li>	
			<li><a href="${contextPath }/qna/allList">QnA 게시판</a></li>	
			<li><a href="${contextPath }/myPage/myPageList">MY PAGE</a></li>	
			<c:choose>
			<c:when test="${userId == null && adminId == null }">
				<li><br>
					<h2>로그인을 한 후 나만의 리스트를 만들어보세요!</h2>
				</li>	
			</c:when>
			<c:otherwise>
				<li><br>
					<h2>[나의 여행 리스트 후보]</h2>
					<div  id="replyList"></div>			
				</li>	
			</c:otherwise>
			</c:choose>
		</ul>
	</nav>	
	
</div>	
	
	<script src="${contextPath }/assets/js/jquery.min.js"></script>
	<script src="${contextPath }/assets/js/skel.min.js"></script>
	<script src="${contextPath }/assets/js/util.js"></script>
	<script src="${contextPath }/assets/js/main.js"></script>

</body> 
</html>
