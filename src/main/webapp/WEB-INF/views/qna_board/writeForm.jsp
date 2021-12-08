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
	var checked = document.querySelector("input[name='agreement']:checked")
	
		if( id.value == "" ){
			alert("아이디는 필수 사항입니다.");
			id.focus();
		}else if( title.value == "" ){
			alert("제목은 필수 사항입니다.");
			title.focus();
		}else if( content.value == "" ){
			alert("내용은 필수 사항입니다.");
			content.focus();
		}else if( checked.value == "nonAgree" ){
			alert("개인정보 수집 및 이용에 동의해 주시기 바랍니다.");
		}else{
			fo.submit();
		}
		
	}
	
</script>
</head>
<body>
<c:import url="../default/header.jsp" />
<h1>문의하고싶은 내용을 작성하세요.</h1>

<form id="fo" action="${contextPath }/qna/writeSave" method="post">
	<table>
		<tr>
			<th>제목</th> 
			<td><input type="text" name="qnaTitle" id="title"></td>
		</tr>
		
		<tr>
			<th>작성자</th> 
			<td><input type="hidden" name="id" id="id" value="${userId }">
				${userId }</td>
		</tr>

		<tr>	
			<th>내용</th>
			<td> <textarea rows="15" cols="80" name="qnaContent"  id="content"></textarea> </td>
		</tr>
		
		<tr>	
			<th>비밀글</th> 
			<td>
				<input type="radio" name="qna_secret" value="open"onclick="secret()" checked >공개글
				<input type="radio" name="qna_secret" value="secret"onclick="secret()">비밀글
			</td>
		</tr>
		
		<tr style="display: none" id="pwd">	
			<th>비밀번호</th>
			<td><input type="password" name="qnaPwd"></td>	
		</tr>
		
		<tr>
			<th>개인정보 수집 및 <br>이용 동의</th> 
			<td>
<textarea rows="10" cols="70" name="qna_content" readonly>■ 개인정보의 수집·이용 목적
서비스 제공 및 계약의 이행, 구매 및 대금결제, 물품배송 또는 청구지 발송, 회원관리 등을 위한 목적

■ 수집하려는 개인정보의 항목
이름, 주소, 연락처, 이메일 등

■ 개인정보의 보유 및 이용 기간
회사는 개인정보 수집 및 이용목적이 달성된 후에는 예외없이 해당정보를 파기합니다. 
</textarea><br>

				개인정보 수집 및 이용에 동의하십니까?
				<input type="radio" name="agreement" value="agree" >동의함
				<input type="radio" name="agreement" value="nonAgree" checked >동의안함

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
<c:import url="../default/footer.jsp" />
</body>
</html>