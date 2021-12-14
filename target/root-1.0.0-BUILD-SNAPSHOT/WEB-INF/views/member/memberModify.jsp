<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${ pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	function register() {
		addr1 = $('#addr1').val()
		addr2 = $('#addr2').val()
		addr = addr1 + "/" + addr2 + "/" + addr3
		$('#addr1').val(addr)
		fo.submit()
	}

	function daumpost() {
		new daum.Postcode({
			oncomplete : function(data) {
				// R : 도로명, J : 지번
				console.log("data.userSelectedType : " + data.userSelectedType)
				console.log("data.roadAddress : " + data.roadAddress)
				console.log("data.jibunAddress : " + data.jibunAddress)
				console.log("data.zonecode : " + data.zonecode)

				var addr = ""
				if (data.userSelectedType === 'R') {
					addr = data.roadAddress
				} else {
					addr = data.jibunAddress
				}
				document.getElementById("addr1").value = data.zonecode
				$("#addr2").val(addr)
				$("#addr3").focus()
			}
		}).open();
	}
</script>
</head>
<body>
	<c:import url="../default/header.jsp" />
<div align="center">
	<form id=fo action="${contextPath }/member/memberModify" method="post">
		아이디 : <input type="text" name="id" value="${id }" readonly><br> 
		비밀번호 : <input type="text" name="pw" placeholder="수정 할 비밀번호 입력"><br> 
		이메일 : <input type="text" name="email" placeholder="수정 할 이메일 입력"><br> 
		전화번호 : <input type="text" name="phoneNumber" value="010--"><br> 
		주소 입력 : <input type="text" id="addr1" name="addr1"  readonly placeholder="우편번호" >
		<input type="button" onclick="daumpost()" value="우편번호 찾기"><br>
		<input type="text" id="addr2" name="addr2" readonly placeholder="주소" ><br>
		<input type="text"id="addr3" name="addr3"  placeholder="상세주소"><br>
		<input type="submit"  value="수정하기">
	</form>
</div>
	<c:import url="../default/footer.jsp" />
</body>
</html>