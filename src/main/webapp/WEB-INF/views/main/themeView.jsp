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
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f74b78e78ff1ceeb17f3c9accbcac27c"></script>
<style>
	#main {width: 80%; margin-left: 10%; margin-right: 10%;}
	.flex{display: flex;}
	.flexB{background-color: red; width: 50%; padding-left: 100px;}
	
</style>
	</head>
	<body>
	<c:import url="../default/header.jsp"></c:import>
	

<!-- Wrapper -->

		<!-- Main -->
			<div id="main">
			<form action="${contextPath }/main/addMyList" method="post">
				<br><a href="../main/themeList">뒤로가기 </a>
				<div class="inner" style="text-align: center">
					<h1><input type="hidden" name="place" value="${dto.placeName }">${dto.placeName }</h1>
					<h5>테마 : ${dto.mainCategory }</h5>				
					<p  style="margin-left: 80%">				
						<input type="hidden" name="mainId" value="${dto.mainId }">
						<button type="submit" name="userId" value="${userId }" >일정 추가하기</button>
					</p>
					<span class="image main">
					<input type="hidden" name="image" value="${dto.mainImageFile }">
					<img style="height:500px;" src="${contextPath }/main/download?mainImageFile=${dto.mainImageFile}" />
					</span>
					<p>${dto.contentOne }</p>
					<p>${dto.contentTwo }</p>							
				</div>					
			</form>
				<div class='flex'>	
					<div class="flexA" id="map" style="width:500px;height:400px;"></div>
					<script>
						var container = document.getElementById('map');
						var options = {
							center: new kakao.maps.LatLng(33.469651, 126.493169),
							level: 3
						};			
						var map = new kakao.maps.Map(container, options);
					</script>		
					<div class="flexB">
						<h3><br>주변 맛집을 추천해주세요!</h3> 
					</div>
				</div>	
				
				
			</div>				
		<c:import url="../default/footer.jsp"></c:import>			
	</body>
</html>