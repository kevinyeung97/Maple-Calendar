<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Sign-In Page</title>
		<link rel="stylesheet" type="text/css" href="style.css">
		
		<script src="https://apis.google.com/js/platform.js" async defer></script>
		
		<meta name="google-signin-client_id" content="806680427871-1p9ln591dk7s3s7725i4haubbdt1bun4.apps.googleusercontent.com">
		
		<meta name="google-signin-scope" content="https://www.googleapis.com/auth/calendar">
		
	</head>
	
	<body>
	
		<div id="header"></div>
		
		<div class=SycCalPosition>
			<div class="sycCal">Maple Calendar</div>
		</div>
		
		<div class=SycLeafPosition>
			<img src="http://www.supercoloring.com/sites/default/files/silhouettes/2015/07/sycamore-leaf-dark-orange-silhouette.svg" height="250" width="250"></img>
		</div>		
	
		
		<div class="g-signin2" data-onsuccess="onSignIn"></div>
		
	
		<script>var requeststr2</script>
		
		
		<script type="text/javascript">
		
		
			function onSignIn(googleUser) {
				
				let GoogleAuth = gapi.auth2.getAuthInstance();
				//code from piazza to let user create events
				
				// Retrieve the GoogleUser object for the current user.
				var profile = googleUser.getBasicProfile();
				
				sessionStorage.setItem("currentlySignedInUserEmail", profile.getEmail());
				sessionStorage.setItem("currentlySignedInUserName", profile.getName());
				sessionStorage.setItem("currentlySignedInUserImage", profile.getImageUrl());
				
				
				var requeststr = "LoginServlet?";
				requeststr += "id=" + profile.getId();
				requeststr += "&name=" + profile.getName();
				requeststr += "&imageURL=" + profile.getImageUrl();
				requeststr += "&email=" + profile.getEmail();

				
				var xhttp = new XMLHttpRequest();
				xhttp.open("GET", requeststr, false);
				xhttp.send();
				
				
				
				//passing information into different servelet
				requeststr2 = "searchFriends?";
				requeststr2 += "id=" + profile.getId();
				requeststr2 += "&name=" + profile.getName();
				requeststr2 += "&email=" + profile.getEmail();
				requeststr2 += "&imageURL=" + profile.getImageUrl();
				

				return true;				
		
			}
			
		
		</script>
		
		
		

		<script>
	      // Client ID and API key from the Developer Console
	      var CLIENT_ID = '806680427871-1p9ln591dk7s3s7725i4haubbdt1bun4.apps.googleusercontent.com';
	      var API_KEY = 'AIzaSyC3JmwyHMkB8L930I_RBwFEwhJj75kBvOQ';

	      // Array of API discovery doc URLs for APIs used by the quickstart
	      var DISCOVERY_DOCS = ["https://www.googleapis.com/discovery/v1/apis/calendar/v3/rest"];

	      // Authorization scopes required by the API; multiple scopes can be
	      // included, separated by spaces.
	      var SCOPES = "https://www.googleapis.com/auth/calendar";


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

	        });
	      }
		
	    
	      /**
	       *  Called when the signed in status changes, to update the UI
	       *  appropriately. After a sign-in, the API is called.
	       */
	      function updateSigninStatus(isSignedIn) {
	        if (isSignedIn) {
	          listUpcomingEvents();
			} 

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
	        
	        
	        ////////I use events0 to pass to servlet
	        var events0;

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
	           
	           events0 = events;
	           			 	

				var requeststr3 = '';
				requeststr3 += requeststr2;
				requeststr3 += ' ';
								
				for(var i = 0; i < events0.length; i++){
					var event0 = events[i];
					requeststr3 += "&eventName" + i + "=" + event0["summary"];
					requeststr3 += "&eventDateTime" + i + "=" + event0['start']['dateTime'];
					requeststr3 += " ";
				}
				
				requeststr3 += "&numEvents=" + events0.length;
				
				
				var xhttp3 = new XMLHttpRequest();
				xhttp3.open("GET", requeststr3, false);
				xhttp3.send();
								
				
				window.location.href = "LoggedInPage.jsp"
	           
	         });
	       }
		
		
	
	       

		
		
		
		</script>
		
		
		
	<script async defer src="https://apis.google.com/js/api.js"
      onload="this.onload=function(){};handleClientLoad()"
      onreadystatechange="if (this.readyState === 'complete') this.onload()">
    </script>
		
		
		
				
		
		<div id="footer"></div>
	
	
	
	
	
	

	</body>
	
</html>