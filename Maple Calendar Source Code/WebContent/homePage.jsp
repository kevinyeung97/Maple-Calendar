<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Home Page</title>
		<link rel="stylesheet" type="text/css" href="style.css">
		
		<meta name="google-signin-client_id" content="806680427871-1p9ln591dk7s3s7725i4haubbdt1bun4.apps.googleusercontent.com">
		
		<meta name="google-signin-scope" content="https://www.googleapis.com/auth/calendar">
		
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
	
	
	
	
	<script>
		
		function addEvent() {
			
			var title = document.createEventForm.eventTitle.value;
			var sDate = document.createEventForm.startDate.value;
			var eDate = document.createEventForm.endDate.value;
			var sTime = document.createEventForm.startTime.value;
			var eTime = document.createEventForm.endTime.value;
						
			sDate += 'T' + sTime + ':00-07:00';
			eDate += 'T' + eTime + ':00-07:00';
			
			
			var event = {
					  'summary': title,
					  'start': {
					    'dateTime': sDate,
					    'timeZone': 'America/Los_Angeles'
					  },
					  'end': {
					    'dateTime': eDate,
					    'timeZone': 'America/Los_Angeles'
					  },
				
					  
			};

				if(title != "") {
					
	 				var request = gapi.client.calendar.events.insert({
					  'calendarId': 'primary',
					  'resource': event
					}); 
	 				

					request.execute(function(event) {
						console.log("HELLO")
					});	
					
				}
				
				
				//adding event updates database
				ajaxRequest3 = new XMLHttpRequest();
	            ajaxRequest3.onreadystatechange = function() {
	                
	                if(ajaxRequest3.readyState == 4 && this.status == 200) {
	                	console.log("ajax success");
	                } 
	                
	            } /* end of ajax callback function */
				
	            var currUserEmail5 = sessionStorage.getItem("currentlySignedInUserEmail")
	            
	            /* sessionStorage.setItem('googleFormatEventDate', eventDate); */
	            
				var params3 = "currUserEmail=" + currUserEmail5 + "&eventName=" + title + "&eventDate=" + sDate + "&eventTime=" + sTime;
				
				ajaxRequest3.open('GET', 'addEventUpdateDB' +'?' + params3 , true);
				ajaxRequest3.send(); 
				
				
		}  	/* end of addEvent function */
	      
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
			
		<form id = "myForm" name = "createEventForm"  method= "GET" action = "SuccessPageServlet">
			
			<div class="bodyHome">Home</div>
			
			<div id="stupidRectangle">
			
				<div class=homePageProfPic>
					<img id="bodyProfPic" src=<%=request.getSession().getAttribute("sessionImageURL") %>>
				</div>
				
	
				<div id="bodyProfileName"><%=request.getSession().getAttribute("sessionName") %></div>
				
				
				<table id=homePageTable>
				      
			  	<tr>
				    <th colspan="3"> 
				    	<div id="bodyET">
							Event Title: <input type ="text" name = "eventTitle" value ="${param.eventTitle!=null? param.eventTitle : ''}" size="69">
														
						</div> 
						
					</th>
			  	</tr>
			  
			  	<tr>
			  
			 		<td>
			 			<div id="bodySD">
							Start Date: <input type ="date" name = "startDate" value ="${param.startDate!=null? param.startDate : ''}">
			
						</div>
					</td>
			  
			  
			    	<td>
			    		<div id="bodyED">
							End Date: <input type ="date" name = "endDate" value ="${param.endDate!=null? param.endDate : ''}">
							
						</div>
			    	</td>
			    	
			    	
			    	<td>
			    		<div id="addEvent">
							<input type="submit" name="submit" value="Add Event" style="width: 75px; height: 55px font-size: 20px"  onclick="addEvent()"/>
 						</div>
			    	</td>
			    	
			  	</tr>
			  
			  
			  	<tr>
			    	<td>
			    		<div id="bodyST">
							Start Time: <input type ="time" name = "startTime" value ="${param.startTime!=null? param.startTime : ''}">
							
						</div>
			    	</td>
			    	
			    	
			    	<td colspan="2">
			    		<div id="bodyET2">
							End Time: <input type ="time" name = "endTime" value ="${param.endTime!=null? param.endTime : ''}">
							
						</div>
			    	</td>
			    	
			  	</tr>
			  	
				</table>
				

				<div id="errorMessages">
					<span style="color: red;font-weight:bold">${title_err!=null? title_err : ''}</span><br>
					<span style="color: red;font-weight:bold">${date_err!=null? date_err : ''}</span><br>					
					<span style="color: red;font-weight:bold">${time_err!=null? time_err : ''}</span><br>
				</div>
				
				<div id="followingText">Following</div>
				
		</div>
		
		</form>
		
		<script>
			let globalNamesArray = [];
			let globalImagesArray = [];
			let globalEmailsArray = [];
		</script>
		
		
		
		<div id="homePageFollowing" style="display:inline-block; padding-top: -200px;"></div>
		
		<script>
			ajaxRequest = new XMLHttpRequest();
            ajaxRequest.onreadystatechange = function() {
               
            if(ajaxRequest.readyState == 4 && this.status == 200) {		//this limits the onreadystate callback function to only run once, it was running multiple times before
       	       	<%
		       	request.getSession().getAttribute("emailsJSONString");
		       	request.getSession().getAttribute("imagesJSONString"); 
		       	request.getSession().getAttribute("namesJSONString"); 
	       
				%>

	             var tempEmails = '';
	             tempEmails = '<%= session.getAttribute( "emailsJSONString" ) %>'
	            								
	             var tempImages = '';
	             tempImages = '<%= session.getAttribute( "imagesJSONString" ) %>'
	            								
	            var tempNames = '';
	            tempNames = '<%= session.getAttribute( "namesJSONString" ) %>'
	            								
	               
	   			var namesArray = tempNames.split(",");
	   			var imagesArray = tempImages.split(",");
	   			var emailsArray = tempEmails.split(",");
			    								
			    
				globalNamesArray = namesArray;
				globalImagesArray = imagesArray;
				globalEmailsArray = emailsArray;							
			    								
			    								
			    								
			    								
			    for(var i = 0; i < namesArray.length; i++){
					var picNameContainer = document.createElement("div");
					picNameContainer.className="picAndNameHomePage"	
					picNameContainer.setAttribute("id", i.toString());
					
					var picture = document.createElement("img");
	        		picture.className="searchedImageHomePage";
	        		picture.setAttribute("src", imagesArray[i]);
	        		picture.setAttribute("id", i.toString());
	        		picture.setAttribute('onclick','redirectPage(this.id);');   		
	        		
	        		var name = document.createElement("div");
	        		name.className="searchedFriendNameHomePage";
	        		name.append(document.createTextNode(namesArray[i]));
	
					picNameContainer.appendChild(picture);
					picNameContainer.appendChild(name);
		
					
					homePageFollowing.appendChild(picNameContainer);
		    	}
			    
            }  /* end of if statement */

		    								
		    								
        }	/* end of AJAX callback function */
           
		var temptempName = sessionStorage.getItem("currentlySignedInUserName")
		var temptempEmail = sessionStorage.getItem("currentlySignedInUserEmail")
		var params = "currUserName=" + temptempName + "&currUserEmail=" + temptempEmail;
		
		ajaxRequest.open('GET', 'HomePageLoadFollowing' +'?' + params , true);
		ajaxRequest.send();
	</script>
	
	
	
	<script>
		function redirectPage(id) {
		
			ajaxRequest = new XMLHttpRequest(); 
			ajaxRequest.onreadystatechange = function() { 
				
				if(ajaxRequest.readyState == 4 && this.status == 200) {
					window.location.href = "friendsProfilePage.jsp";
				} 
			
			}		//end of ajax callback function
			
			
			var currUserEmail2 = sessionStorage.getItem('currentlySignedInUserEmail');
			var currUserName2 = sessionStorage.getItem('currentlySignedInUserName');
			var currUserImage2 = sessionStorage.getItem('currentlySignedInUserImage');
			
			
			var clickedName2 = globalNamesArray[id];
			var clickedImageURL2 = globalImagesArray[id];
			var clickedEmail2 = globalEmailsArray[id];
			
			
			var params2 = "clickedName=" + clickedName2 + "&clickedEmail=" + clickedEmail2;
			params2 += "&clickedImage=" + clickedImageURL2 + "&currUserEmail=" + currUserEmail2;
			params2 += "&currUserName=" + currUserName2 + "&currUserImage=" + currUserImage2;
			
			ajaxRequest.open('GET', 'HomePageSearchFriend' +'?' + params2 , true);
			ajaxRequest.send(); 
			
		
		};
	</script>
				
		
		
		<div id="footer"></div>

		
	</body>
	
</html>