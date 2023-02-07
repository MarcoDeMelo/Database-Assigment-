/*

   Assigment 2
   Name: Marco De Melo
   Date: 2022-03-14
   Purpose of database: creating a database for a podcasting company to
   keep track of their podcasts and guests
   
   */
drop database if exists A2Marco;
create database if not exists A2Marco;
use A2Marco;
-- M:N table -- 
CREATE TABLE podcast
(
	podcastID			INT		PRIMARY KEY,
	podcastTitle		VARCHAR(50),
    typeOfPodcast       VARCHAR(50), -- What's the podcast about, diffirent ways to self help -- 
	podcastCost         DOUBLE, -- how much the podcast cost them to make
	podcastDateRel	    DATE
 
);


INSERT INTO podcast VALUES
(01,'Self confidence','Improving self confidence',5123.32, '2020/01/31'),
(02,'Body Image','Improving self view on your body',8231.42,'2020/02/12'),
(03,'Habits','How to cut out bad habits you may have',60.00,'2020/03/14'),
(04,'Routine','How to start and stick to good routines',3000.21,'2020/04/19'),
(05,'Mental health','How to improve your mental health',5.00,'2020/05/22');


CREATE TABLE guest
(
  guestId      INT PRIMARY KEY,
  guestFName   VARCHAR(50),
  guestLName   VARCHAR(50),
  typeOfGuest VARCHAR(50) -- ex: singer, writter, actor, dancer, youtuber etc. --
);

INSERT INTO guest VALUES 
(101,'Marc','Demetrius','Singer'),
(102,'Donald','Sans','Dancer'),
(103,'Sarrah','Bland','Youtuber'),
(104,'Carl','Seguin','Writter'),
(105,'John','Arbuckle','Actor'),
(106,'Jennifer','Al Capone','Dancer');

-- M:N table -- 

-- 1:1 Table -- 

CREATE TABLE guestPrivateInfo 
(
  guestId  INT PRIMARY KEY,
  guestPhoneNumber VARCHAR(50),
  guestAge INT,
  guestCost double -- how much they cost for attending the podcast

);
INSERT INTO guestPrivateInfo  VALUES 
(101,'642-132-5123',24,100.25),
(102,'762-145-7132',17,0.00),
(103,'912-234-6123',29,250.23),
(104,'612-271-9312',50,1.99),
(105,'951-213-6123',22,59.31),
(106,'315-231-3214',16,2413.00);


-- 1:1 Table -- 




-- Junction Table -- 
CREATE TABLE podcastGuest
( 
  podcastID INT,
  guestID INT,
  didAttend BOOLEAN,

  PRIMARY KEY(podcastID,guestID),
  
  
  FOREIGN KEY(podcastID)
   REFERENCES podcast(podcastID),
   
   FOREIGN KEY(guestID)
     REFERENCES guest(guestID)
);

INSERT INTO podcastGuest VALUES
(01,102,TRUE),
(02,101,FALSE),
(03,105,TRUE),
(04,106,TRUE);




-- Junction Table -- 


-- Queries --
/*
SELECT 
 -- Query 1
 guestFName, guestLName , guestPhoneNumber,guestAge
FROM guest
  JOIN guestPrivateInfo
 WHERE guest.guestID = guestPrivateInfo.guestID
  
  -- Query 2
  
  podcastTitle,podcastCost,guestFName, guestCost, round(guestCost / podcastCost,3) * 100 AS PercentageOfCost 
FROM podcast
   JOIN podcastGuest
     ON podcastGuest.podcastID=podcast.podcastID
     JOIN guestPrivateInfo
      ON podcastGuest.guestID = guestPrivateInfo.guestID
      JOIN guest 
    ON guest.guestID=podcastGuest.guestID
      ORDER BY PercentageOfCost
     
      
  --  Query 3
  podcastTitle AS empty_podcast
  FROM podcast
 LEFT JOIN podcastGuest
  ON podcast.podcastID = podcastGuest.podcastID
  WHERE guestID IS NULL;
 
  --  Query 4
   podcastTitle,guestFName,guestLName,guestAge
  FROM podcast
   JOIN podcastGuest
     ON podcastGuest.podcastID=podcast.podcastID
    JOIN guest 
    ON guest.guestID=podcastGuest.guestID
      JOIN guestPrivateInfo
      ON guest.guestID = guestPrivateInfo.guestID
    ORDER BY podcast.podcastID

