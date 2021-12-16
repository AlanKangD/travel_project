<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset='utf-8' />
    <link href='/resources/fullcalendar/main.css' rel='stylesheet' />
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src='/resources/fullcalendar/main.js'></script>
    <script>
	$(document).ready(function() {
        var calendarEl = document.getElementById('calendar');
        var calendar = new FullCalendar.Calendar(calendarEl, {
          initialView: 'dayGridMonth'
        });
        calendar.render();
      });

    </script>
  </head>
  <body>
    <div id='calendar'></div>
  </body>
</html>