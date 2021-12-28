<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#main {width: 80%; margin-left: 5%; margin-right: 5%;}
</style>

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
		<link rel="stylesheet" href="${contextPath }/assets/css/main.css" />
<script type="text/javascript">
	function secret(){
	    var checked = document.querySelector("input[name='qna_secret']:checked")
	    if(checked.value == "open"){
	    	$("#pwd").slideUp('fast');
	    }else{
	    	$("#pwd").slideDown('fast');
	    }
	}
	
	function register(){
		id = document.getElementById('id');
		title = document.getElementById('title');
		content = document.getElementById('content');
	
		if( id.value == "" ){
			alert("아이디는 필수 사항입니다.");
			id.focus();
		}else if( title.value == "" ){
			alert("제목은 필수 사항입니다.");
			title.focus();
		}else if( content.value == "" ){
			alert("내용은 필수 사항입니다.");
			content.focus();
		}else{
			fo.submit();
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
<h1>문의하고싶은 내용을 작성하세요.</h1>

<form id="fo" action="${contextPath }/qna/writeSave" method="post">
	<table>
		<tr>
			<th>제목</th> 
			<td><input type="text" name="qnaTitle" id="title"></td>
		</tr>
		
		<tr>
			<th>작성자</th> 
			<td>
				<c:choose>
					<c:when test="${userId != null}">
						<input type="hidden" name="id" id="id" value="${userId }">${userId }
					</c:when>
					<c:otherwise>
						<input type="hidden" name="id" id="id" value="admin">관리자
					</c:otherwise>
				</c:choose>
			</td>
		</tr>

		<tr>	
			<th>내용</th>
			<td> <textarea rows="15" cols="80" name="qnaContent"  id="content"></textarea> </td>
		</tr>
		
		<tr>	
			<th>비밀번호</th> 
			<td id="tdid">
				<input type="password" name="qnaPwd" placeholder="비밀글을 원하시면 입력해주세요">
				<!-- <input type="radio" name="qna_secret" value="open"onclick="secret()" checked >공개글
				<input type="radio" name="qna_secret" value="secret"onclick="secret()">비밀글 -->
			</td>
		</tr>		
		<tr>	
			<td colspan="2"> <button type="button" 
				onclick="location.href='${contextPath }/qna/allList'">목록</button>
			
				<button type="button" onclick="register()">등록</button>	
				
				<button type="button" 
				onclick="location.href='${contextPath }/qna/allList'">취소</button>
			</td>	
		</tr>
	</table>
</form>
</div>
<c:import url="../default/footer.jsp" />
</body>
</html>