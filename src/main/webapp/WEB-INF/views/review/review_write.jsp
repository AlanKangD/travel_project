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
	var photo_count = 1; // 사진 파일 수 
<<<<<<< HEAD
	var photo_num = 1; // input, preview의 id 부여하기 위한 수
	
	function load_preview_0(input){//대표이미지 프리뷰 로드하는 함수
		var file = input.files[0]
=======
	var photo_num = 1; // input 변수 지정하기 위한 수
	
	function load_preview_0(input){//대표이미지 프리뷰 로드
		
		var file = input.files[0]
		
>>>>>>> master
	      if (file != '') {
	         var reader = new FileReader();
	         reader.readAsDataURL(file);
	         reader.onload = function (e) {
<<<<<<< HEAD
	           $('#preview_0').attr('src', e.target.result); 
=======
	           $('#preview_0').attr('src', e.target.result);
>>>>>>> master
	         }
	      }
	}
	function add_file(){//사진을 추가할 수 있는 input과 preview를 생성하는 기능
		if(photo_count == 10){
			alter("사진은 최대 10장까지 첨부할 수 있습니다.")
		}else{
			var str_photo = "<p><input type='file' name='review_file_name_"+(photo_num)+"' id='review_file_name_"+(photo_num)+"' onchange='load_preview(this); '/>"
				+ "<a href='#this' onClick='$(this).parent().remove(); photo_count--; $(span_"+photo_num+").remove(); ' class='btn'>삭제하기</a></p>"
<<<<<<< HEAD
			var str_preview = "<span id='span_"+photo_num+"' style='margin:2px;'>"
			+ "<img id='preview_"+ photo_num +"' style='align:right;' alt='이미지가 없습니다.' src='#'  width='160' height='90'></span>"
			
			$("#photo_div").append(str_photo);
			$("#preview_div").append(str_preview); 
			photo_num++; 
			photo_count++; 
			$("#photo_count").val(photo_count);
		}
	}
	function load_preview(input){//추가한 preview span에 이미지를 추가하는 기능
		var file1 = input.files[0] //파일에 대한 정보
=======
			var str_preview = "<span id='span_"+photo_num+"' style='margin:2px;'><img id='preview_"+ photo_num +"' style='align:right;' alt='이미지가 없습니다.' src='#'  width='160' height='90'></span>"
			$("#photo_div").append(str_photo);
			$("#preview_div").append(str_preview);
			photo_num++;
			photo_count++;
			$("#photo_count").val(photo_count);
		}
	}
	
	function load_preview(input){
		var file1 = input.files[0]
		
>>>>>>> master
		if(file1 != ''){
			var reader = new FileReader();
			reader.readAsDataURL(file1);
			reader.onload = function(e){
				$("#preview_"+(photo_num -1)).attr('src', e.target.result);
			}
		}
	}
</script>
</head>
<body>review_write.jsp<br>
	<c:import url="../default/header.jsp"></c:import>
		<div id="wrap" style="width:600px; margin: 0 auto;">
			<h1 style="text-align:center;">review write form</h1><br>
			<form method="post" action="${contextPath }/review/r_writeSave" enctype="multipart/form-data">
				<b>작성자 : </b>	<input type="text" name="id" value="${ userId }" readonly>
				<hr>
				<b>제 목 : </b>	<input type="text" name="review_title" size="30" placeholder="제목을 입력해 주세요.">
				<hr>
				<b>내 용 : </b><br> 
				<textarea style="resize:none;" rows="40" cols="80" placeholder="내용을 입력해 주세요." name="review_content"></textarea>
				<hr>
				
				<div id="preview_div">
      				<img id="preview_0" name="preview_0" src="#" width=320 height=180 alt="대표이미지가 없습니다." />
				</div>
				
				<div id="photo_div">
					<p>
						<b>대표이미지</b>
						<input type="file" id="review_file_name_0" name="review_file_name_0" onchange="load_preview_0(this);"/>
						<span style="font-size:15px; color: gray;">※사진은 최대 10개까지 등록이 가능합니다.</span><!-- onchange="readURL(this)" 이미지를 미리보기 할 수 있음 -->
					</p>
				</div>
				
				<hr>
				
				<div align="right">
					<p>
					이미지 파일 <input type="number" id="photo_count"  name="photo_count" readonly> 장
					<input type="button" value="사진추가" onClick="add_file();">
					<input type="submit" value="저장" />
					<input type="button" value="목록보기" onClick="location.href='${contextPath}/review/review_boardList'"/>
					</p>
				</div>
			</form>
		</div>
	<jsp:include page="../default/footer.jsp"></jsp:include>
</body>
</html>