<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Success Page</title>
  </head>
  <body>
    <h1>Successfully Added Event:</h1>    
    <table>
      <tr>
        <th style = "width: 250px">Summary</th>
      </tr>
      
      <tr> 
      	<td>&nbsp;</td>
      </tr>
      
      <tr>
        <td>Event Title</td>
        <td>${param.eventTitle}</td>
      </tr>
      <tr>
        <td>Start Time</td>
        <td>${param.startTime}</td>
      </tr>
      <tr>
        <td>End Time</td>
        <td>${param.endTime}</td>
      </tr>
      <tr>
        <td>Start Date</td>
        <td>${param.startDate}</td>
      </tr>
      <tr>
        <td>End Date</td>
        <td>${param.endDate}</td>
      </tr>
      <tr>
        <td></td>
      </tr>
    </table>
    
    <br>
    
    <div id="returnToCalendar">
    	<button onclick="window.location.href='ProfilePage.jsp'" style="border: black 1px solid;" >Return to Calendar</button>
    	
	</div>
    
  </body>
</html>