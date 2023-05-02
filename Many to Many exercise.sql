-- TV series Challenge #1

SELECT 
    title, rating
FROM
    series
        JOIN
    reviews ON series.id = reviews.series_id;
    
-- TV series Challenge #2

SELECT 
    title, AVG(rating) AS avg_rating
FROM
    series
        JOIN
    reviews ON series.id = reviews.series_id
GROUP BY title
ORDER BY avg_rating DESC;

-- TV series Challenge #3

SELECT 
    first_name, last_name, rating
FROM
    reviewers
        JOIN
    reviews ON reviews.reviewer_id = reviewers.id;
    
-- TV series Challenge #4

SELECT 
    title AS unreviewed_series
FROM
    series
        LEFT JOIN
    reviews ON series.id = reviews.series_id
WHERE rating IS NULL;

-- TV series Challenge #5

SELECT 
    genre, AVG(rating) AS avg_rating
FROM
    series
        JOIN
    reviews ON series.id = reviews.series_id
GROUP BY genre
ORDER BY avg_rating;

-- TV series Challenge #6 

SELECT 
    first_name,
    last_name,
    COUNT(rating) AS number_of_rating,
    IFNULL(MIN(rating), 0) AS lowest_rating,
    IFNULL(MAX(rating), 0) AS highest_rating,
    ROUND(IFNULL(AVG(rating), 0), 2) AS avg_rating,
    CASE
        WHEN COUNT(rating) > 0 THEN 'ACVTIVE'
        ELSE 'INACTIVE'
    END AS status
FROM
    reviewers
        LEFT JOIN
    reviews ON reviewers.id = reviews.reviewer_id
GROUP BY first_name , last_name;

-- OR without the use of CASE

SELECT 
    first_name,
    last_name,
    COUNT(rating) AS number_of_rating,
    IFNULL(MIN(rating), 0) AS lowest_rating,
    IFNULL(MAX(rating), 0) AS highest_rating,
    ROUND(IFNULL(AVG(rating), 0), 2) AS avg_rating,
    IF(COUNT(rating) > 0,
        'ACTIVE',
        'INACTIVE') AS status
FROM
    reviewers
        LEFT JOIN
    reviews ON reviewers.id = reviews.reviewer_id
GROUP BY first_name , last_name;

-- TV series Challenge #7 

SELECT 
    title, rating, CONCAT(first_name, ' ', last_name)
FROM
    reviews
        JOIN
    series ON reviews.series_id = series.id
        JOIN
    reviewers ON reviews.reviewer_id = reviewers.id;