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
.search select{
   	 height: 30px;
     width: 110px;
  }
</style>

	</head>
	<body>
		<!-- Wrapper -->
			<div id="wrapper">

				<!-- Header -->
					<header id="header">
						<div class="inner">

							<!-- Logo -->
								<a href="index.html" class="logo">
									<span class="symbol"><img src="${contextPath }/images/logo.svg" alt="" /></span><span class="title">Phantom</span>
								</a>

							<!-- Nav -->
								<nav>
									<ul>
										<li><a href="#menu">Menu</a></li>
									</ul>
								</nav>

						</div>
					</header>

				<!-- Menu -->
					<nav id="menu">
						<h2>Menu</h2>
						<ul>
							<li><a href="index.html">Home</a></li>
							<li><a href="generic.html">Ipsum veroeros</a></li>
							<li><a href="generic.html">Tempus etiam</a></li>
							<li><a href="generic.html">Consequat dolor</a></li>
							<li><a href="elements.html">Elements</a></li>
						</ul>
					</nav>

				<!-- Main -->		
					<div id="main">
						<div class="inner">
							<h1>새로운 장소를 추가해주세요!</h1>
							<form action="${contextPath }/main/register" method="post" enctype="multipart/form-data">
								<p>카테고리
								<select class="search" name="mainCategory">
									<option value="1">관광명소</option>
									<option value="2">맛집</option>
								</select>
								</p>
								<p>이미지 첨부<input type="file" name="mainImageFile" ></p>							
								<p>장소 이름  <input type="text" name="placeName"></p>
								<p>소개(내용1)<textarea rows="5" cols="10" name="contentOne"></textarea></p>
								<p>소개(내용2)<textarea rows="5" cols="10" name="contentTwo"></textarea></p>							
								<button>register</button>
							</form>
						</div>
					</div>
					
					
					
					

				<!-- Footer -->
					<footer id="footer">
						<div class="inner">						
							<section>
								<h2>Follow</h2>
								<ul class="icons">
									<li><a href="#" class="icon style2 fa-twitter"><span class="label">Twitter</span></a></li>
									<li><a href="#" class="icon style2 fa-facebook"><span class="label">Facebook</span></a></li>
									<li><a href="#" class="icon style2 fa-instagram"><span class="label">Instagram</span></a></li>
									<li><a href="#" class="icon style2 fa-dribbble"><span class="label">Dribbble</span></a></li>
									<li><a href="#" class="icon style2 fa-github"><span class="label">GitHub</span></a></li>
									<li><a href="#" class="icon style2 fa-500px"><span class="label">500px</span></a></li>
									<li><a href="#" class="icon style2 fa-phone"><span class="label">Phone</span></a></li>
									<li><a href="#" class="icon style2 fa-envelope-o"><span class="label">Email</span></a></li>
								</ul>
							</section>
							<ul class="copyright">
								<li>&copy; Untitled. All rights reserved</li><li>Design: <a href="http://html5up.net">HTML5 UP</a></li>
							</ul>
						</div>
					</footer>

			</div>

		<!-- Scripts -->
			<script src="${contextPath }/assets/js/jquery.min.js"></script>
			<script src="${contextPath }/assets/js/skel.min.js"></script>
			<script src="${contextPath }/assets/js/util.js"></script>
			<script src="${contextPath }/assets/js/main.js"></script>

	</body>
</html>