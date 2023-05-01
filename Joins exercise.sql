-- Joins exercise

-- Write this schema:
-- 		Students: id, first_name
-- 		Papers: title, grade, student_id
-- 		id and student_id are linked

CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50)
);
    
CREATE TABLE papers (
    title VARCHAR(100),
    grade INT,
    student_id INT,
    FOREIGN KEY (student_id)
        REFERENCES students (id)
);

-- Insert data into the table 

INSERT INTO students (first_name) VALUES 
('Caleb'), ('Samantha'), ('Raj'), ('Carlos'), ('Lisa');

INSERT INTO papers (student_id, title, grade ) VALUES
(1, 'My First Book Report', 60),
(1, 'My Second Book Report', 75),
(2, 'Russian Lit Through The Ages', 94),
(2, 'De Montaigne and The Art of The Essay', 98),
(4, 'Borges and Magical Realism', 89);

-- Print what is shown on screen
-- I.E. first_name, title, grade 

SELECT 
    first_name, title, grade
FROM
    students
        JOIN
    papers ON students.id = papers.student_id
ORDER BY grade DESC;

-- Print what is shown on screen
-- I.E. first_name, title, grade with null values shown in title and grade 

SELECT 
    first_name, title, grade
FROM
    students
        LEFT JOIN
    papers ON students.id = papers.student_id
ORDER BY grade DESC;

-- Print what is shown on screen
-- I.E. first_name, title, grade wiht null values shown in title and grade 
-- where if no title says 'MISSING' and no grade is 0

SELECT 
    first_name, IFNULL(title, 'MISSING') AS title, IFNULL(grade, 0) AS grade
FROM
    students
        LEFT JOIN
    papers ON students.id = papers.student_id
ORDER BY grade DESC;

-- Print what is shown on screen
-- I.E. first_name, average

SELECT 
    first_name, IFNULL(AVG(grade), 0) as average
FROM
    students
        LEFT JOIN
    papers ON students.id = papers.student_id
GROUP BY first_name
ORDER BY AVG(grade) DESC;

-- Print what is shown on screen 
-- I.E. first_name, average, passing_status
-- passing_status is a grade above 75

SELECT 
    first_name,
    IFNULL(AVG(grade), 0) AS average,
    CASE
        WHEN IFNULL(AVG(grade), 0) >= 75 THEN 'PASSING'
        ELSE 'FAILING'
    END AS passing_status
FROM
    students
        LEFT JOIN
    papers ON students.id = papers.student_id
GROUP BY first_name
ORDER BY AVG(grade) DESC;