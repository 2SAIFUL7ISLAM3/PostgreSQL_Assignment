
--Table Creation:

CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,  -- Automatically generates unique identifiers for students
    student_name VARCHAR(100) NOT NULL,  -- String for student's name
    age INTEGER NOT NULL,  -- Integer for student's age
    email VARCHAR(255) NOT NULL,  -- String for student's email address
    frontend_mark INTEGER,  -- Integer for frontend assignment marks
    backend_mark INTEGER,  -- Integer for backend assignment marks
    status VARCHAR(20)  -- String for result status (e.g., "Passed", "Failed")
);

CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,  -- Automatically generates unique course identifiers
    course_name VARCHAR(100) NOT NULL,  -- String for the course's name
    credits INTEGER NOT NULL  -- Integer for the number of credits
);

CREATE TABLE enrollment (
    enrollment_id SERIAL PRIMARY KEY,  -- Automatically generates unique enrollment identifiers
    student_id INTEGER REFERENCES students(student_id) ON DELETE CASCADE,  -- Foreign key referencing students
    course_id INTEGER REFERENCES courses(course_id) ON DELETE CASCADE  -- Foreign key referencing courses
);


-- Insert the following sample data into the "students" table: 

INSERT INTO students (student_id, student_name, age, email, frontend_mark, backend_mark, status) VALUES
(1, 'Sameer', 21, 'sameer@example.com', 48, 60, NULL),
(2, 'Zoya', 23, 'zoya@example.com', 52, 58, NULL),
(3, 'Nabil', 22, 'nabil@example.com', 37, 46, NULL),
(4, 'Rafi', 24, 'rafi@example.com', 41, 40, NULL),
(5, 'Sophia', 22, 'sophia@example.com', 50, 52, NULL),
(6, 'Hasan', 23, 'hasan@gmail.com', 43, 39, NULL);

--Insert the following sample data into the "courses" table:

INSERT INTO courses (course_id, course_name, credits) VALUES
(1, 'Next.js', 3),
(2, 'React.js', 4),
(3, 'Databases', 3),
(4, 'Prisma', 3);

--Insert the following sample data into the "enrollment" table:

INSERT INTO enrollment (enrollment_id, student_id, course_id) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 2, 1),
(4, 3, 2);

--Query 1:

INSERT INTO students (student_id,student_name, age, email, frontend_mark, backend_mark, status) VALUES
(7,'saiful islam', 25, 'saiful.islam@example.com', 45, 50, NULL);

--Query 2:

SELECT s.student_name
FROM students s
JOIN enrollment e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE c.course_name = 'Next.js';

--Query 3:

UPDATE students
SET status = 'Awarded'
WHERE student_id = (
    SELECT student_id
    FROM students
    ORDER BY (frontend_mark + backend_mark) DESC
    LIMIT 1
);

--Query 4:

DELETE FROM courses
WHERE NOT EXISTS (
    SELECT 1
    FROM enrollment e
    WHERE e.course_id = courses.course_id
);

--Query 5:

SELECT student_name
FROM students
ORDER BY student_id 
OFFSET 2 LIMIT 2;

--Query 6:

SELECT c.course_name, COUNT(e.student_id) AS students_enrolled
FROM courses c
LEFT JOIN enrollment e ON c.course_id = e.course_id
GROUP BY c.course_name;

--Query 7:

SELECT AVG(age) AS average_age
FROM students;

--Query 8:

SELECT student_name
FROM students
WHERE email LIKE '%example.com%';
