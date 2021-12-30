<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>    
<!DOCTYPE html>
<html>
	<head>
		<title>여행지 목록</title>
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
								<h1 style="font-size: 40px; color: skyblue;"><i><strong style="color:#5aacf1;">'${ theme }'</strong> 테마를 선택하셨군요.</i></h1>
								<p>테마를 정했으니 이제 테마 속 다양한 여행지들을 확인해볼까요 ?<br>
								자신의 취향에 맞는 여행지를 선택하고 일정에 추가하여 여행을 떠나보세요 !
								</p>					
							</header>
							<a href="../index">뒤로가기 </a>
							
							<c:if test="${adminId != null}">
							<button onclick="location.href='${contextPath}/main/addPlace?theme=${theme }' ">Add Place(관리자용)</button>
							</c:if>

							<section class="tiles">
							<c:forEach var="list" items="${list }">
								<article style="width:250px; height:250px;">
										<span class="image">
											<img src= "${contextPath}/main/download?imageFile=${list.mainImageFile}" width="250px;" height="250px;">
										</span>
											<a href="${contextPath }/main/themeView?placeName=${list.placeName}">
											<h3>${list.placeName }</h3>
											<div class="content">
												<p>${list.contentOne }</p>
											</div>
										</a>
										<c:choose>
											<c:when test="${ list.likeHit == 0 }">
												관심콘텐츠 <img src="${contextPath}/resources/img/like_off.png" width="20px;" height="20px"> 0
											</c:when>
											<c:otherwise>
												관심콘텐츠 <img src="${contextPath}/resources/img/like_on.png" width="20px;" height="20px"> ${ list.likeHit }
											</c:otherwise>
										</c:choose>
										
									</article>
							</c:forEach>																					
							</section>
						</div>
					</div>
			</div>
<c:import url="../default/footer.jsp"></c:import>			
	</body>

</html>