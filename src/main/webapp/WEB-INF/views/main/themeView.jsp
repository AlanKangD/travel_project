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
         <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
   <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8c629ab5a17830f4015943a3a149a898"></script>

   
<style>
   #main {width: 80%; margin-left: 10%; margin-right: 10%;}
   .flex{display: flex;}
   .flexB{width: 50%; }
   .flexBa{background-color: aqua; text-align: center;}
   .imageFlex{margin-right: 10px;}
  .aa,  .bb{  font-size: 50px; padding-top: 200px;}
   .aa {padding-right: 10px;}
   .bb {padding-left: 10px;}
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
   
   function deleteView(placeName, mainCategory){
      console.log(placeName, mainCategory);
      $.ajax({
         url : "deleteView?placeName="+placeName,
         type : "delete",
         dataType : "json",
         success : function(data){
            console.log(data.result)
            if(data.result == true){
               alert("삭제 성공");
               location.href="${contextPath}/main/themeList?theme="+mainCategory;
            }else{
               alert("에이젝스 data result == false");
            }
         },error : function(){
            alert("에이젝스 실패 , 서버 문제 발생");
         }
      })      
   }

   function addReply(){
      let form = {}
      let arr = $("#addReply").serializeArray()
      console.log(arr)

      for(i=0;  i<arr.length; i++){
         form[arr[i].name] = arr[i].value;
      }
      console.log(form)
         $.ajax({
         url : "addReply",
         type : "post",
         dataType : "json",
         data : JSON.stringify(form),
         contentType : "application/json; charset=utf-8",
         success : function(data){
            console.log(data)
            if(data.result == true){
               alert("댓글 등록 완료 ")
               $("#repContent").val("")
               getReply();
            }else{
               alert("답변 등록 실패")
            }
         }, error : function(){
            alert("addReply 서버 문제 발생");
         }         
      })
   }
   
   function getReply(num){	  
		myVar = setInterval(setImageNext, 3000)
	   
      if(num == undefined){
         num = 1;
      }
      console.log(num);
      $.ajax({
         url : "getReply?placeName=${dto.placeName}&num="+num,
         type : "get",
         dataType : "json",
         success : function(data){
             console.log(data)
             var dataCount = data.dataCount;
                var beginPage = data.beginPage;
                var endPage = data.endPage;
                var list = data.list;
               let html = "총 "+dataCount+"개의댓글<br><table border='1'>";
            list.forEach(function(data){
               if('${userId}' != ""){
                  html += "<tr><td>"+data.id+" / "+data.saveDate + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp<a style='cursor:pointer' onclick='updateLike("+data.repNo+','+num+")'>👍🏻</a> "+data.likeHit
                  if(data.id == '${userId}' || '${adminId}' != ""){   
                      html += "&nbsp;&nbsp;&nbsp;&nbsp;<button onclick='deleteReply("+data.repNo+")'>삭제</button>"
                     }
                  html += "<br>"+data.repContent+"</td></tr>"
               }else{
               html += "<tr><td>"+data.id+" / "+data.saveDate + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp<a style='cursor:pointer' onclick='fakeLike()'>👍🏻</a> &nbsp;"+data.likeHit+"<br>"+data.repContent+"</td></tr>"   
                }
            })
            html += "<tr><td>"
            if(num > 1){
               html += "<button onclick='getReply("+(num-1)+")'>&lt;</button>"
            }
            for(pageNum = beginPage; pageNum <= endPage; pageNum++){
               if (num == pageNum) {
                  html += "<a style='cursor:pointer' onclick='getReply("+pageNum+")'>○</a>";
                    } else {
                       html += "<a style='cursor:pointer' onclick='getReply("+pageNum+")'>●</a>";
                    }
            }
            if(num < endPage){
               html += "<button onclick='getReply("+(num+1)+")'>&gt;</button>"
            }
            html += "</td></tr></table>";
         $("#reply").html(html)
      }, error : function(){
         alert("getReply 서버 문제 발생 ");
         }         
      })      
   }

   function deleteReply(repNo){
      console.log(repNo)
      $.ajax({
         url : "deleteReply?repNo="+repNo,
         type : "delete",
         dataType : "json",
         success : function(data){
            console.log(data)
            if(data.result == true){
               alert("삭제완료")
               getReply();
            }else{
               alert("data.result == false 삭제 실패")
            }
         }, error : function(){
            alert("deleteReply서버 문제 발생");
         }
      })      
   }
   
function fakeLike() {
   alert("로그인한 사용자만 추천이 가능합니다!");
}

function updateLike(repNo, num) {
   //console.log(repNo);
   //console.log('${userId}');
   console.log("num : " + num);
   $.ajax({
      url : "likeCheck?repNo="+repNo+"&id=${userId}",
      type : "post",
      dataType : "json",
      success : function(data){
         console.log(data);
         console.log(data.result);
         if(data.result == true){
            getReply(num);
         }else{
            getReply(num);
         }
      },
      error : function(){
         alert("통신 에러");
      }
   });
}
var mapSwitch = 1;
$(function(){
   $(".openMap").click(function(){
      if(mapSwitch == 1){
         $("#map").animate({ width: "150%"})
         //$(".flexB").animate({ width: "0%"})
         $(".openMap").text( "지도 줄이기" )
         mapSwitch = 0;
      }else{
         $("#map").css({ width: "50%"})
         $(".openMap").text( "지도 펼치기" )
         mapSwitch = 1;
      }
      
   })
})

function readURL(input) {
      var file = input.files[0] //파일에 대한 정보
      console.log(file)
      if (file != '') {
         var reader = new FileReader();
         reader.readAsDataURL(file); //파일의 정보를 토대로 파일을 읽고 
         reader.onload = function (e) { // 파일 로드한 값을 표현한다
          //e : 이벤트 안에 result값이 파일의 정보를 가지고 있다.
           $('#preview').attr('src', e.target.result);
          }
      }
  }
  
var i = 0;
function setImageNext(){	  
	var date = new Date()
	document.getElementById('preview').innerHTML = date.toLocaleString()
	if(i == 2){
		i = 0;	
	}else{
	  i = i + 1;
	}  
	  if(i == 0){
		  document.getElementById("preview").src="${contextPath }/main/download?imageFile=${dto.mainImageFile}"
		  console.log("다음 i값 : " +i)			  
	  }else if(i == 1){
		  document.getElementById("preview").src="${contextPath }/main/download?imageFile=${dto.imageFile1}"
		  console.log("다음 i값 : " +i);  
	  }else if(i == 2){
		  document.getElementById("preview").src="${contextPath }/main/download?imageFile=${dto.imageFile2}"
		  console.log("다음 i값 : " +i)
	  }	  
}

  function setImageBefore(){
	  if(i == 0){
			i = 2;	
		}else{
		  i = i - 1;
		}  
		  if(i == 0){
			  document.getElementById("preview").src="${contextPath }/main/download?imageFile=${dto.mainImageFile}"
			  console.log("다음 i값 : " +i)			  
		  }else if(i == 1){
			  document.getElementById("preview").src="${contextPath }/main/download?imageFile=${dto.imageFile1}"
			  console.log("다음 i값 : " +i);  
		  }else if(i == 2){
			  document.getElementById("preview").src="${contextPath }/main/download?imageFile=${dto.imageFile2}"
			  console.log("다음 i값 : " +i)
		  }	  
  }
  
  function start(){
      myVar = setInterval(setImageNext, 3000);
   }
  function stop(){
	    clearInterval(myVar);
   }
</script>
</head>

<body onload="getReply()">
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
         
         <c:if test="${adminId != null }">
  	       <button onclick="deleteView('${dto.placeName}' , '${dto.mainCategory }')">삭제</button>     
         </c:if>
          
         <br><a href="../main/themeList?theme=${dto.mainCategory }">뒤로가기 </a>      

         <form action="${contextPath }/main/modifyView" method="post" enctype="multipart/form-data">
            <div class="inner" style="text-align: center">
               <h1><input type="hidden" name="placeName" value="${dto.placeName }">${dto.placeName }</h1>
               <h5><input type="hidden" name="mainCategory" value="${dto.mainCategory }">테마 : ${dto.mainCategory }</h5>                        
               <span class="image main">                             		
	               <input type="hidden" name="originImageFile" value="${dto.mainImageFile }">	                    
	               
	              <div class="mainbtn" style="display:flex;">                
	                   <div class="aa"><a onmouseout="start()" onmouseover="stop()"  onclick="setImageBefore()" style="cursor: pointer;"> &lt; </a>  </div>     
		               <div><img onmouseout="start()" onmouseover="stop()" id="preview" style="height:500px;" src="${contextPath }/main/download?imageFile=${dto.mainImageFile}" /></div>                                                   
		               <div class="bb"><a onmouseout="start()" onmouseover="stop()" onclick="setImageNext()" style="cursor: pointer;"> &gt;</a></div>
	               </div>
	               
	               <c:if test="${adminId != null }">
	                  <input type="file" name="mainImageFile" onchange="readURL(this)" >
	               </c:if>
               </span>  
         
               <br>             
               <c:choose>
                  <c:when test="${adminId != null }">
                     <input type="text" name="contentOne" value="${dto.contentOne }">
                     <textarea rows="5" cols="7" name="contentTwo" >${dto.contentTwo }</textarea>                  
                     <button type="submit">수정</button><br>   <br>         
                  </c:when>
                  <c:otherwise>
                     <p>${dto.contentOne }</p>
                     <p>${dto.contentTwo }</p>         
                  </c:otherwise>
               </c:choose>                         
            </div>            
            </form>
                  
            <div class='flex'>   
               <div class="flexA" id="map" style="width:50%;height:500px;"></div>                
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
                  <div  class="flexBa">
                     주변 맛집을 추천해주세요!
                  </div>                  
                  <div style="background-color: yellow">
                     <c:if test="${userId != null || adminId != null  }">
                     작성자 : ${userId }
                     <form id="addReply">
                        <input type="hidden" name="id" value="${userId }">   
                        <input type="hidden" name="placeName" value="${dto.placeName }">   
                        <input  style="background-color: white;" type="text" name="repContent"  id="repContent" placeholder="(맛집을 추천해주세요!)">                                                            
                        <button type="button" onclick="addReply()">등록</button>
                     </form>
                     </c:if>
                     <div id = "reply"></div>
                  </div>
               </div>
            </div>   
            <label>주소 :  ${dto.address }</label> <button class="openMap">지도 펼치기</button>
            
         </div>            
      <c:import url="../default/footer.jsp"></c:import>         
   </body>
</html>