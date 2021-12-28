<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>   
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${contextPath }/assets/css/main.css" />
<style type="text/css">
.qua-secret-div {
	margin-left: 25%;
	width: 50%;
}
.qua-secret-label {
	width: 100%;
	text-align: left;
}
.qua-secret-label-btn {
	width: 100%;
	text-align: right;
}
</style>
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
<div class="wrap" style="padding-left: 50px; padding-right: 50px;">
<div align="center" class="qua-secret-div">
<h1>비밀글 보기</h1><br><br>

<h3> 이 글은 비밀글입니다. 비밀번호를 입력하여 주세요.<br>관리자는 확인버튼만 누르시면 됩니다.</h3><br>
<form action="${contextPath }/qna/secretPwd" method="post">
<input type="hidden" name="qnaNo" value="${qnaNo}"><br><br>
<div class="qua-secret-label">
	<b>비밀번호</b><input type="text" name="inputPwd">
</div>
<button type="button" 
	onclick="location.href='${contextPath }/qna/allList?num=${num}&searchOption=${searchOption}&keyword=${keyword}'">목록</button>
<button type="submit">확인</button>	
</form>


</div>
<jsp:include page="../default/footer.jsp" />
</div>
</body>
</html>