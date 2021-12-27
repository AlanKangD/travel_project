<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${ pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${contextPath }/assets/css/main.css" />
<style type="text/css">
.info-modify-div {
	margin-left: 25%;
	width: 50%;
}
.info-modify-label {
	width: 100%;
	text-align: left;
}
.info-modify-label-btn {
	width: 100%;
	text-align: right;
}
</style>
<meta charset="UTF-8">
<title>내 정보 수정</title>
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
	<div class="wrap"
		style="padding-left: 50px; padding-right: 50px;">
	<div align="center" class="info-modify-div">
		<form id=fo action="${contextPath }/myPage/userModify" method="post">
			<div class="info-modify-label">
				<b style="text-align: left;">아이디</b>
			</div>
			<input type="text" name="id" value="${id }" readonly><br>
			
			<div class="info-modify-label">
				<b style="text-align: left;">비밀번호</b>
			</div>
			<input type="text" name="pw" placeholder="수정 할 비밀번호 입력"><br>
			
			<div class="info-modify-label">
				<b style="text-align: left;">이메일</b>
			</div> 
			<input type="text" name="email" placeholder="수정 할 이메일 입력"><br>
			
			<div class="info-modify-label">
				<b style="text-align: left;">전화번호</b>
			</div> 
			<input type="text" name="phoneNumber" value="010--"><br>
			
			<div class="info-modify-label">
				<b style="text-align: left;">주소</b>
			</div>  
			<input type="text" id="addr1" name="addr1"  readonly placeholder="우편번호" >
			<div class="info-modify-label-btn">
				<input type="button" onclick="daumpost()" value="우편번호 찾기"><br>
			</div>
			<input type="text" id="addr2" name="addr2" readonly placeholder="주소" ><br>
			<input type="text"id="addr3" name="addr3"  placeholder="상세주소"><br>
			<input type="submit" value="수정하기">
		</form>
	</div>
	</div>
	<c:import url="../default/footer.jsp" />
</body>
</html>