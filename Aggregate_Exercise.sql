-- Aggregate function exercise

-- Print the number of books in the database

SELECT 
    COUNT(*) AS book_stored
FROM
    books;
    
-- Print out how many books were released in each year

SELECT 
    released_year,
    COUNT(*) AS books_released
FROM
    books
GROUP BY released_year;

-- Print out the total number of books in stock

SELECT 
    SUM(stock_quantity) AS books_in_stock
FROM
    books;
    
-- Find the average released_year for each author 

SELECT 
    CONCAT(author_fname, ' ', author_lname) AS author,
    AVG(released_year)
FROM
    books
GROUP BY author;

-- Find the full name of the author who wrote the longest book

SELECT 
    CONCAT(author_fname, ' ', author_lname) AS author,
    MAX(pages)
FROM
    books
WHERE
    pages = (SELECT 
            MAX(pages)
        FROM
            books)
GROUP BY author;

-- Make a graph that is shown 

SELECT 
    released_year AS year, COUNT(title) AS '# books', AVG(pages) AS 'avg pages'
FROM
    books
GROUP BY year
ORDER BY year;