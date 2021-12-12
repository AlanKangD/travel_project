<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>    
<!DOCTYPE html>
<html>
	<head>
		<title>Phantom by HTML5 UP</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<link rel="stylesheet" href="${contextPath }/assets/css/main.css" />
				
	</head>
	<body>
	<c:import url="../default/header.jsp"></c:import>
		<!-- Wrapper -->
			<div id="wrapper">
				<!-- Main -->
					<div id="main">
						<div class="inner">
							<header>
								<h1>This is Phantom, a free, fully responsive site<br />
								template designed by <a href="http://html5up.net">HTML5 UP</a>.</h1>
								<p>Etiam quis viverra lorem, in semper lorem. Sed nisl arcu euismod sit amet nisi euismod sed cursus arcu elementum ipsum arcu vivamus quis venenatis orci lorem ipsum et magna feugiat veroeros aliquam. Lorem ipsum dolor sit amet nullam dolore.</p>
							</header>
							<a href="../index">뒤로가기 </a>
							<button onclick="location.href='${contextPath}/main/addPlace' ">Add Place(관리자용)</button>
						
							<section class="tiles">
							<c:forEach var="list" items="${list }">
								<article style="width:250px; height:250px;" class="style1">
										<span class="image">
											<img src="${contextPath }/images/pic01.jpg" alt="" />
										</span>
											<a href="${contextPath }/main/themeView?mainId=${list.mainId}">
											<h2>${list.placeName }</h2>
											<div class="content">
												<p>${list.contentOne }</p>
											</div>
										</a>
									</article>
							</c:forEach>																					
							</section>
						</div>
					</div>
			</div>
<c:import url="../default/footer.jsp"></c:import>			
	</body>
</html>
