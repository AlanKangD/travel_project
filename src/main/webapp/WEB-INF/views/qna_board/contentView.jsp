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
</style>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js" integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js" integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
	function modify(){
		title = document.getElementById('title');
		content = document.getElementById('content');
	
		if( title.value == "" ){
			alert("제목은 필수 사항입니다.");
			title.focus();
		}else if( content.value == "" ){
			alert("내용은 필수 사항입니다.");
			content.focus();
		}else{
			fo.submit();
		}
	}
	
	function replyShow() {
		$("#reply").slideDown('fast');
	}
	
	
	function addReply() {
		let form = {}
		let arr = $("#replyFo").serializeArray()
		console.log(arr)
		for(i = 0; i < arr.length; i++){
			form[arr[i].name] = arr[i].value;
		}
		$.ajax({
			url : "addReply",
			type : "POST",
			dataType : "json",
			data : JSON.stringify(form),
			contentType : "application/json; charset=utf-8",
			success : function(data){
				console.log(data)
				console.log(data.result)
				if(data.result == true){
					alert("답변이 정상적으로 작성되었습니다.")
					$("#reply").slideUp('fast');
					$("#repContent").val("");
					getReply();
				}else{
					alert("답변작성 도중 오류가 발생하였습니다.")
				}
				
			},error : function(){
				alert("서버문제 발생");
			}
		})
	}
	
	function getReply() {
		$.ajax({
			url : "getReply/"+${dto.qnaNo},
			type : "get",
			dataType : "json",
			success : function(list){
				console.log(list)
				let html = "";
				list.forEach(function(data){
					let qrIdContent = data.qrId + data.qrContent
					html += "<div><b>답변자 : 관리자</b> | "
	                html += "<b>답변일</b> : "+data.saveDate+"<br><br>"
	                
	                if('${adminId}' == ""){
	                	html += "<textarea rows='10' cols='50' name='qrContent' readonly>"+data.qrContent+"</textarea><br>"
	                }else{
		                html += "<form action='${contextPath }/qna/repModify' method='post'>"
		                html += "<input type='hidden' name='qrId' value='"+data.qrId+"'>"
		                html += "<textarea rows='5' cols='80' name='qrContent'>"+data.qrContent+"</textarea><br>"
		                html += "<button type='submit' class='btn btn-dark'>답변수정</button>"
		                html += "<button type='button' onclick='repDelete("+data.qrId+")' class='btn btn-dark'>답변삭제</button></div><hr>"
		                html += "</form>"
	                }
	             })
				$("#getReply").html(html)
			},erorr : function(){
				alert("서버문제 발생");
			}
		})
	}
	
	function repModify(qrContent) {
		console.log(qrContent)
	}
	
	function repDelete(qrId) {
		console.log(qrId)
		$.ajax({
			url : "repDelete/"+qrId,
			type : "post",
			dataType : "json",
			success : function(data){
				console.log(data)
				console.log(data.result)
				if(data.result == true){
					alert("답변이 정상적으로 삭제되었습니다.")
					getReply();
				}else{
					alert("삭제 도중 오류가 발생하였습니다.")
				}
			},error : function(){
				alert("서버문제 발생");
			}
		})
	}
	
</script>
</head>
<body onload="getReply()">
<c:import url="../default/header.jsp" />
<div class="wrap">

<form id="fo" action="${contextPath }/qna/modify" method="post">
 	<input type="hidden" name="qnaNo" value="${dto.qnaNo }">
	
	<h2>Q&A</h2>
	<hr>
	<c:choose>
		<c:when test="${dto.id == userId}">
			<h3><b><input type="text" name="qnaTitle" id="title" value="${dto.qnaTitle }"></b></h3>
		</c:when>
		<c:otherwise>
			<h3><b>${dto.qnaTitle }</b></h3>
		</c:otherwise>
	</c:choose>
	<br>
	<b>작성자</b> : ${dto.id } &nbsp; <b>작성일</b> : ${dto.saveDate } &nbsp; <b>조회</b> : ${dto.qnaHit }<br>
	<hr>
	<c:choose>
		<c:when test="${dto.id == userId}">
			<textarea class="partC" rows="7" cols="80" name="qnaContent"
									 id="content">${dto.qnaContent }</textarea> 
		</c:when>
		<c:otherwise>
			<textarea class="partC" rows="7" cols="80" name="qnaContent" readonly
									 id="content">${dto.qnaContent }</textarea> 
		</c:otherwise>
	</c:choose>
	<p>
	<p>
	<p>
		<c:if test="${adminId != null }">
			<button type="button" class="btn btn-dark" onclick="replyShow()">답변하기</button>
		</c:if>
	<hr>
</form>	
	<div id="getReply"></div>
	
	<div align="right">
	<c:if test="${dto.id == userId}">
		<button type="button"  class="btn btn-dark" onclick="modify()">수정</button>	
	</c:if>
	<c:if test="${dto.id == userId or adminId != null}">
		<button type="button"  class="btn btn-dark"  
		onclick="location.href='${contextPath }/qna/delete?qnaNo=${dto.qnaNo}'">삭제</button>
	</c:if>	
	<button type="button" class="btn btn-dark" onclick="location.href='${contextPath }/qna/allList?num=${num}&searchOption=${searchOption}&keyword=${keyword}'">목록</button>
	</div>
	
	<div id="reply" style="display: none;">
		<form id="replyFo">
			<h3>답변을 작성하세요</h3>
			<input type="hidden" name="qrWriteGroup" value="${dto.qnaNo }">
			<input type="hidden"  name="id" value="admin">
			<textarea rows="10" cols="50" name="qrContent" id="repContent"></textarea>
			<button type="button" onclick="addReply()">답변 작성완료</button>
		</form>
	</div>	

</div>
<c:import url="../default/footer.jsp" />
</body>
</html>