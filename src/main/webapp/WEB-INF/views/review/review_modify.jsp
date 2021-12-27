<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${contextPath }/assets/css/main.css" />
<meta charset="utf-8">
<title>리뷰 수정</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	var photo_count = ${photo_view.size()}; // 사진 파일 수 
	var photo_num = ${photo_view.size()}; // input과 preview id 지정을 위한 수
	
	$(function(){
		$("#photo_count").val(photo_count);
		$("#review_file").attr('name', ('review_file_') + photo_count);
		$("#review_file").attr('id', ('review_file_') + photo_count);
		photo_num++;
	})
   	function add_list(input){
		if(input != null){
			if(photo_count == 10){
				alter("사진은 최대 10장까지 첨부할 수 있습니다.")
			}else{
				var file = input.files[0]
				   
			   	var str_file = "<input type='file' id='review_file_"+photo_num+"' name='review_file_"+photo_num+"' onchange='add_list(this)'/>"
			   
			  	var str_photo = "<p><img id='review_file_name_"+(photo_num -1)+"' name='review_file_name_"+(photo_num -1)+"' style='align:right;' src='#' width='320px' height='180px'> "
				    + "<b>" + file.name + " </b> <a href='#' id='delete' onClick='photo_count--; $(this).parent().remove(); $(review_file_"+(photo_num -2)+").remove(); $(photo_count).val("+photo_count+"); '>삭제하기</a></p>"
			   	
			   	$("#photo_div").append(str_photo)
			   
			   	if(file != ''){
					var reader = new FileReader();
					reader.readAsDataURL(file);
					reader.onload = function(e){
						$("#review_file_name_"+(photo_num -2)).attr('src', e.target.result);
					}
				}
				$("#review_file_" + (photo_num -1)).attr('style', 'display:none;');
			   	photo_num++;
			  	photo_count++;
				$("#photo_count").val(photo_count);
				$("#file_div").append(str_file)
			}
		}
	}
</script>
</head>
<body>
	<jsp:include page="../default/header.jsp"></jsp:include>
	
		<h1 style="text-align:center;">여행 리뷰 수정</h1>
		
		<br>
		<div id="wrap" style="width:600px; margin: 0 auto;">
			<form method="post" action="${contextPath }/review/r_modify" enctype="multipart/form-data">
				<input type="hidden" name="review_no" value="${contentData.review_no}">
	
				<c:forEach var="photo_view" items="${photo_view }" begin="0" varStatus="status"><!-- 기존파일과 비교용 -->
					<input type="hidden" id="original_file_${status.index }" name="original_file_${status.index }" value="${photo_view.original_file_name}">
				</c:forEach>
				<c:forEach var="photo_view" items="${photo_view }" begin="0" varStatus="status"><!-- 삭제했을때 수정되는 부분 -->
					<input type="hidden" id="original_file_name_${status.index }" name="original_file_name_${status.index }" value="${photo_view.original_file_name}">
				</c:forEach>
				
		  		<b>작성자</b>	<input type="text" name="id" value="${contentData.id }" readonly>
		  		<br>
			   	<b>제목</b>  <input type="text" size="30" name="review_title" value="${contentData.review_title}">
			   	<br>
			  	<b>내용</b>  <textarea style="resize:none;" rows="20" cols="80" name="review_content">${contentData.review_content}</textarea>
			 	<br>
			  	
				<div id="photo_div">
					<h3>이미지 목록</h3>
					<c:forEach var="photo_view" items="${photo_view }" begin="0" varStatus="status">
						<c:if test="${photo_view.original_file_name != null }">
							<p>
								<img width="320px" height="180px" id="review_file_name_${status.index }" name="review_file_name_${status.index }" 
									src="${contextPath }/review/download?stored_file_name=${photo_view.stored_file_name}"> 
								<b>${photo_view.original_file_name }</b>  
								<a href="#this" id="delete" onClick="$(original_file_name_${status.index}).remove(); photo_count--; $('#photo_count').val(photo_count); $(this).parent().remove();">삭제버튼</a>
								<br>
							</p>
						</c:if>
					</c:forEach>
				</div>
				
				<div id="file_div" align="right">
					<p>
						<input type="file" id="review_file" name="review_file" onchange="$(this).attr('style', 'display:none;'); $(photo_count).val(photo_count); add_list(this);"/>
					</p>
			  	</div>
			  	
			  	<span style="font-size:15px; color: gray;">※사진은 최대 10개까지 등록이 가능합니다.</span><!-- onchange="readURL(this)" 이미지를 미리보기 할 수 있음 -->
			  	<hr>
			  	<div align="right">
				  	이미지 파일 <input type="number" id="photo_count" name="photo_count" readonly> 장
			 	</div>
			 	<hr>
			 	<div align="right">
				 	<input type="button" onclick="location.href='${contextPath}/review/review_boardList'" value="목록으로">
			 		&emsp;<input type="submit" value="수정하기">
			 	</div>
			 	
			</form>
		</div>
	<jsp:include page="../default/footer.jsp"></jsp:include>
</body>
</html>