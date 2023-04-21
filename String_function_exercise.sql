-- Reverse and uppercase the string Why does my cat look at me with such hatred?

SELECT UPPER(REVERSE('Why does my cat look at me with such hatred?'));

-- What does this print out?
-- SELECT REPLACE(CONCAT('I', ' ', 'like', ' ', 'cats'), ' ', '-');

'I-like-cats'

-- Replace all spaces in title with ->

SELECT 
    REPLACE(title, ' ', '->') AS title
FROM
    books;

-- Select the last name as forwards.
-- Reverse last name AS backwards

SELECT 
    author_lname AS forwards, REVERSE(author_lname) AS backwards
FROM
    books;

-- Print out the full name of author in caps

SELECT 
    UPPER(CONCAT(author_fname, ' ', author_lname)) AS 'full name in caps'
FROM
    books;

-- Express title, 'was released in', and the release year 

SELECT 
    CONCAT(title,
            ' was released in ',
            released_year) AS blurb
FROM
    books;

-- Print the title and the title length AS character_count

SELECT 
    title, CHAR_LENGTH(title) AS character_count
FROM
    books;

-- Shorten the book title, print author's full name, show quantity stock

SELECT 
    CONCAT(LEFT(title, 10), ',,,') AS short_title,
    CONCAT(author_lname, ',', author_fname) AS author,
    CONCAT(stock_quantity, ' in stock') AS quantity
FROM
    books;

-- OR

SELECT 
    CONCAT(SUBSTR(title, 1, 10), ',,,') AS short_title,
    CONCAT(author_lname, ',', author_fname) AS author,
    CONCAT(stock_quantity, ' in stock') AS quantity
FROM
    books;