<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">

.wrapp { width: 100%; height:100px; margin: auto; background-color: yellow;
text-align: center; padding-top:30px  }
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
					html += "<img style='width:150px; height:100px' src='${pageContext.request.contextPath}/main/download?mainImageFile="+mainImageFile+" '><br>"	
					html += " "+data.place
					html += "<button onclick='deleteList("+data.listNo+")' >삭제</button><br> "
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
    <div> <h1>제주</h1> </div> 
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
			<li><a href="${contextPath }/member/memberInfo">회원 정보</a></li>
			<c:choose>
				<c:when test="${userId == null && adminId == null }">
					<li><a href="${contextPath }/member/loginForm">로그인</a></li>
				</c:when>
				<c:otherwise>
				<li><a href="${contextPath }/member/logout">로그아웃</a></li>
				</c:otherwise>
			</c:choose>
			<li><a href="${contextPath }/qna/allList">QnA게시판</a></li>	
			
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
