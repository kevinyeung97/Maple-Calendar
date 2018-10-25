<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Friends Profile Page</title>
		<link rel="stylesheet" type="text/css" href="style.css">
		
	</head>
	
	<body>
	
	
		<script async defer src="https://apis.google.com/js/api.js"
		      onload="this.onload=function(){};handleClientLoad()"
		      onreadystatechange="if (this.readyState === 'complete') this.onload()">
		</script>
		    
			
		<script>
			function handleClientLoad() {
				gapi.load('client:auth2' , initClient);
			}
			
	      function initClient() {
	    	  
	    	  var DISCOVERY_DOCS = ["https://www.googleapis.com/discovery/v1/apis/calendar/v3/rest"];
	    	  var SCOPES = "https://www.googleapis.com/auth/calendar";
	    	  			/* https://www.googleapis.com/auth/calendar */
	    	  
	          gapi.client.init({
	            apiKey: 'AIzaSyC3JmwyHMkB8L930I_RBwFEwhJj75kBvOQ',
	            clientId: '806680427871-1p9ln591dk7s3s7725i4haubbdt1bun4.apps.googleusercontent.com',
	            discoveryDocs: DISCOVERY_DOCS,
	            scope: SCOPES
	          }).then(function () {
	            // Listen for sign-in state changes.
	            gapi.auth2.getAuthInstance().isSignedIn.listen(updateSigninStatus);
	
	            // Handle the initial sign-in state.
	            updateSigninStatus(gapi.auth2.getAuthInstance().isSignedIn.get());
	            
	            
	          });
	        }
	      
	      function appendPre(message) {
		        var pre = document.getElementById('content');
		        var textContent = document.createTextNode(message + '\n');
		        pre.appendChild(textContent);
		  }  
	      
	      	
	      function updateSigninStatus(isSignedIn) {
	          if (isSignedIn) {
	            console.log ("signed in")
	          } else {
	            console.log ("not signed in")
	          }
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
		
		

		<div id="followButtonContainer">
			<button type="button" id="followButton" onclick="loadEvents()"></button>
		</div>
		
		
		
 		<script>
			function loadEvents(){
				if(isFollowing == "true"){	//signed in user is originally following clicked name
											console.log("loadEvents function, inside if isF = tru, make follow button Unfollow");
				
					//remove table F
					//display red text F
					//update Database F
					//change button to Follow F
					//updateisFollowing to false F
					
					//remove table				
				    var elements = document.getElementsByClassName('cssEvent');
				    while(elements.length > 0){
				        elements[0].parentNode.removeChild(elements[0]);
				    }
										
				    
					//display red text
							
 					var element2 = document.createElement("div");
					element2.setAttribute("id", "tableContents");
					element2.setAttribute("class", "redTableText"); 
					var tempName2 = '<%= session.getAttribute( "clickedName10" ) %>'
					element2.appendChild(document.createTextNode('Follow ' + tempName2.substr(0,tempName2.indexOf(' ')) + ' to view Upcoming Events'));
					document.getElementById('DateTimeEventSum').appendChild(element2);
					
					
					//update Database (currUser follows ky96 -> curr user does NOT follow ky96)
					ajaxRequest2 = new XMLHttpRequest();
		            ajaxRequest2.onreadystatechange = function() {
		                
		                if(ajaxRequest2.readyState == 4 && this.status == 200) {
		                	console.log("currUser just unfollowed clickedUser");
		                } 
		                
		             }
					var temptempName2 = '<%= session.getAttribute( "clickedName" ) %>'
					var temptempEmail2 = '<%= session.getAttribute( "clickedEmail" ) %>'
					var params2 = "clickedName=" + temptempName2 + "&clickedEmail=" + temptempEmail2;
					
					ajaxRequest2.open('GET', 'FriendPageUpdateDB2' +'?' + params2 , true);
					ajaxRequest2.send();  
					
					
					
					//update button text
					document.getElementById("followButton").innerHTML = "Follow";
					
					//change
					isFollowing = isFollowing.replace("true", "false");
				}
				
				else if(isFollowing == "false"){ //signed in user is originally NOT following clicked name
												console.log("loadEvents function, inside elif isF = false, make follow button Follow");

					//remove red text F
					//display table F
					//update database F
					//change button to Unfollow F
					//update isFollowing to true F
					
					//remove red text
 					var div = document.getElementById("tableContents");
					div.parentNode.removeChild(div); 
					
					//display Table
			       	<%@ page import ="java.util.ArrayList" %>
			       	
			       	<%
			       	request.getSession().getAttribute("sessionEventNamesJSONString");
			       	request.getSession().getAttribute("sessionEventDatesJSONString"); 
			       	request.getSession().getAttribute("sessionEventTimesJSONString"); 
		         	
			       	String eventNamesJSONString2 = (String)request.getSession().getAttribute("sessionEventNamesJSONString");
					String eventDatesJSONString2 = (String)request.getSession().getAttribute("sessionEventDatesJSONString");
					String eventTimesJSONString2 = (String)request.getSession().getAttribute("sessionEventTimesJSONString");
					
					int numEvents2 = (Integer)request.getSession().getAttribute("numEvents");
							System.out.println("numEvents: " + numEvents2);
					%>
					
					var tempEventNames2 = '<%=eventNamesJSONString2%>'
					var eventNamesArray2 = tempEventNames2.split(',');
	/* 										console.log("fPP.jsp eventNamesArr2: " + eventNamesArray2);
											
											for(var k = 0; k < 5; k++){
												console.log("eventName2 index " + k + ": " + eventNamesArray2[k]);
											} */
											
					var tempEventDates2 = '<%=eventDatesJSONString2%>'
					var eventDatesArray2 = tempEventDates2.split('|');	
											/* console.log("fPP.jsp eventDatesArr2: " + eventDatesArray2); */
											
					var tempEventTimes2 = '<%=eventTimesJSONString2%>'
					var eventTimesArray2 = tempEventTimes2.split(',');	
											/* console.log("fPP.jsp eventTimesArr2: " + eventTimesArray2); */
											
					<% 
					for(int i = 0; i < numEvents2; i++){ 
					%>
						
						var k = '<%=i%>'

						var event2 = document.createElement("div");
						event2.className="cssEvent"	
						event2.id = 'tableContents'
						
						var divDate2 = document.createElement("div");
		        		divDate2.className="cssDivDate";
						var divDate3 = document.createTextNode(eventDatesArray2[<%=i%>]);
						divDate2.appendChild(divDate3);
						divDate2.setAttribute("id", k);
						divDate2.setAttribute('onclick','addFriendsEvent(this.id);');
						
						var divTime2 = document.createElement("div");
		        		divTime2.className="cssDivTime";
						var divTime3 = document.createTextNode(eventTimesArray2[<%=i%>]);
						divTime2.appendChild(divTime3);	
						divTime2.setAttribute("id", k);
						divTime2.setAttribute('onclick','addFriendsEvent(this.id);');
						
						var divEventTitle2 = document.createElement("div");
						divEventTitle2.className="cssDivEventTitle";									
						var divEventTitle3 = document.createTextNode(eventNamesArray2[<%=i%>]);
						divEventTitle2.appendChild(divEventTitle3);
						divEventTitle2.setAttribute("id", k);
						divEventTitle2.setAttribute('onclick','addFriendsEvent(this.id);');
						
						
						
						var j;
						for(j = 0; j < 3; j++){
							event2.appendChild(divDate2);
							event2.appendChild(divTime2);
							event2.appendChild(divEventTitle2);
							
						}
						
						DateTimeEventSum.appendChild(event2);
					
					
					<%
					}  //closing bracket of for loop
					%>
					
					
					//update database (currUser does not follow yousef -> curr user follows yousef)
					ajaxRequest = new XMLHttpRequest();
		            ajaxRequest.onreadystatechange = function() {
		                
		                if(ajaxRequest.readyState == 4 && this.status == 200) {
		                	console.log("successfully following clicked user now")
		                } 
		                
		                
		             }
		            
					var temptempName = '<%= session.getAttribute( "clickedName" ) %>'
					var temptempEmail = '<%= session.getAttribute( "clickedEmail" ) %>'
					var params = "clickedName=" + temptempName + "&clickedEmail=" + temptempEmail;
					
					ajaxRequest.open('GET', 'FriendPageUpdateDB' +'?' + params , true);
					ajaxRequest.send();  
					 
					
					
					//change button to Unfollow
					document.getElementById("followButton").innerHTML = "Unfollow";
					
					//update isFollowing to true
					isFollowing = isFollowing.replace("false", "true");
				}
		
			}
		</script>
		
		
		
		<div id="profilePageTable">
		
			<div id="bodyUpcomingEvents">Upcoming Events</div> 
		
			<div id="DateTimeEventSum">
<!-- 				  <div id=tableContents></div> --> <!-- have initial page load add the tableContents div tag -->
			</div>
			
			<script type="text/javascript">
				var str = '<p> <span id="headerDate">Date</span> <span id="headerTime">Time</span> <span id="headerES">Event Summary</span></p>';
				DateTimeEventSum.insertAdjacentHTML( 'afterbegin', str );
			</script>
			
		</div>
		
		
		<script>
			let globalEventNamesArray = [];
			let globalEventDatesArray = [];
			let globalEventTimesArray = [];
		</script>
		
		
		<script>			
			var isFollowing = '<%= session.getAttribute( "servletIsFollowing" ) %>'
							console.log("isFollowing: " + isFollowing)
			if(isFollowing == "true"){	//signed in user is following clicked name
	
							console.log("inside if isF = tru, make follow button Unfollow");
				document.getElementById("followButton").innerHTML = "Unfollow";
				
				
				//load clickedEmail's events from database
		       	<%@ page import ="java.util.ArrayList" %>
		       	
		       	<%
		       	request.getSession().getAttribute("sessionEventNamesJSONString");
		       	request.getSession().getAttribute("sessionEventDatesJSONString"); 
		       	request.getSession().getAttribute("sessionEventTimesJSONString"); 
	         	
		       	String eventNamesJSONString = (String)request.getSession().getAttribute("sessionEventNamesJSONString");
				String eventDatesJSONString = (String)request.getSession().getAttribute("sessionEventDatesJSONString");
				String eventTimesJSONString = (String)request.getSession().getAttribute("sessionEventTimesJSONString");
				
				int numEvents = (Integer)request.getSession().getAttribute("numEvents");
						System.out.println("numEvents: " + numEvents);
				%>
				
				var tempEventNames = '<%=eventNamesJSONString%>'
				var eventNamesArray = tempEventNames.split(',');
				globalEventNamesArray = eventNamesArray;
/* 										console.log("fPP.jsp eventNamesArr: " + eventNamesArray);
										
										for(var k = 0; k < 5; k++){
											console.log("eventName index " + k + ": " + eventNamesArray[k]);
										} */
										
				var tempEventDates = '<%=eventDatesJSONString%>'
				var eventDatesArray = tempEventDates.split('|');	
										console.log("fPP.jsp eventDatesArr: " + eventDatesArray);
				globalEventDatesArray = eventDatesArray;
									
										
				var tempEventTimes = '<%=eventTimesJSONString%>'
				var eventTimesArray = tempEventTimes.split(',');	
										console.log("fPP.jsp eventTimesArr: " + eventTimesArray);
							
				globalEventTimesArray = eventTimesArray;
				
				
										console.log("fPP.jsp globalEventNamesArr: " + globalEventNamesArray);
										console.log("fPP.jsp globalEventDatesArray: " + globalEventDatesArray);
										console.log("fPP.jsp globalEventTimesArray: " + globalEventTimesArray);
										
				<% 
				for(int i = 0; i < numEvents; i++){ 
				%>

					var j = '<%=i%>'
				
					var event = document.createElement("div");
					event.className="cssEvent"
					event.id = "tableContents"
					
					var divDate = document.createElement("div");
	        		divDate.className="cssDivDate";
					var divDate2 = document.createTextNode(eventDatesArray[<%=i%>]);
					divDate.appendChild(divDate2);
					divDate.setAttribute("id", j);
					divDate.setAttribute('onclick','addFriendsEvent(this.id);');
					
					var divTime = document.createElement("div");
	        		divTime.className="cssDivTime";
					var divTime2 = document.createTextNode(eventTimesArray[<%=i%>]);
					divTime.appendChild(divTime2);
					divTime.setAttribute("id", j);
					divTime.setAttribute('onclick','addFriendsEvent(this.id);');
					
					var divEventTitle = document.createElement("div");
					divEventTitle.className="cssDivEventTitle";									
					var divEventTitle2 = document.createTextNode(eventNamesArray[<%=i%>]);
					divEventTitle.appendChild(divEventTitle2);
					divEventTitle.setAttribute("id", j);
					divEventTitle.setAttribute('onclick','addFriendsEvent(this.id);');
					
					var j;
					for(j = 0; j < 3; j++){
						event.appendChild(divDate);
						event.appendChild(divTime);
						event.appendChild(divEventTitle);
						
					}
					
					DateTimeEventSum.appendChild(event);
				
				
				<%
				}  //closing bracket of for loop
				%>
			}
			
			else if(isFollowing == "false") {
							console.log("inside elif isF = false, make follow button Follow");
							
				document.getElementById("followButton").innerHTML = "Follow";
				
				var element = document.createElement("div");
				element.setAttribute("id", "tableContents");
				element.setAttribute("class", "redTableText"); ///// use this to 
				var tempName = '<%= session.getAttribute( "clickedName10" ) %>'
				element.appendChild(document.createTextNode('Follow ' + tempName.substr(0,tempName.indexOf(' ')) + ' to view Upcoming Events'));
				document.getElementById('DateTimeEventSum').appendChild(element);
			}
			
			
		</script>
		
		
		<script>
			function addFriendsEvent(id) {
												console.log("id1: " + id);
			
				//updates Database
				ajaxRequest3 = new XMLHttpRequest(); 
				ajaxRequest3.onreadystatechange = function() { 	
					if(ajaxRequest3.readyState == 4 && this.status == 200) {
							console.log("successfully update Database");
			
					} 
				
				}		//end of ajax callback function
				
				
				var currUserEmail3 = sessionStorage.getItem('currentlySignedInUserEmail');
				var currUserName3 = sessionStorage.getItem('currentlySignedInUserName');
				var currUserImage3 = sessionStorage.getItem('currentlySignedInUserImage');
	
				var clickedEventName3 = globalEventNamesArray[id];
				var clickedEventDate3 = globalEventDatesArray[id];
				var clickedEventTime3 = globalEventTimesArray[id];
				
												console.log("clickedEventName3: " + clickedEventName3);
												console.log("clickedEventDate3: " + clickedEventDate3);
												console.log("clickedTime3: " + clickedEventTime3);
				
				
				var params3 = "clickedEventName=" + clickedEventName3 + "&clickedEventDate=" + clickedEventDate3;
				params3 += "&clickedEventTime=" + clickedEventTime3 + "&currUserEmail=" + currUserEmail3;
				params3 += "&currUserName=" + currUserName3 + "&currUserImage=" + currUserImage3;
				
				ajaxRequest3.open('GET', 'addFriendsEvent' +'?' + params3 , true);
				ajaxRequest3.send(); 
				
				
			
				
				//addEvent to my google Calendar ///////////////////////////////
				var title = globalEventNamesArray[id];
				var sDate = globalEventDatesArray[id]
				var sTime = globalEventTimesArray[id];
				
											console.log("sDate1: " + sDate);
											
				
												/* var eDate = document.createEventForm.endDate.value;
													var eTime = document.createEventForm.endTime.value; */
											
				if(sTime.slice(-2) == "PM"){
					var sTime2 = sTime.slice(0,2);
					var sTimeInt2 = parseInt(sTime2, 10);
					sTimeInt2 += 12;
					sTime2String = sTimeInt2.toString();
					sTime2String += sTime.slice(2,5);
					sTime2String += ":00-07:00";
					
													console.log("sTime2String: " + sTime2String);
					sTime2String = "T" + sTime2String;
					sTime2String = sTime2String.replace(/\s/g, '');
												console.log("sTime2String: " + sTime2String);
					if(sTime2String.indexOf(':')-2 != ':'){
						sTime2String = sTime2String.substr(0, sTime2String.indexOf(':')-2) + ':' + sTime2String.substr(sTime2String.indexOf(':')-2, sTime2String.indexOf(':'));
					}
					sTime = sTime2String +"-07:00";
													console.log("sTime: " + sTime);
													console.log("")
				}
				else if (sTime.slice(-2) == "AM"){
					if(sTime.indexOf(":") == 1){
						sTime = "0" + sTime;
					}
					sTime = sTime.substr(0, sTime.length-3);
					sTime += ":00-07:00";
					sTime = "T" + sTime;
													
													console.log("sTime: " + sTime);
													console.log("")
				}
				
				
				var sDateYR = sDate.slice(-4);
				var sDateDD = sDate.slice(sDate.indexOf(' ')+1, sDate.indexOf(','));
				var sDateMM = sDate.slice(0, sDate.indexOf(' '));
				
				if(sDateMM == 'January'){
					sDateMM = '01'
				}
				if(sDateMM == 'February'){
					sDateMM = '02'
				}
				if(sDateMM == 'March'){
					sDateMM = '03'
				}
				if(sDateMM == 'April'){
					sDateMM = '04'
				}
				if(sDateMM == 'May'){
					sDateMM = '05'
				}
				if(sDateMM == 'June'){
					sDateMM = '06'
				}
				if(sDateMM == 'July'){
					sDateMM = '07'
				}
				if(sDateMM == 'August'){
					sDateMM = '08'
				}
				if(sDateMM == 'September'){
					sDateMM = '09'
				}
				if(sDateMM == 'October'){
					sDateMM = '10'
				}
				if(sDateMM == 'November'){
					sDateMM = '11'
				}
				if(sDateMM == 'December'){
					sDateMM = '12'
				}
				
											
											console.log("sDateYR: " + sDateYR );	
											console.log("sDateMM: " + sDateMM );	
											console.log("sDateDD: " + sDateDD );	
				sDate = sDateYR + '-' + sDateMM + '-' + sDateDD;
											
										
				sDate = sDate + sTime;
										console.log("final sDate: " + sDate);
										console.log("event Title: " + title);
				var event = {
						  'summary': title,
						  'start': {
						    'dateTime': sDate,
						    'timeZone': 'America/Los_Angeles'
						  },
						  'end': {
						    'dateTime': sDate,
						    'timeZone': 'America/Los_Angeles'
						  },
					
						  
				};
													
													

												console.log("right before adding event to calendar")
 				var request = gapi.client.calendar.events.insert({
				  'calendarId': 'primary',
				  'resource': event
				}); 
												console.log("right after adding event to calendar")

				request.execute(function(event) {
										alert("You are about to add your friend's event to you calendar")
					//appendPre('Event created: ' + event.htmlLink);
				});	

												
													
			
													
			};	/* end of addFriend function */
		</script>
		
		
		
		
		
		
		
		<div id="profileNameAndPicContainer">
			<div id="ProfileName"></div>
			
			<div class="ProfPicPosition">
				<img id="profPic">
			</div>
		</div>
		
		
		<script>
			var temp = '<%= session.getAttribute("clickedName10") %>'
			document.getElementById("ProfileName").innerHTML = temp; 
					console.log("changed profile name to: " + temp);
		</script>
		
		
		<script>
			var temp2 = '<%= session.getAttribute("clickedImageURL10") %>'
			document.getElementById('profPic').src = temp2;
							console.log("changed profile image to: " + temp2);
		</script>
		
		
		
		<script>
			var currUserEmail = sessionStorage.getItem("currentlySignedInUserEmail")
			var currUserName = sessionStorage.getItem("currentlySignedInUserName")
			var currUserImage = sessionStorage.getItem("currentlySignedInUserImage")
			
			console.log("currUserEmail: " + currUserEmail);
			console.log("currUserName: " + currUserName);
			console.log("currUserImage: " + currUserImage);
		</script>


		
		

		
		
		<div id="footer"></div>
		
	</body>
	
</html>