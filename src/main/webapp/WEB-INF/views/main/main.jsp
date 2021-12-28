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
<link rel="stylesheet" href="${contextPath }/assets/css/main.css?v=3" />
<style type="text/css">
.travel_main_header {
	width: 100%;
    height: 500px;
    background-image: url(/root/resources/img/main_header.png);
    background-size: cover;
    background-repeat: no-repeat;
    background-position: center;
    padding: 1px;
}
.travel_main_title {
	color: white;
    font-size: 40px;
    margin-top: 250px;
    margin-bottom: 30px;
    margin-left: 50px;
}
.travel_main_title_sub {
	color: white;
    font-size: 30px;
    margin-bottom: 30px;
    margin-left: 50px;
}
.travel_main_intro {
	margin-top: 50px;
	font-size: 26px;
	text-align: center;
}
</style>
</head>
	<body>
	<c:import url="../default/main_header.jsp"></c:import>
	<div class="travel_main_header">
		<h2 class="travel_main_title">여행의 설렘은 계획부터 시작되는 거니까.</h2>
        <h4 class="travel_main_title_sub">지금 트래줄러에서 설렘을 계획해 보세요.</h4>
	</div>
			<div id="wrapper">
					<div id="main">
						<div class="inner">
							<header>
								<div class="travel_main_intro">
								<h2>여행 계획의 시작은 ‘테마 정하기’예요.<br />
								자신의 취향에 맞는 테마부터 한번 골라볼까요 ?</h2>
								</div>
							</header>
							<section class="tiles">
								<article class="style1">
									<span class="image">
										<img src="images/pic01.jpg" alt="" />
									</span>
										<a href="${contextPath }/main/themeList?theme=힐링" >
										<h2>힐링</h2>
										<div class="content">
											<p>몸도 마음도 지친 당신을 위해 준비했어요.</p>
										</div>
									</a>
								</article>
								<article class="style2">
									<span class="image">
										<img src="images/pic02.jpg" alt="" />
									</span>
									<a href="${contextPath }/main/themeList?theme=식도락" >
										<h2>식도락</h2>
										<div class="content">
											<p>맛있는 음식으로 가볍게 기분전환하고 싶은 당신을 위해 준비했어요.</p>
										</div>
									</a>
								</article>
								<article class="style3">
									<span class="image">
										<img src="images/pic03.jpg" alt="" />
									</span>
									<a href="${contextPath }/main/themeList?theme=관광지" >
										<h2>관광지</h2>
										<div class="content">
											<p>제주도의 유명한 관광지를 여행하고싶은 당신을 위해 준비했어요.</p>
										</div>
									</a>
								</article>
								<article class="style4">
									<span class="image">
										<img src="images/pic04.jpg" alt="" />
									</span>
									<a href="${contextPath }/main/themeList?theme=액티비티" >
										<h2>액티비티</h2>
										<div class="content">
											<p>온몸으로 짜릿함을 느끼고 싶은 당신을 위해 준비했어요.</p>
										</div>
									</a>
								</article>
								<article class="style5">
									<span class="image">
										<img src="images/pic05.jpg" alt="" />
									</span>
									<a href="${contextPath }/main/themeList?theme=글램핑" >
										<h2>글램핑</h2>
										<div class="content">
											<p>자작한 불소리와 함께 조용함을 즐기고 싶은 당신을 위해 준비했어요.</p>
										</div>
									</a>
								</article>
								<article class="style6">
									<span class="image">
										<img src="images/pic06.jpg" alt="" />
									</span>
									<a href="${contextPath }/main/themeList?theme=드라이브" >
										<h2>드라이브</h2>
										<div class="content">
											<p>멋진 풍경과 함께 시원하게 달리고 싶은 당신을 위해 준비했어요.</p>
										</div>
									</a>
								</article>								
							</section>
						</div>
					</div>
			</div>
		<c:import url="../default/footer.jsp"></c:import>			
	</body>
</html>
