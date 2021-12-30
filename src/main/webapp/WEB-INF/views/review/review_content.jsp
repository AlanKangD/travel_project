<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% pageContext.setAttribute("replaceChar", "\n"); %> 
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${contextPath }/assets/css/main.css" />
<style type="text/css">
.review_content_title {
	width: 100%;
	height: 80px;
	float: left;
	margin-top: 20px;
	margin-bottom: 0px;
}
.review_content_set {
	width: 100%;
	margin-bottom: 10px;
}
.review_content_id {
	width: 30%;
	float: left;
	margin-bottom: 10px;
}
.review_content_details {
	width: 70%;
	float: right;
	margin-bottom: 10px;
}
.review_content_writing {
	width: 100%;
	float: left;
}
.review_like_default {
	position: absolute;
 	left: 50%;
  	transform: translateX(-50%);
}
.review_like_default_num {
	position: absolute;
 	left: 55%;
  	transform: translateX(-50%);
}
.review_like_set {
	position: absolute;
 	left: 50%;
  	transform: translateX(-50%);
}
.review_content_block {
	margin-top: 150px;
	margin-bottom: 150px;
}
.like_btn img {
	transition: all 0.2s linear;
}
.like_btn:hover img{
	transform: scale(1.4);
}
</style>
<meta charset="UTF-8">
<title>리뷰 게시글</title>
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

	// 댓글 수정 함수
	function replyUpdate(r_reply_no, writeDate, id, r_reply_content) {
		console.log(r_reply_no);
		console.log(writeDate);
		console.log(id);
		console.log(r_reply_content);
		var htmls = "";
		
		htmls += '<div align="left" id="nid' + r_reply_no + '">';
		htmls += '<b>작성자</b> ' + id + '&emsp;';
		htmls += '<b>작성일</b> ' + writeDate + '<br>';
		htmls += '<textarea name="editContent" id="editContent" row="5" cols="30">' + r_reply_content + '</textarea><br>';
		htmls += '<a href="#" onclick="replyUpdateSave(' + r_reply_no + ', \'' + id + '\')">저장</a>';
		htmls += '&emsp; &emsp;'
		htmls += '<a href="#" onclick="replyData()">취소</a>';
		htmls += '<hr>'
		htmls += '</div>';
		$('#rid' + r_reply_no).replaceWith(htmls);
		$('#rid' + r_reply_no + '#editContent').focus();
	}
	
	// 댓글 수정을 저장하는 함수
	function replyUpdateSave(r_reply_no, id) {
		var replyEditContent = $('#editContent').val();
		var paramData = JSON.stringify({"content":replyEditContent,"rid":r_reply_no});
		console.log('replyUpdateSave 실행')
		$.ajax({
			url : "updateReply",
			type : "POST",
			dataType : "json",
			data : paramData,
			contentType : "application/json;charset=utf-8",
			success : function(data) {
				alert("댓글이 성공적으로 수정되었습니다.");
				replyData();
			},
			error : function() {
				console.log();
				alert("문제 발생!")
			}
		});
	}
	
	// 댓글 삭제 함수
	function replyDelete(r_reply_no) {
		console.log(r_reply_no)
		var deletePrint = confirm("정말 삭제하시겠습니까?");
		if(deletePrint == true) {
			var paramData = JSON.stringify({"rid":r_reply_no});
			$.ajax({
				url : "deleteReply",
				type : "POST",
				dataType : "json",
				data : paramData,
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					alert('삭제되었습니다.');
					replyData();
				},
				error : function() {
					alert('문제 발생')
				}
			})
		} else {
			return false;
		}
	}
	
	// 댓글 작성 함수
   	function replyAdd() {
		console.log('replyAdd 실행')
		let form = {};
		let arr = $("#frm").serializeArray()
		for (i = 0; i < arr.length; i++) {
			form[arr[i].name] = arr[i].value;
		}
		console.log('반복문 실행')
		$.ajax({
			url : "replyAdd",
			type : "POST",
			dataType : "json",
			data : JSON.stringify(form),
			contentType : "application/json;charset=utf-8",
			success : function(data) {
				alert("성공적으로 댓글이 달렸습니다.");
				$("#repId").val("")
				$("#repContent").val("")
				location.reload();
				replyData();
			},
			error : function() {
				console.log();
				alert("문제 발생!")
			}
		});
	}
   	
   	// 댓글 목록 함수
	function replyData(){
	   var sessId = '<%=(String)session.getAttribute("userId")%>';
	   var rid = ${contentData.review_no};
	      $.ajax({
	         url:"replyData/"+${contentData.review_no}, type:"GET", 
	         dataType:"json",
	         success: function(rep){
	            var htmls = ""
	            if(rep.length < 1) {
	            	htmls += '<div style="text-align: center">';
	            	htmls += '<b>등록된 댓글이 없습니다.</b>';
	            	htmls += '<br><hr></div>';
	            } else {
	            	// 맨 아래 <div id="reply"> 에 반복적으로 보여지는 댓글 양식
	            	rep.forEach(function(data){
	            		let tid = data.id
	            		let date = new Date(data.r_reply_date)
	 	               	let writeDate = date.getFullYear()+"."+(date.getMonth()+1)+"."
	 	               	writeDate += date.getDate()+" "+date.getHours()+":"
	 	               	writeDate += date.getMinutes()+":"+date.getSeconds();
	 	               	htmls += '<div align="left" id="rid' + data.r_reply_no + '">';
	 	               	if(sessId == data.id) {
		 	               	htmls += '<b>작성자</b> ' + data.id + '&emsp;';
	 	               	} else {
	 	               		// 현재 로그인 중인 회원과 댓글 작성자가 다르면, 그 댓글의 작성자는 <a href> 처리 되어 클릭 시 insertTag 함수로 넘어감
	 	               		htmls += '<b>작성자</b> <a href="#" onclick="insertTag(' + data.r_reply_no + ',\'' + data.id + '\')">' + data.id + '</a>&emsp;'; 
	 	               	}
	 	               	htmls += '<b>작성일</b> ' + writeDate + '<br>';
	 	               	if(data.r_reply_tag != null) {
	 	               		htmls += '<strong style="color: dodgerblue;">@' + data.r_reply_tag + '</strong>'
	 	               	}
	 	               	htmls += ' ' + data.r_reply_content;
	 	              	
	 	               	// 현재 로그인 중인 회원과 댓글의 작성자가 같을 시 수정(replyUpdate), 삭제(replyDelete) 버튼이 나타남
 						if(sessId == data.id) {
 							htmls += '<br><img src="${contextPath}/resources/img/modify.png" height="25" width="25" onclick="replyUpdate(' + data.r_reply_no + ',\'' + writeDate + '\',\'' + data.id + '\',\'' + data.r_reply_content + '\')">';
 							htmls += '&ensp;<img src="${contextPath}/resources/img/delete.png" height="25" width="25" onclick="replyDelete(' + data.r_reply_no  + ')"><br><hr></div>';
	 						/* htmls += '<br><button type="button" style="padding-top: 00px padding-bottom: 0px; padding-left: 12px; padding-right: 10px;" onclick="replyUpdate(' + data.r_reply_no + ',\'' + writeDate + '\',\'' + data.id + '\',\'' + data.r_reply_content + '\')">수정</button>';
		 	               	htmls += '&ensp;' + '<button type="button" style="padding-top: 0px; padding-bottom: 0px; padding-left: 12px; padding-right: 10px;" onclick="replyDelete(' + data.r_reply_no  + ')">삭제</button><br><hr></div>' */
 						} else {
 							htmls += '<br><hr></div>';
 						}
 	            	})
	            }
	            $("#reply").html(htmls)
	         },error:function(){
	            alert('데이터를 가져올 수 없습니다')
	         }
	      });
	}
	
	// 댓글 작성자 태그 함수
	function insertTag(r_reply_no, id) {
		var tagId = id;
		$("#tagId").val(tagId);
	}
	
	// 게시글 넘버, 현재 세션 아이디
	var review_no = ${contentData.review_no};
	var id = '<%=(String)session.getAttribute("userId")%>';

	// 좋아요 체크 함수
	function updateLike(){
		$.ajax({
			type : "POST",
			url : "updateLike",
			dataType : "json",
			data : {'review_no' : review_no, 'id' : id},
			success : function(likeCheck){
				if(likeCheck == 0){
					alert("이 게시글을 좋아합니다.");
					location.reload();
				} else if(likeCheck == 1){
					alert("좋아요를 취소하였습니다.")
					location.reload();
				}
			},
			error : function(){
				alert("통신 에러");
			}
		});
	}
	
	// 비회원 용 좋아요 버튼(로그인 폼으로 보내는 역할만 수행)
	function fakeLike(){
		alert("로그인이 필요한 서비스입니다.")
		document.location.href="javascript:loginpopup('${contextPath }/member/loginForm','loginpopup');";
	}
	
	//리뷰 삭제
	function delete_check(){
		if(confirm("리뷰를 삭제하시겠습니까?") == true){ //삭제 확인
			document.location.href="${contextPath}/review/review_delete?review_no=${contentData.review_no }"
		}else{// 삭제 취소
			return false;
		}
	}
	
	function loginpopup(url,name){
		var popHeight=290;
		var popWidth=230;
		var winHeight=document.body.clientHeight;
		var winWidth=document.body.clientWidth;
		var winX=window.screenLeft;
		var winY=window.screenTop;
		
		var popX=winX+(winWidth-popWidth)/2;
		var popY=winY+(winHeight-popHeight)/4;
		window.open(url, "pop",  "top="+popY+", left="+popX+",width="+popWidth+",height="+popHeight+", scrollbars=yes,resizable=yes");
	}
</script>
</head>
<body onload="replyData()">
	<c:import url="../default/header.jsp" />
	
	<div class="wrap" align="left" style="
	padding-right: 50px; padding-left: 50px; padding-top: 0px; margin-top: 0px;">
	
		<!-- 게시글 세부 내용 -->
		<div class="review_content_title" style="text-align: left;">
			<h1>${ contentData.review_title }</h1>
		</div>
		<div class="review_content_set">
			<div class="review_content_id">
				<strong>작성자</strong>&nbsp;${ contentData.id }
			</div>
			<div class="review_content_details" style="text-align: right;">
				<c:choose>
					<c:when test="${contentData.review_like == 0}">
						<img src="${contextPath}/resources/img/like_off.png" height="25" width="25">&nbsp;0&emsp; 
					</c:when>
					<c:otherwise>
						<img src="${contextPath}/resources/img/like_on.png" height="25" width="25">&nbsp;${contentData.review_like}&emsp; 
					</c:otherwise>
				</c:choose>
				<strong>작성일</strong>&nbsp;${ contentData.review_date } &emsp;
				<strong>조회수</strong>&nbsp;${ contentData.review_hit_num }
			</div>
		</div>

		<table border="1">
			<tr>
			</tr>
			<tr>
				<td>${fn:replace(contentData.review_content, replaceChar, "<br/>")}</td>
			</tr>
		</table>
		<div class="review_like_set">
			<c:choose>
				<c:when test="${ userId == null }">
					<div>
						<button type="button" style=""onclick="fakeLike();">좋아요 ${contentData.review_like}</button>
					</div>
				</c:when>
				<c:otherwise>
					<div>
						<button type="button" onclick="updateLike();">좋아요 ${contentData.review_like}</button>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
		
			<!-- 좋아요 -->
			<%-- <tr>
				<td>
				<c:choose>
					<c:when test="${ userId == null }">
						<div>
							<button type="button" onclick="fakeLike();">좋아요</button>
							<img src="${contextPath}/resources/img/like_on.png" height="25" width="25"> &nbsp; ${contentData.review_like}
						</div>
					</c:when>
					<c:otherwise>
						<div>
							<button type="button" onclick="updateLike();" id="like_btn" value="">좋아요</button>
							<img src="${contextPath}/resources/img/like_on.png" height="25" width="25"> &nbsp; ${contentData.review_like}
						</div>
					</c:otherwise>
				</c:choose>
				</td>
			</tr> --%>
		
		<div class="review_content_block">
		</div>
		
		<table border="1">	
			<tr>
				<td>
					<c:forEach var="photo_view" items="${photo_view }">
						<c:if test="${photo_view.original_file_name != null && photo_view.original_file_name != nan}">
							<img width="200px" height="150px" src="${contextPath }/review/download?stored_file_name=${photo_view.stored_file_name}">
						</c:if>
					</c:forEach>
				</td>
				<td>

				<td align="right">
					<c:if test="${contentData.id == userId }">
						<input type="button" value="삭제" onclick="delete_check();">
						<input type="button" value="modify" onclick="location.href='${contextPath}/review/review_modify?review_no=${contentData.review_no }'">
					</c:if>
				</td>
			</tr>
		</table>
		<div style="margin-bottom: 30px;">
			<input type="button" value="목록으로" onclick="location.href='${contextPath}/review/review_boardList'">
		</div>
		<!-- 댓글 수 -->
		<table border="1">
			<tr>
				<td style="text-align: center;"><b>이 게시글에 달린 댓글 [&nbsp;${ contentData.r_reply_count }&nbsp;]</b></td>
			</tr>
		</table>
		<!-- 댓글 목록 -->
		<div id="reply"></div>
		<!-- 댓글 입력 창 -->
		<form id="frm">
			<table border="1">
				<tr>
					<td><input type="hidden" name="write_no" value="${contentData.review_no}">
					<c:choose>
						<c:when test="${ userId == null }">
							<b>로그인 한 회원만 댓글을 작성할 수 있습니다.</b>&emsp;
							<a href="javascript:loginpopup('${contextPath }/member/loginForm','loginpopup');">로그인</a>
						</c:when>
						<c:otherwise>
							<b>댓글 작성자</b><input type="text" id="repId" name="replyId" value="${ userId }" readonly style="width: 50%;"/>
							<br>
							<b>태그<input type="text" id="tagId" name="tagId" value="" readonly  placeholder="아래 댓글에서 태그하고 싶은 회원의 닉네임을 클릭하세요."  style="width: 50%;"/></b>
							<br>
							<b>댓글 내용</b>
							<textarea id="repContent" name="replyContent" rows="1" cols="30"></textarea>
							<br>
							<button type="button" onclick='replyAdd()'>댓글 작성</button>
						</c:otherwise>
					</c:choose>
				</tr>
			</table>
		</form>
		<hr>
	</div>
	<c:import url="../default/footer.jsp" />
</body>
</html>