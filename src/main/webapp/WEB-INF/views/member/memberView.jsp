<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:import url="../default/header.jsp"/>
	<div align="center">
		<table border="1">
			<tr>
				<td>id</td> <td>pw</td> <td>가입날짜</td> <td>email</td>
			</tr>
			<tr>
				<th>${user.id }</th> <th>${user.pw }</th>	<th>${user.registerDate }</th><th>${user.email }</th>			 	
			</tr>
		</table>
		<a href="${contextPath }/member/memberModifyForm?id=${user.id }">수정하기</a>
		<a href="${contextPath }/member/memberDelete?id=${user.id }">삭제하기</a>
	</div>
<c:import url="../default/footer.jsp"/>
</body>
</html>