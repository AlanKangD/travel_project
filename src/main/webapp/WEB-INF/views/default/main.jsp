<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.mainTable {
	margin: auto;
}

.mainTable td {
	text-align: center;
}

.name {
	text-align: right;
}
</style>
</head>
<body>
	<jsp:include page="header.jsp" />
	<div class="wrap content">
		<table class="mainTable">
			<tr>
				<td>
					<h3>
						내 사전에 불가능은 없다.<br> 불가능은 소극적인 자의 환영이며<br> 비겁한 자의 도피처 이다.<br>
					</h3>
				</td>
			</tr>
			<tr>
				<td>
					<h3 class="name">- 나폴레옹</h3>
				</td>
			</tr>
		</table>
	</div>
	<jsp:include page="footer.jsp" />

</body>
</html>
