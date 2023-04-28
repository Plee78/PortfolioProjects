-- Data types excise

-- What is a good use case for CHAR()?
-- When inputted values are going to be a fixed number of values. 
-- Best used to save on storage

-- Fill in the blanks

-- CREATE TABLE inventory (
-- 		item_name _____,
-- 		price ____,
-- 		quantity ____,
-- );

-- CREATE TABLE inventory (
-- item_name VARCHAR(100),
-- price DECIMAL(9,2),
-- quanity int);

-- What's the difference between DATETIME and TIMESTAMP
-- DATETIME shows the date and time values. Takes up more storage with a larger 
-- range

-- Print out the current time

SELECT CURTIME();

-- Print out the current date

SELECT CURDATE();

-- Print out the current day of the week

SELECT DAYOFWEEK(CURDATE());

-- Print out the current day of the week

SELECT DAYNAME(CURDATE());

-- Print out the current day and time using this format: mm/dd/yyyy

SELECT DATE_FORMAT(CURDATE(), '%m/%d/%Y');

-- Print out the current day and time using this format: January 2nd at 3:15
-- April 1st at 10:18

SELECT DATE_FORMAT(NOW(), '%M %D at %k:%i');

-- Create a tweets table that stores: the tweet content, a username, time it was created

CREATE TABLE tweets (
	content VARCHAR(180),
    username VARCHAR(20),
    created_at TIMESTAMP DEFAULT NOW()
);