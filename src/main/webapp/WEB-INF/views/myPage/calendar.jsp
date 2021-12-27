<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset='utf-8' />
<link href='${contextPath }/resources/fullcalendar/main.css' rel='stylesheet' />
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<script src='${contextPath }/resources/fullcalendar/main.js'></script>
<script src='${contextPath }/resources/fullcalendar/ko.js'></script>


<style type="text/css">
	.fc-event {
		margin-top:5px;
		cursor:move
	}
</style>
<script>
	var Calendar = null;
    $(document).ready(function() {
        var Calendar = FullCalendar.Calendar;
        var Draggable = FullCalendar.Draggable;

        var containerEl = document.getElementById('external-events');
        var calendarEl = document.getElementById('calendar');
        var checkbox = document.getElementById('drop-remove');

   	 	
        // initialize the external events
        // -----------------------------------------------------------------

        new Draggable(containerEl, {
          itemSelector: '.fc-event',
          eventData: function(eventEl) {
            return {
              title: eventEl.innerText
            };
          }
        });

        // initialize the calendar
        // -----------------------------------------------------------------

       calendar = new Calendar(calendarEl, { //이곳의 객체를 사용하기 위해 맨 상단에 전역 변수로 만들어 줘야합니다 
          headerToolbar: {
            left: 'prev,next today',
            center: 'title',
            right: 'dayGridMonth,timeGridWeek,timeGridDay'
          },
          editable: true,  //수정가능여부
          droppable: true, // this allows things to be dropped onto the calendar
          drop: function(info) {
            // is the "remove after drop" checkbox checked?
            if (!checkbox.checked) {
              // if so, remove the element from the "Draggable Events" list
              info.draggedEl.parentNode.removeChild(info.draggedEl);
            }
          },
          locale: 'ko',
          events: [
        	  $.ajax({
        		  url : "getMyCal?id=${userId}",
        		  type : "GET",
        		  dataType : "json",
        		  data : {},
        		  success : function(data) {
        			 
        			  console.log(data[0].title);
        			  for(var i=0; i<data.length; i++) {
        				  calendar.addEvent ({
        					  title : data[i].title,
        					  start: data[i].start,
        					  end: data[i].end
        				  })
        			  }
        			  //calendar.addevent ({})
        		  }, 
        		  errer : function(){
        			  
        		  }
        		  
        	  })
        	  
        	  /*
        	    { // this object will be "parsed" into an Event Object
        	      title: 'The Title', // 제목
        	      start: '2021-12-01', // 시작일자
        	      end: '2021-12-02' // 종료일자
        	    },
        	    {
        	        title: 'The Title', // 제목
        	        start: '2021-12-03', // 시작일자
        	        end: '2018-12-04' // 종료일자
        	      },
        	      { 
        	        title: 'The Title', // 제목
        	        start: '2021-12-05', // 시작일자
        	        end: '2021-12-06' // 종료일자
        	      }
        	  */

        	  ]

        });

        calendar.render();
      });
    //1. 전체 데이터를 추출하는 작업 2. ajax로 서버에 전송하여 DB에 저장하는 작업
   function allSave() {
    	
	 //calendar.getEvents() 모든 데이터를 가져오는 함수 입니다.
   	//calendar.getEventById( id ) 해당 아이디의 id값만 추출하는 함수입니다. 
   	var allEvent = calendar.getEvents(); //array
	 //console 창에서 allDay : ture 이면 하루종일의 일정을 뜻하며 하루에서 따로 지정한 값이면 
	 // allDay : false 입니다.
	 //instance 의 정보에서 start와 end정보를 알아야합니다.
	 console.log(allEvent);

	 $.ajax({
		 url : "saveData?id=${userId}",
		 type : "POST",
		 dataType : "json",
		 data : {
			 data : JSON.stringify(allEvent)
		 },
		 traditional: true,
		 success : function(data) {
			 console.log(data);
			alert("저장 완료!!")
		 },
		 errer : function() {
			 alert("서버 문제 발생!")
		 }
		 
	 })
	 
		
    }
   function allDelete() {
    	
	 //calendar.getEvents() 모든 데이터를 가져오는 함수 입니다.
   	//calendar.getEventById( id ) 해당 아이디의 id값만 추출하는 함수입니다. 
   	var allEvent = calendar.getEvents(); //array
	 //console 창에서 allDay : ture 이면 하루종일의 일정을 뜻하며 하루에서 따로 지정한 값이면 
	 // allDay : false 입니다.
	 //instance 의 정보에서 start와 end정보를 알아야합니다.
	 console.log(allEvent);

	 $.ajax({
		 url : "allDelete?id=${userId}",
		 type : "GET",
		 dataType : "json",
		 data : {
			 data : JSON.stringify(allEvent)
		 },
		 traditional: true,
		 success : function(data) {
			alert("삭제 되셨습니다.");
			location.reload();
		 },
		 errer : function() {
			 alert("서버 문제 발생!");
		 }
		 
	 })
	 
		
    }


</script>
</head>
<body>

	<div id='external-events' style="float:left; width:15%; padding-rigth:30px; padding-left:20px; margin-top:100px; ">
	
		<p>
			<strong>일정들을 드래그하여 배정하세요</strong>
		</p>
		
		<c:forEach var="list" items="${myList }">
			<div
			class='fc-event fc-h-event fc-daygrid-event fc-daygrid-block-event'>
			<div class='fc-event-main'>${list.place }</div>
		</div>
		</c:forEach>
		

		<p>
			<input type='checkbox' id='drop-remove' /> 
			<label for='drop-remove'>체크 하면 안없어짐</label>
		</p>
		<button style="width:120px; height:40px; vertical-align:middle; 
						font-size:17px; cursor:pointer" onclick="javascript:allSave();">전체 저장</button>
		<button style="width:120px; height:40px; vertical-align:middle; 
						font-size:17px; cursor:pointer" onclick="javascript:allDelete();">전체 삭제</button>
		
	</div>
		
<div style="float:left; width:80%">
	<div id='calendar'></div>
</div>
</body>
</html>