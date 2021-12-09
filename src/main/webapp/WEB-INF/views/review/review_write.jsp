<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    <c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	var photo_count = 0;
	var preview_list = [];
	var review_file_list = "";
	
    
	
	/* $(document).ready(function(){
		$("#photo_delete").on("click",function(e){
			e.preventDefault();
			preview_delete(document.getElment)
			photo_delete($(this))
		});
		
		$("input[type=file]").change(function () {
			var fileInput = document.getElementById("review_file_name_0");
			
			var files = fileInput.files;
			
            var file;
            
            console.log(files);
            for (var i = 0; i < files.length; i++) {
                file = files[i];
                alert(file.name);
                console.log(files);
            }
        });
		
	}); */

	
	function readURL(input) {
		var file = input.files[0] //파일에 대한 정보
	    console.log(file.name)
	    if (file != '') {
         var reader = new FileReader();
         reader.readAsDataURL(file); //파일의 정보를 토대로 파일을 읽고 
         reader.onload = function (e) { // 파일 로드한 값을 표현한다
          //e : 이벤트 안에 result값이 파일의 정보를 가지고 있다.
           $('#preview').attr('src', e.target.result); //target은 실질적인 이미지의 경로이다
          }
      }
	    
	/* if(preview_list.length <= 5){
		if (file != '') {
			var reader = new FileReader();
			reader.readAsDataURL(file); //파일의 정보를 토대로 파일을 읽고 
			reader.onload = function (e) {// 파일 로드한 값을 표현한다
				//e : 이벤트 안에 result값이 파일의 정보를 가지고 있다.
				var preview_path = e.target.result;
				//<input type='file' name='review_file_name_"+(photo_count)+"' id='review_file_name_"+(photo_count)+"' onchange='readURL(this)'/>
				var str_preview = 
					"<span style='margin:2px;'><img style='align:right;' alt='선택된 이미지가 없습니다.' src='"+(preview_path)+"' id='preview_"+(photo_count++)+"' width='160' height='90'></span>"
				var str_file =
				    "<p><b id='review_file_name_"+(photo_count)+"' name='review_file_name_"+(photo_count)+"' value=''>" + file.name +"</b><a  href='#this' id='delete_btn_"+(photo_count)+"' onclick=' $(review_file_name_"+(photo_count)+").remove(); $(delete_btn_"+(photo_count)+").remove(); $(preview_"+ (photo_count)+").remove();' class='btn'>삭제하기</a></p>";	
				$("#photo_div").append(str_file);
				$("#preview_div").append(str_preview);
				push_list(file.name)
				//console.log(preview_list) //배열에 잘 추가되고 있음
				
				review_file_list += (file.name + "/")
				
				document.getElementById("review_file_list").value = review_file_list	
					
				console.log(review_file_list)
				console.log(review_file_list[0])
				
			}
		}
		
	}else{
			alert("사진을 최대로 등록하셨습니다.")
	}
	
    function push_list(file_name){
		preview_list.push(file_name);
		//review_file_list.push(file_name);
	} */
    
    
}	    	

	/* function preview_add(input){
		var file = input.files[0]
		var str_file1 =
	    	  "<p><input type='file' name='review_file_name_"+(photo_count)+"' onchange='preview_add(input)'/><a href='#this' id='photo_delete' class='btn'>삭제하기</a></p>";
		var str_preview1 = 
			"<span><img style='align:right;' alt='선택된 이미지가 없습니다.' src='#' id='preview_"+(photo_count++)+"' width='160' height='90'></span>"
		if(photo_count < 11){
			if (file != '') {
				var reader = new FileReader();
				reader.readAsDataURL(file); //파일의 정보를 토대로 파일을 읽고 
				reader.onload = function (e) { // 파일 로드한 값을 표현한다
					//e : 이벤트 안에 result값이 파일의 정보를 가지고 있다.
					$("#preview_div").append(str_preview1);
					$("#photo_div").append(str_file1);
				} 
			}
		}else{
			alert("사진을 최대로 등록하셨습니다.")
		}
	} */
	      /* for(; photo_count < 11 ; photo_count++){
	    	  if(file != ''){
	    		  var reader = new FileReader();
	    		  reader.readAsDataURL(file);
	    		  reader.onload = function(e){
	    			  $("#photo_div").append(str);
	    			  $('#preview_"(photo_count)"').att('src',e.target.result);
	    		  }
	    	  }
	      } */

	
</script>
</head>
<body>review_write.jsp<br>
	<jsp:include page="../default/header.jsp"></jsp:include>
		<div id="wrap" style="width:600px; margin: 0 auto;">
			<h1 style="text-align:center;">review write form</h1><br>
			<form method="post" action="${contextPath }/review/r_writeSave" enctype="multipart/form-data">
				<b>작성자 : </b>	<input type="text" name="id" value="soomin" readonly />
				<hr>
				<b>제 목 : </b>	<input type="text" name="review_title" size="30" placeholder="제목을 입력해 주세요.">
				<hr>
				<b>내 용 : </b><br> 
				<textarea style="resize:none;" rows="20" cols="80" placeholder="내용을 입력해 주세요." name="review_content"></textarea>
				<hr>
				
				<div id="preview_div">
      				<img id="preview" src="#" width=320 height=180 alt="선택된 이미지가 없습니다" />	
				</div>
				<div id="photo_div">
					<p>
					<input type="file" name="review_file_name" onchange="readURL(this)"><!-- onchange="readURL(this)" 이미지를 미리보기 할 수 있음 -->
					</p>
				</div>
				<hr>
				
				<div align="right">
					<p>
					<input type="submit" value="저장" >
					<input type="button" value="목록보기" onClick="location.href='${contextPath}/review/review_boardList'">
					</p>
				</div>
			</form>
		</div>
	<jsp:include page="../default/footer.jsp"></jsp:include>

</body>
</html>