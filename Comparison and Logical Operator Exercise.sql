-- Evaluate the following 

-- 1) SELECT 10 != 10;
-- 2) SELECT 15 > 14 AND 99 - 5 <= 94;
-- 3) SELECT 1 IN (5,3) OR 9 BETWEEN 8 AND 10;

-- 1) Will return 0 as statement is false 
-- 2) Will return 1 as statement is true 
-- 3) Will return 1 as a statement is true

-- Select all books written before 1980 (non inclusive)

SELECT 
    *
FROM
    books
WHERE
    released_year < 1980;
    
-- Select all books written by Eggers or Chabon

SELECT 
    *
FROM
    books
WHERE
    author_lname = 'Eggers' OR 'Chabon';

-- Select all books written by Lahiri published after 2000

SELECT 
    *
FROM
    books
WHERE
    author_lname = 'Lahiri'
        AND released_year > 2000;
        
-- Select all books with page counts between 100 and 200

SELECT 
    *
FROM
    books
WHERE
    pages BETWEEN 100 AND 200;
    
-- Select all books where author_lname starts with a 'C' or an 'S'

SELECT 
    *
FROM
    books
WHERE
    author_lname LIKE 'C%'
        OR author_lname LIKE 'S%';
    
-- If title contains 'stories' -> short stories 
-- Just Kids and A Heartbreaking Work -> Memoir
-- Everything Else -> Novel

SELECT 
    title,
    author_lname,
    CASE
        WHEN title LIKE '%stories%' THEN 'Short Stories'
        WHEN
            title = 'Just Kids'
                OR 'A Heartbreaking Work of Staggering Genius'
        THEN
            'Memoir'
        ELSE 'Novel'
    END AS type
FROM
    books;