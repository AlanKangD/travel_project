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
<div align="center">
		<table border="1">
			<tr>
				<td>id</td> <td>pw</td> <td>email</td> <td>address</td>
			</tr>
			<tr>
				<th>${myInfo.id }</th> <th>${myInfo.pw }</th> <th>${myInfo.email }</th>	<th>${myInfo.addr1 },${myInfo.addr2 },${myInfo.addr3 }</th>		 	
			</tr>
		</table>
		<a href="${contextPath }/myPage/ModifyForm?id=${myInfo.id }">수정하기</a>
		<a href="${contextPath }/myPage/Delete?id=${myInfo.id }">삭제하기</a>
	</div>
</body>
</html>