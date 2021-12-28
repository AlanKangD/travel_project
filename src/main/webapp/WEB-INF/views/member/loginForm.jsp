<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript">
function parentRefresh(){
	console.log("체크");
	fo.submit()
}
function registerForm(url,name){
	var popHeight=2000;
	var popWidth=1000;
	var winHeight=document.body.clientHeight;
	var winWidth=document.body.clientWidth;
	var winX=window.screenLeft;
	var winY=window.screenTop;
	
	var popX=winX+(winWidth-popWidth)/40;
	var popY=winY+(winHeight-popHeight)/40;
	window.resizeTo(1750,950)
	window.open(url, "pop",  "top="+popY+", left="+popX+",width="+popWidth+",height="+popHeight+", scrollbars=yes,resizable=yes");
}
</script>
<style type="text/css">
/* RESET */
* {
  box-sizing: border-box;
  padding: 0;
  margin: 0;
}
body { background: #36384f; }
body, p, input, button, span {
  font-size: 14px;
  text-decoration: none;
  color: #36384f;
}
li {
  list-style: none;
  cursor: pointer;
}
button {
  cursor: pointer;
  border: 0;
}

/* STYLE */
.main_con_form {
  text-align: left;
  padding: 40px;
}
.main_con_form span {
  color: #efefef;
}
.form_inner {
  width: 100%;
  height: 100%;
}
.main_con_form h1 {
  font-size: 28px;
}
.form_list_input {
  width: 254px;
  height: 100%;
  margin-top: 20px;
}
.form_list_input li {
  height: 54px;
}
/***** INPUT *****/
.form_list_input input {
  padding: 0 1em; 
  border: 0;
  height: 38px;
  width: 100%;
  border-radius: 30px;
}
.form_list_input input:focus {
  outline: none;
}
.form_list_input input::placeholder {
  font-weight: 300;
  color: #aaa;
}
.form_list_input label {
  float: left;
  display: none;
}
.enter_btn {
  width: 100%;
  height: auto;
}
.login-btn {
  overflow: hidden;
  width: 154px;
  height: 40px;
  background: #e96c7c;
  border-radius: 20px;
}
</style>
</head>
<body>
${ss}    <!-- 로그인 성공시 팝업창 닫힘 -->
	<div class="main_con_form">
		<c:choose>
			<c:when test="${adminId != null}">
				관리자님 환영합니다!
			</c:when>
			<c:when test="${userId != null }">
				${userId } 님 환영합니다!
			</c:when>
		</c:choose>
	
  		<div class="form_inner">
    		<span><h1>Login</h1></span>
    	<div>
    	<c:if test="${userId == null && adminId == null}">
    		<form id='fo' action="${contextPath }/member/loginChk" method="post">
      			<ul class="form_list_input">
        			<li><input type="text" id="id" name="id" placeholder="Input Id"></li>
        			<li><input type="password" id="pw" name="pw" placeholder="Input Password"></li>
        			<li><a style="color: white;" href="javascript:registerForm('${contextPath }/member/registerForm','registerForm');">회원가입</a></li>
      			</ul>
    		<div class="enter_btn">
    			<input type="button" class="login-btn" value="Login" onclick="parentRefresh()">
  			</div>
  		</form>
		</c:if>
	</div>
</div>
	
	
	
	
		<%-- <c:if test="${userId == null && adminId == null}">
		<form id='fo' action="${contextPath }/member/loginChk" method="post">
			<div class="login-form-div-1">
				<div class="login-form-div-1-1">
					<input type="text" name="id" placeholder="로그인할 아이디 입력">
				</div>
			</div>
			<br>
			<div class="login-form-div-1">
				<div class="login-form-div-1-1">
					<input type="password" name="pw" placeholder="로그인할 비밀번호 입력">
				</div>
			</div>
			<br>
			<div style="align:left;">
			<a href="javascript:registerForm('${contextPath }/member/registerForm','registerForm');">회원가입</a>
			<input type="button" value="로그인"  onclick="parentRefresh()">
			</div>
		</form>
		</c:if>
	
	</div> --%>


</body>
</html>