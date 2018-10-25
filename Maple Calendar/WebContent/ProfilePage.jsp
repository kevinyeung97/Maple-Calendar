<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Profile Page</title>
		<link rel="stylesheet" type="text/css" href="style.css">
	</head>
	
	<body>
	
	<script type="text/javascript">
      // Client ID and API key from the Developer Console
      var CLIENT_ID = '806680427871-1p9ln591dk7s3s7725i4haubbdt1bun4.apps.googleusercontent.com';
      var API_KEY = 'AIzaSyC3JmwyHMkB8L930I_RBwFEwhJj75kBvOQ';

      // Array of API discovery doc URLs for APIs used by the quickstart
      var DISCOVERY_DOCS = ["https://www.googleapis.com/discovery/v1/apis/calendar/v3/rest"];

      // Authorization scopes required by the API; multiple scopes can be
      // included, separated by spaces.
      var SCOPES = "https://www.googleapis.com/auth/calendar";

							/*       var authorizeButton = document.getElementById('authorize_button');
							      var signoutButton = document.getElementById('signout_button'); */

      /**
       *  On load, called to load the auth2 library and API client library.
       */
      function handleClientLoad() {
        gapi.load('client:auth2', initClient);
      }

      /**
       *  Initializes the API client library and sets up sign-in state
       *  listeners.
       */
      function initClient() {
        gapi.client.init({
          apiKey: API_KEY,
          clientId: CLIENT_ID,
          discoveryDocs: DISCOVERY_DOCS,
          scope: SCOPES
        }).then(function () {
          // Listen for sign-in state changes.
          gapi.auth2.getAuthInstance().isSignedIn.listen(updateSigninStatus);

          // Handle the initial sign-in state.
          updateSigninStatus(gapi.auth2.getAuthInstance().isSignedIn.get());
									/*           authorizeButton.onclick = handleAuthClick;
									          signoutButton.onclick = handleSignoutClick; */
        });
      }

      /**
       *  Called when the signed in status changes, to update the UI
       *  appropriately. After a sign-in, the API is called.
       */
      function updateSigninStatus(isSignedIn) {
        if (isSignedIn) {
										/*           authorizeButton.style.display = 'none';
										          signoutButton.style.display = 'block'; */
          listUpcomingEvents();
		} 
        										/* else {
										          authorizeButton.style.display = 'block';
										          signoutButton.style.display = 'none';
										        } */
      }

      /**
       *  Sign in the user upon button click.
       */
      function handleAuthClick(event) {
        gapi.auth2.getAuthInstance().signIn();
      }

      /**
       *  Sign out the user upon button click.
       */
      function handleSignoutClick(event) {
        gapi.auth2.getAuthInstance().signOut();
      }

      /**
       * Append a pre element to the body containing the given message
       * as its text node. Used to display the results of the API call.
       *
       * @param {string} message Text to be placed in pre element.
       */
						      function appendPre(message) {
						        var pre = document.getElementById('content');
						        var textContent = document.createTextNode(message + '\n');
						        pre.appendChild(textContent);
						      } 

      /**
       * Print the summary and start datetime/date of the next ten events in
       * the authorized user's calendar. If no events are found an
       * appropriate message is printed.
       */
      function listUpcomingEvents() {
        gapi.client.calendar.events.list({
          'calendarId': 'primary',
          'timeMin': (new Date()).toISOString(),
          'showDeleted': false,
          'singleEvents': true,
          'maxResults': 9999,
          'orderBy': 'startTime'
        }).then(function(response) {
          var events = response.result.items;
          
          
			var str = '<p> <span id="headerDate">Date</span> <span id="headerTime">Time</span> <span id="headerES">Event Summary</span></p>';
			DateTimeEventSum.insertAdjacentHTML( 'afterbegin', str );
			
			
          
			var i;
			for(i = 0; i < events.length; i++){

				console.log(events[i]["start"]["dateTime"]);
				
				var dateTime = events[i]['start']['dateTime'];
				
				var eventTitle = events[i]["summary"];
				var year = dateTime.slice(0,4);
				var month = dateTime.slice(5,7);
				if(month == '01'){
					month = 'January';
				}
				if(month == '02'){
					month = 'February';
				}
				if(month == '03'){
					month = 'March';
				}
				if(month == '04'){
					month = 'April';
				}
				if(month == '05'){
					month = 'May';
				}
				if(month == '06'){
					month = 'June';
				}
				if(month == '07'){
					month = 'July';
				}
				if(month == '08'){
					month = 'August';
				}
				if(month == '09'){
					month = 'September';
				}
				if(month == '10'){
					month = 'October';
				}
				if(month == '11'){
					month = 'November';
				}
				if(month == '12'){
					month = 'December';
				}
				var day = dateTime.slice(8,10);
				var finishedDate = month + ' ' + day + ', ' + year;
				
									console.log("finishedDate: " + finishedDate);
				
				
				var time = dateTime.slice(11,16);
					time += ' AM'

				var hour = time.slice(0,2)	
				if(hour == '12'){
					time = time.replace('AM', 'PM');
				}	
				if(hour == '13'){
					time = time.replace('13','1');
					time = time.replace('AM', 'PM');
				}
				if(hour == '14'){
					time = time.replace('14','2');
					time = time.replace('AM', 'PM');
				}
				if(hour == '15'){
					time = time.replace('15','3');
					time = time.replace('AM', 'PM');
				}
				if(hour == '16'){
					time = time.replace('16','4');
					time = time.replace('AM', 'PM');
				}
				if(hour == '17'){
					time = time.replace('17','5');
					time = time.replace('AM', 'PM');
				}
				if(hour == '18'){
					time = time.replace('18','6');
					time = time.replace('AM', 'PM');
				}
				if(hour == '19'){
					time = time.replace('19','7');
					time = time.replace('AM', 'PM');
				}
				if(hour == '20'){
					time = time.replace('20','8');
					time = time.replace('AM', 'PM');
				}
				if(hour == '21'){
					time = time.replace('21','9');
					time = time.replace('AM', 'PM');
				}
				if(hour == '22'){
					time = time.replace('22','10');
					time = time.replace('AM', 'PM');
				}
				if(hour == '23'){
					time = time.replace('23','11');
					time = time.replace('AM', 'PM');
				}
				if(hour == '00'){
					time = time.replace('00', '12');
				}
										console.log('time: ' + time);
				
				

				//events array is fully modified at this point, 
				//the code underneath is for printing out the table in proper format,
				//while using the modified data in events array
				

				/* Creating the actual table */
				var event = document.createElement("div");
				event.className="cssEvent"
				
				var divDate = document.createElement("div");
        		divDate.className="cssDivDate";
				var divDate2 = document.createTextNode(finishedDate);
				divDate.appendChild(divDate2);
				
				var divTime = document.createElement("div");
        		divTime.className="cssDivTime";
				var divTime2 = document.createTextNode(time);
				divTime.appendChild(divTime2);	
				
				var divEventTitle = document.createElement("div");
				divEventTitle.className="cssDivEventTitle";
				var divEventTitle2 = document.createTextNode(eventTitle);
				divEventTitle.appendChild(divEventTitle2);
				
				var j;
				for(j = 0; j < 3; j++){
					event.appendChild(divDate);
					event.appendChild(divTime);
					event.appendChild(divEventTitle);
					
				}
				
				DateTimeEventSum.appendChild(event);
				
				
			}
		


        });
      }

    </script>
	
	
	
	
		<div id="header">
			<a style="text-decoration:none; color:#ffffff;" href="LoggedInPage.jsp">
				<span class="headerSycCal">Maple Calendar</span>
			</a>
			
			
			
			<div id="headerSearchFriends2">
				<form id="myForm" name="searchForm" method="GET" action ="searchFriends2">
					<input type ="text" id="searchFriendID" name="searchFriendName" style="width: 530px; height: 40px; font-size: 26px;" placeholder="Search Friends">
				</form>
			</div>		
			
			<a style="text-decoration:none; color:#ffffff;" href="ProfilePage.jsp">
				<span class="headerProfHome">Profile</span>
			</a>
			
			<a style="text-decoration:none; color:#ffffff;" href="homePage.jsp">
				<span class="headerProfHome">Home</span>
			</a>
		</div>
		
		
		<div id="ProfileName"><%=request.getSession().getAttribute("sessionName") %></div>
		
		
		<div class="ProfPicPosition">
			<img id="profPic" src=<%=request.getSession().getAttribute("sessionImageURL") %>>
		</div>
		
		
		<div id="profilePageTable">
		
			<div 
				id="bodyUpcomingEvents">Upcoming Events
			</div> 
		
		
			<div id="DateTimeEventSum"></div>
			
			
			
		</div>		
		
		
		<div id="footer"></div>
		
		


    <script async defer src="https://apis.google.com/js/api.js"
      onload="this.onload=function(){};handleClientLoad()"
      onreadystatechange="if (this.readyState === 'complete') this.onload()">
    </script>
		
		
		
	</body>
	
</html>