<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Search Results</title>
		<link rel="stylesheet" type="text/css" href="style.css">
		
	</head>
	
	<body>
	
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
		
 		

       	<%@ page import ="java.util.ArrayList" %>
       	
       	<%request.getSession().getAttribute("sessionSearchedNames"); %>
       	<%request.getSession().getAttribute("sessionSearchedImageURLs"); %>
       	<%request.getSession().getAttribute("sessionSearchedEmails"); %>
      			
		<%
		ArrayList<String> retrievedNames = (ArrayList<String>)request.getSession().getAttribute("sessionSearchedNames");
		ArrayList<String> retrievedImageURLs = (ArrayList<String>)request.getSession().getAttribute("sessionSearchedImageURLs"); 
		ArrayList<String> retrievedEmails = (ArrayList<String>)request.getSession().getAttribute("sessionSearchedEmails"); 
		
		String namesJSONString = (String)request.getSession().getAttribute("namesJSONString");
		String imagesJSONString = (String)request.getSession().getAttribute("imagesJSONString");
		String emailsJSONString = (String)request.getSession().getAttribute("emailsJSONString");

		
		for(int i = 0; i < retrievedNames.size(); i++){
		%>
		
			<div id="<%=i%>" class="picAndName" onclick="loadFriendPage(this.id)">
				<img class="searchedImage" src="<%=retrievedImageURLs.get(i) %>" >
				<div class="searchedFriendName"><%=retrievedNames.get(i) %></div>
			</div>
 			
		<% } //closing bracket of for loop %> 


		
		<script>
			var tempNameString = ""; 
			tempNameString = "<%=namesJSONString%>"
			
			var tempImageString = "";
			tempImageString = "<%=imagesJSONString%>"
			
			var tempEmailString = "";
			tempEmailString = "<%=emailsJSONString%>"

								
			var namesArray = tempNameString.split(",");
			var imagesArray = tempImageString.split(",");
			var emailsArray = tempEmailString.split(",");
		</script>
				
				
		<script>
			function loadFriendPage(id){
				
 				var clickedName = namesArray[id];
				var clickedImageURL = imagesArray[id];
				var clickedEmail = emailsArray[id];
				
								
				var currUserEmail = sessionStorage.getItem("currentlySignedInUserEmail");
				var currUserName = sessionStorage.getItem("currentlySignedInUserName");
				var currUserImage = sessionStorage.getItem("currentlySignedInUserImage");
				
				
  				var requeststr = "friendPage?";
				requeststr += "clickedName=" + clickedName;
				requeststr += "&clickedURL=" + clickedImageURL;
				requeststr += "&clickedEmail=" + clickedEmail;
				requeststr += "&currUserEmail=" + currUserEmail;
				requeststr += "&currUserName=" + currUserName;
				requeststr += "&currUserImage=" + currUserImage;
				
				sessionStorage.setItem('clickedName', clickedName);
				sessionStorage.setItem('clickedEmail', clickedEmail);
				sessionStorage.setItem('clickedImageURL', clickedImageURL);

				
				var xhttp3 = new XMLHttpRequest();
				xhttp3.open("GET", requeststr, false);
				xhttp3.send();
				
				window.location.href = "friendsProfilePage.jsp"
				
			}
		</script>
		
		<div id="footer"></div>
		
	</body>
	 
</html>