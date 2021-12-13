<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>    
<!DOCTYPE html>
<html>
	<head>
		<title>Generic - Phantom by HTML5 UP</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<link rel="stylesheet" href="${contextPath }/assets/css/main.css" />

<style type="text/css">
	#main {width: 80%; margin-left: 10%; margin-right: 10%;}
  .pp {display:flex; background-color: aqua;}
  .selectA{background-color: green; width:150px;}
  .selectB { background-color: red; width:150px;}
  
</style>
</head>
<body>
<c:import url="../default/header.jsp"></c:import>
				<!-- Main -->		
					<div id="main">
							<h1>새로운 장소를 추가해주세요!</h1>
							<form action="${contextPath }/main/register" method="post" enctype="multipart/form-data">												
								<div class="pp">
									<div class="selectA">카테고리</div>
									<div class="selectB">
										<p>카테고리 : ${theme }</p> <input type="hidden" name="mainCategory" value="${theme }">
										</div>
								</div>
								<p>이미지 첨부<input type="file" name="mainImageFile" ></p>							
								<p>장소 이름  <input type="text" name="placeName"></p>
								<p>소개(내용1)<textarea rows="5" cols="10" name="contentOne"></textarea></p>
								<p>소개(내용2)<textarea rows="5" cols="10" name="contentTwo"></textarea></p>							
								<p>주소 : <input name="address"></p>                     
                   			    <p>위도 : <input name="latitude"> 경도 : <input name="longitude"></p>
								<button>register</button>
							</form>
							<br><a href="../main/themeList">뒤로가기 </a>
						</div>			
		<c:import url="../default/footer.jsp"></c:import>			
	</body>
</html>