<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<table border="1">
	<tr>
		<td>id</td> <td>pw</td> <td>email</td> <td>phoneNumber</td>
	</tr>
	<c:forEach items="${memberList }" var="list">
	<tr>
		<th>${list.id }</th> <th>${list.pw }</th> <th>${list.email }</th> <th>${list.phoneNumber }</th>
	</tr>
	</c:forEach>
</table>



</body>
</html>