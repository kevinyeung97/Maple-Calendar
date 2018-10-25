<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Logged In Page</title>
		<link rel="stylesheet" type="text/css" href="style.css">
		
		<script src="https://apis.google.com/js/platform.js" async defer></script>
		<meta name="google-signin-client_id" content="806680427871-1p9ln591dk7s3s7725i4haubbdt1bun4.apps.googleusercontent.com">
		
		<meta name="google-signin-scope" content="https://www.googleapis.com/auth/calendar">
		
	</head>
	
	<body>
	
		<div id="header">
		
			<div id="headerSearchFriends">
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
		
		<div class="SycCalPosition">
			<div class="sycCal">Maple Calendar</div>
		</div>
		
		<div class="SycLeafPosition">
			<img src="http://www.supercoloring.com/sites/default/files/silhouettes/2015/07/sycamore-leaf-dark-orange-silhouette.svg" height="250" width="250"></img>
		</div>
		
		
									<script>
										var tempEmail2 = sessionStorage.getItem("currentlySignedInUserEmail");
									</script>
		
		
		
		

		<div class="g-signin2" data-onsuccess="onSignIn" onclick="signOut(event);"></div>
		
		<script>
	  	function signOut(e) {
	  		e.preventDefault();
	    	var auth2 = gapi.auth2.getAuthInstance();
	   		auth2.signOut().then(function () {
	    		console.log("User signed out.");
	    	});
	   		window.location.href = "signInPage.jsp"
	  	}
	  	
		</script>
		
		
		<div id="footer"></div>
		
	</body>
	
</html>