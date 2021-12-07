<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
   function readURL(input) {
      var file = input.files[0] //파일에 대한 정보
      console.log(file)
      if (file != '') {
         var reader = new FileReader();
         reader.readAsDataURL(file); //파일의 정보를 토대로 파일을 읽고 
         reader.onload = function (e) { // 파일 로드한 값을 표현한다
          //e : 이벤트 안에 result값이 파일의 정보를 가지고 있다.
           $('#preview').attr('src', e.target.result); //target은 실질적인 이미지의 경로이다
          }
      }
  }  
</script>
</head>
<body>review_modify.jsp<br>
	<jsp:include page="../default/header.jsp"></jsp:include>
		<h1 style="text-align:center;">review modify</h1>
		<br>
		<div id="wrap" style="width:600px; margin: 0 auto;">
			<form action="${contextPath}/review/modify" enctype="multipart/form-data" method="post" >
				<input type="hidden" name="review_no" value="${contentData.review_no}"><!--  -->
		  		<input type="hidden" name="originFileName" value="${contentData.review_file_name}">
		  		<!-- 작성자 부분 나중에 수정해야함 -->
		  		<b>작성자 : </b>	<input type="text" name="id" value="${contentData.id }" readonly><hr>
			   	<b>제 목 : </b>  <input type="text" size="30" name="title" value="${contentData.review_title}"><hr>
			  	<b>내 용 : </b>   <textarea style="resize:none;" rows="20" cols="80" name="content">${contentData.review_content}</textarea>
			 	<hr>
			    <c:if test="${ contentData.review_file_name != 'nan' }">
				    <img width="200px" height="150px" id="preview"
				    	src="${contextPath}/review/download?imageFileName=${contentData.review_file_name}">
			 	</c:if>
			 	<img style="align:right;" alt="선택된 이미지가 없습니다." src="#" id="preview" width="200" height="150">
			  	<input type="file" name="review_file_name" onchange="readURL(this)">
			  	<hr>
			  	<div align="right">
			  	<input type="submit" value="수정하기">
			 	<input type="button" onclick="location.href='${contextPath}/review/review_boardList'" value="목록으로">
			 	</div>
			</form>
		</div>
	<jsp:include page="../default/footer.jsp"></jsp:include>
</body>
</html>