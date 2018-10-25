For a tl;dr please refer to the brief explanation below

For more detailed information and explanations about functionality, please refer to the Maple Calendar Description.pdf.

If you intend on running it, you must run it through a server. I used Apache Tomcat, but it should work on any other server of your choice. Also, the application is meant to be run at 1440x1028 resolution on the browser. 

<h1> tl;dr </h1>
This calendar web application utilizes the Google Calendar API to retrieve calendar information after logging in. Simple user data and that user’s events will be locally stored in a backend SQL database. The SQL script is provided so that users can create the database and populate it on sign in. Utilizing the database will be necessary to take advantage of all the functionality of this calendar application, but most core functionalities will still work with only one user signed in.  

Every time a user logs into the calendar app, the user’s information will be stored in the database if it’s not already there. 

NOTE: ALL USER INFORMATION IS ONLY STORED LOCALLY IN THE SQL DATABASE. NO USER INFORMATION IS BEING COLLECTED.
