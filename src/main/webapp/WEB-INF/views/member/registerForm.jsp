<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${ pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${contextPath }/assets/css/main.css" />
<style type="text/css">
.info-register-div {
	margin-left: 25%;
	width: 50%;
}
.info-register-label {
	width: 100%;
	text-align: left;
}
.info-register-label-btn {
	width: 100%;
	text-align: right;
}
</style>
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
	function idChk(){
		$.ajax({
			url:"member/idChk",
			type:"GET",
			datatype:"json",
			data:{"id":$("#id").val()},
			success:function(data){
				if(data.result == 1){
					$("#idChk").css('color','red')
					$("#idChk").text("중복된 아이디 입니다")
				}else if(data.result == 0){
					$("#idChk").attr("value","Y");
					$('#idChk').css('color','blue')
					$('#idChk').text("사용 가능한 아이디 입니다")
				}
			},error:function(){
				alert("아이디를 입력하세요")
			}			
		})
	}
	function login(){
		var popHeight=290;
		var popWidth=230;
		var winHeight=document.body.clientHeight;
		var winWidth=document.body.clientWidth;
		var winX=window.screenLeft;
		var winY=window.screenTop;
		
		var popX=winX+(winWidth-popWidth)/2;
		var popY=winY+(winHeight-popHeight)/2;
		window.resizeTo(290,230)
		window.open(url, "pop",  "top="+popY+", left="+popX+",width="+popWidth+",height="+popHeight+", scrollbars=yes,resizable=yes");
	}
</script>
</head>
<body>

<c:import url="../default/header.jsp" />
	<div class="wrap"
		style="padding-left: 50px; padding-right: 50px;">
	<div align="center" class="info-register-div">
	<form id=fo action="${contextPath }/member/registerWrite" method="post">
	
		<div class="info-register-label">
			<b style="text-align: left;">아이디</b>
		</div>
		<input type="text" name="id" id="id" placeholder="(필수)가입할 아이디 입력">
		<div class="info-register-label-btn">
			<input type="button" onclick="idChk()" value="아이디중복체크">
		</div>
		<br>
		
		<span id="idChk"></span><br>
		
		<div class="info-register-label">
			<b style="text-align: left;">비밀번호</b>
		</div>
		<input type="text" name="pw" placeholder="(필수)가입할 비밀번호 입력"><br> 
		
		<div class="info-register-label">
			<b style="text-align: left;">이메일</b>
		</div>
		<input type="text" name="email" placeholder="(필수)가입할 이메일 입력"><br> 
		
		<div class="info-register-label">
			<b style="text-align: left;">전화번호</b>
		</div>
		<input type="text" name="phoneNumber" value="010--"><br> 
		
		<div class="info-register-label">
			<b style="text-align: left;">주소</b>
		</div>
		<input type="text" id="addr1" name="addr1"  readonly placeholder="우편번호" >
		
		<div class="info-register-label-btn">
			<input type="button" onclick="daumpost()" value="우편번호 찾기"><br>
		</div>
		
		<input type="text" id="addr2" name="addr2" readonly placeholder="주소" ><br>
		<input type="text"id="addr3" name="addr3"  placeholder="상세주소"><br>
		<input type="submit"  value="가입하기" onclick="login()">
	</form>
	</div>
	</div>
	<c:import url="../default/footer.jsp" />
</body>
</html>