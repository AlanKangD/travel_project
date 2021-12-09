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
<body onload="init(${check})">
<c:if test="${check != null }">
	<script type="text/javascript">
		alert('비밀번호가 일치하지 않습니다.');
	</script>
</c:if>
<jsp:include page="../default/header.jsp" />
<div class="wrap">
<div align="center">
<h1>비밀글 보기</h1><br><br>

<h3> 이 글은 비밀글입니다. 비밀번호를 입력하여 주세요.<br>관리자는 확인버튼만 누르시면 됩니다.</h3><br>
<form action="${contextPath }/qna/secretPwd" method="post">
<input type="hidden" name="qnaNo" value="${qnaNo}"><br><br>
비밀번호 <input type="text" name="inputPwd"><br><br>
<button type="submit">확인</button>
</form>
<button onclick="location.href='${contextPath}/qna/allList'">목록</button>

</div>
<jsp:include page="../default/footer.jsp" />
</div>
</body>
</html>