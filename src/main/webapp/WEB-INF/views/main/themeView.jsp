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
<script>
function addMyList() {
	   
	   let form = {};
	   let arr = $("#listForm").serializeArray()
	   console.log(arr)
	   for (i = 0; i < arr.length; i++) {
	         form[arr[i].name] = arr[i].value;
	      }
	   console.log(form)
	   $.ajax({
	      url : "addMyList",
	      type : "POST",
	      dataType : "json",
	      data : JSON.stringify(form),
		  contentType : "application/json;charset=utf-8",
		  success : function(data) {
	            console.log(data)
	            console.log(data.result);
	            if(data.result == true){
	               alert("일정추가 완료!")
	            }else if(data.result == "overList"){
	              alert("일정은 최대 10개까지만 추가 가능합니다!")     
	            }else if(data.result == false){
	               alert("이미 일정추가한 관광지입니다!")      
	            }else{
	               alert("오류로 인해 저장에 실패했습니다!")
	            }
	         },
	      error : function() {
	         alert("서버문제 발생!")
	      }
	   })  
	}
	
	function deleteView(placeName){
		console.log(placeName)
		$.ajax({
			url : "deleteView?placeName="+placeName,
			type : "delete",
			dataType : "json",
			success : function(data){
				console.log(data.result)
				if(data.result == true){
					alert("삭제 성공");
					location.href="${pageContext.request.contextPath}/index";
				}else{
					alert("에이젝스 data result == false");
				}
			},error : function(){
				alert("에이젝스 실패 , 서버 문제 발생");
			}
		})		
	}
	
	
	
	
</script>


	</head>
	<body>
	<c:import url="../default/header.jsp"></c:import>
	

<!-- Wrapper -->

		<!-- Main -->
			<div id="main">	
			<form id="listForm">
				<input type="hidden" name="place" value="${dto.placeName }">
				<input type="hidden" name="image" value="${dto.mainImageFile }">
				<input type="hidden" name="id" value="${userId}">
			</form>			
				
			<c:if test="${userId != null}">
                  <button  style="margin-left: 80%" onclick="addMyList()">일정 추가하기</button>
             </c:if>            
             <c:if test="${userId == null}">
                <button  style="margin-left: 80%" onclick="loginFirst()">일정 추가하기</button>
                <script type="text/javascript">
                   function loginFirst() {
                      alert('일정추가는 로그인 후 가능합니다.')
                   }
                </script>
             </c:if>
			
			<button onclick="deleteView('${dto.placeName}')">삭제</button>		
			<br><a href="../main/themeList?theme=${dto.mainCategory }">뒤로가기 </a>		

			<form action="${contextPath }/main/modifyView" method="post" enctype="multipart/form-data">
				<div class="inner" style="text-align: center">
					<h1><input type="hidden" name="placeName" value="${dto.placeName }">${dto.placeName }</h1>
					<h5><input type="hidden" name="mainCategory" value="${dto.mainCategory }">테마 : ${dto.mainCategory }</h5>								
					<span class="image main">					
					<img style="height:500px;" src="${contextPath }/main/download?mainImageFile=${dto.mainImageFile}" />
					<c:if test="${adminId != null }">
						<input type="file" name="mainImageFile" >
					</c:if>
					</span>					
					<c:choose>
						<c:when test="${adminId != null }">
							<input type="text" name="contentOne" value="${dto.contentOne }">
							<textarea rows="5" cols="7" name="contentTwo" >${dto.contentTwo }</textarea>						
							<button type="submit">수정</button><br>	<br>			
						</c:when>
						<c:otherwise>
							<p>${dto.contentOne }</p>
							<p>${dto.contentTwo }</p>			
						</c:otherwise>
					</c:choose>								
				</div>				
				</form>
						
				<div class='flex'>	
					<div class="flexA" id="map" style="width:50%;height:400px;"></div>					 
					<script>
	                        var mapContainer = document.getElementById('map');
	                        var mapOption = {
	                           center: new kakao.maps.LatLng(${dto.latitude}, ${dto.longitude}),
	                           level: 3
	                        };
	                        var map = new kakao.maps.Map(mapContainer, mapOption);
	                        var markerPosition  = new kakao.maps.LatLng(${dto.latitude}, ${dto.longitude});
	                        var marker = new kakao.maps.Marker({
	                            position: markerPosition
	                        });
	                        marker.setMap(map);
	                     </script>
	                    
					<div class="flexB">
						<h3><br>주변 맛집을 추천해주세요!</h3> 
					</div>
				</div>	
				<label>주소 :  ${dto.address }</label>
				
				
			</div>				
		<c:import url="../default/footer.jsp"></c:import>			
	</body>
</html>