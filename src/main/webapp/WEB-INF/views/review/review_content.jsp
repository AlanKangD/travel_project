<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>여행 후기 게시글</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
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
<body>
	<c:import url="../default/header.jsp" />

	<div class="wrap" align="center">
		<table border="1">
			<tr>
				<th>글번호</th>
				<td>${ contentData.review_no }</td>
			</tr>
			<tr>
				<th>작성자</th>
				<td>${ contentData.id }</td>
			</tr>
			<tr>
				<th>글제목</th>
				<td>${ contentData.review_title }</td>
				<th>작성시간</th>
				<td>${ contentData.review_date }</td>
				<th>조회수</th>
				<td>${ contentData.review_hit_num }</td>
			</tr>
			<tr>
				<th>글 내용</th>
				<td>${ contentData.review_content }</td>
			</tr>
			<tr>
				<td><button type="button">좋아요</button></td>
				<td>${ contentData.review_like }</td>
			</tr>
			<tr>
				<td>
				<c:if test="${ contentData.review_file_name != 'nan' }">
				    <img width="200px" height="150px" id="preview"
				    	src="${contextPath}/review/download?review_file_name=${contentData.review_file_name}" >
			 	</c:if>
				<c:if test="${contentData.review_file_name == 'nan' }">
					<img style="align:right;" alt="선택된 이미지가 없습니다." src="" id="preview" width="200" height="150">
				</c:if>
				</td>
			</tr>
		</table>
		<br>
		<hr>
		<br>
		<table border="1">
			<tr>
				<th>이 게시글에 달린 댓글(미구현)</th>
			</tr>
			<tr>
				<td>댓글1</td>
			</tr>
			<tr>
				<td>댓글2</td>
			</tr>
			<tr>
				<td>댓글3</td>
			</tr>
		</table>
		<input type="button" value="modify" onclick="location.href='${contextPath}/review/review_modify?review_no=${contentData.review_no }'">
		<input type="button" value="목록으로" onclick="location.href='${contextPath}/review/review_boardList'">

	</div>
	

	<c:import url="../default/footer.jsp" />
</body>
</html>