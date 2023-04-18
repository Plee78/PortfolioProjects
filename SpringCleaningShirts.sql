-- You are doing spring cleaning with all types of shirts in your wardrobe
-- You decide to use MySQL to stay organized

-- Create database for our spring cleaning

CREATE DATABASE shirts_db;

-- Create table for our shirts 

USE shirts_db;

CREATE TABLE shirts (
	shirt_id INT PRIMARY KEY AUTO_INCREMENT,
    article VARCHAR(20) NOT NULL,
    color VARCHAR(20) NOT NULL,
    shirt_size VARCHAR(10) NOT NULL,
    last_worn INT NOT NULL
    );
    
-- Inserting values into the table
    
INSERT INTO shirts (article, color, shirt_size, last_worn)
    VALUES
    ('t-shirt', 'white', 'S', 10),
	('t-shirt', 'green', 'S', 200),
	('polo shirt', 'black', 'M', 10),
	('tank top', 'blue', 'S', 50),
	('t-shirt', 'pink', 'S', 0),
	('polo shirt', 'red', 'M', 5),
	('tank top', 'white', 'S', 200),
	('tank top', 'blue', 'M', 15);
            
-- Insert new data into table 

INSERT INTO shirts (color, article, shirt_size, last_worn)
VALUES ('purple', 'polo shirt', 'M', 50);

-- Select all shirts but print out only article and color

SELECT article, color FROM shirts;

-- Select all medium shirts but print out everything but shirt_id

SELECT article, color, shirt_size, last_worn FROM shirts
WHERE shirt_size = 'M';

-- Update all polo shirts to L

SELECT * FROM shirts WHERE article = 'polo shirt'

UPDATE shirts SET shirt_size = 'L' 
WHERE article = 'polo shirt';

-- Update the shirt last worn 15 days ago to 0 

SELECT * FROM shirts WHERE last_worn = 15;

UPDATE shirts SET last_worn = 0
WHERE last_worn = 15;

-- Update all white shirts change size to 'XS' and color to 'off white'

SELECT * FROM shirts WHERE color = 'white';

UPDATE shirts SET color = 'off white', shirt_size = 'XS'
WHERE color = 'white';

-- Delete all old shirts last worn 200 days ago 

SELECT * FROM shirts WHERE last_worn = 200;

DELETE FROM shirts 
WHERE last_worn = 200; 

-- Delete all tank tops as taste have changed 

SELECT * FROM shirts WHERE article = 'tank top';

DELETE FROM shirts
WHERE article = 'tank top';

-- Delete all shirts 

DELETE FROM shirts;

-- Drop the entire shirts table

DROP TABLE shirts; 