<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
		<link rel="stylesheet" href="${contextPath }/assets/css/main.css" />
</head>
<body>
<c:import url="../default/header.jsp"/>
<table border="1">
	<tr>
		<td>id</td> <td>pw</td> <td>email</td> <td>phoneNumber</td>
	</tr>
	<c:forEach items="${memberList }" var="list">
	<tr>
		<th>
			<a href="${contextPath }/member/memberView?id=${list.id }">${list.id }</a>
		</th> <th>${list.pw }</th> <th>${list.email }</th> <th>${list.phoneNumber }</th>
	</tr>
	</c:forEach>
</table>
<c:import url="../default/footer.jsp"/>


</body>
</html>