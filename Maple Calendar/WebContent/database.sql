CREATE DATABASE Assignment3;
 USE Assignment3;

CREATE TABLE Users (

	email VARCHAR(100) PRIMARY KEY,
    userName VARCHAR(50) NOT NULL,
    userNameUpper VARCHAR(50) NOT NULL,
    imageURL VARCHAR(200) NOT NULL
    
);

CREATE TABLE UserEvents (

	email VARCHAR (100),
	FOREIGN KEY fk1 (email) REFERENCES Users(email),
    eventName VARCHAR(200) NOT NULL,
    eventDate VARCHAR(50),
    eventTime VARCHAR(50)
    
);

CREATE TABLE Relationships (

	email VARCHAR (100),
	FOREIGN KEY fk2 (email) REFERENCES Users(email),
    followings VARCHAR(100) NOT NULL,
	FOREIGN KEY fk3 (followings) REFERENCES Users(email)
        
); 



