This calendar project utilizes the Google Calendar API to retrieve calendar information after logging in. Simple user data and that user’s events will be locally stored in a backend SQL database. The SQL script is provided so that users can create the database and populate it on sign in. Utilizing the database will be necessary to take advantage of all the functionality of this calendar application, but most core functionalities will still work with only one user signed in.  

Every time a user logs into the calendar app, the user’s information will be stored in the database if it’s not already there. 

NOTE: ALL USER INFORMATION IS ONLY STORED LOCALLY IN THE SQL DATABASE. NO USER INFORMATION IS BEING COLLECTED.