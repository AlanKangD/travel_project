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
	
	
	var click = 1;
	function replyShow() {
		if(click == 1){
			 $("#reply").slideDown('fast');
			 click = 0;
		}else{
			$("#reply").slideUp('fast');
			click = 1;
		}
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
				}else{
					alert("답변작성 도중 오류가 발생하였습니다.")
				}
				
			},error : function(){
				alert("서버문제 발생");
			}
			
		})
		
		
		
		
	}
	
</script>
</head>
<body>
<c:import url="../default/header.jsp" />

<c:if test="${dto.qnaPwd != null}">
	<c:if test="${pwd == null}">
		<c:redirect url="/qna/pwdForm?qnaNo=${dto.qnaNo}"/>
	</c:if>
</c:if>

<form id="fo" action="${contextPath }/qna/modify" method="post">
 	<input type="hidden" name="qnaNo" value="${dto.qnaNo }">
	<table>
		<tr>
			<th>제목</th> 
			<td><input type="text" name="qnaTitle" id="title" value="${dto.qnaTitle }"></td>
		</tr>
		<tr>
			<th>작성자</th> 
			<td>${dto.id }</td>
		</tr>
		<tr>	
			<th>조회수</th>
			<td>${dto.qnaHit }</td>
		</tr>	
		<tr>	
			<th>내용</th>
			<td><textarea rows="10" cols="30" name="qnaContent"
								 id="content">${dto.qnaContent }</textarea> </td>
		</tr>	

		<tr>	
			<th>작성날짜</th>
			<td>${dto.saveDate }</td>
		</tr>	
		
		<tr>	
			<td colspan="2"> <button type="button" 
				onclick="location.href='${contextPath }/qna/allList'">목록</button>
			
				<button type="button" onclick="modify()">수정</button>	
			
				<button type="button" 
				onclick="location.href='${contextPath }/qna/delete?qnaNo=${dto.qnaNo}'">삭제</button>
			
				<button type="button" onclick="replyShow()">답변달기</button>
			</td>	
		</tr>
	</table>
</form>

<div id="reply" style="display: none;">
<form id="replyFo">
	<h3>답변을 작성하세요</h3>
	<input type="hidden"  name="qrWriteGroup" value="${dto.qnaNo }">
	<input type="hidden"  name="id" value="admin">
	<textarea rows="10" cols="50" name="qrContent"></textarea>
	<button type="button" onclick="addReply()">답변 작성완료</button>
</form>
</div>

<c:import url="../default/footer.jsp" />
</body>
</html>