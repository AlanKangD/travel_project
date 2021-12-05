<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:import url="../default/header.jsp" />
	<h1>비밀글 보기</h1>
	
	이 글은 비밀글입니다. 비밀번호를 입력해주세요.<br>
	관리자는 확인버튼만 누르시면 됩니다.<p>
	
	<form action="${contextPath }/qna/pwdCheck" method="post">
		<input type="hidden" name="qnaNo" value="${qnaNo }">
		&gt; 비밀번호 <input type="password" name="qnaPwd"><br>
	
	<button type="button" 
				onclick="location.href='${contextPath }/qna/allList'">목록</button>
	<button type="submit">확인</button>
	</form>
<c:import url="../default/footer.jsp" />
</body>
</html>