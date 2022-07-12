/* Problem 1. 
Write a query that finds students who do not take CS180.
*/

SELECT * FROM students
WHERE student_no NOT IN (SELECT student_no
						 FROM student_enrollment
						 WHERE course_no = 'CS180');

/* Problem 2. 
Write a query to find students who take CS110 or CS107 but not both.
*/

SELECT s.*
FROM students s JOIN student_enrollment se
ON s.student_no = se.student_no
AND se.course_no IN ('CS110', 'CS107')
AND s.student_no NOT IN (SELECT a.student_no
						 FROM student_enrollment a JOIN student_enrollment b
						 ON a.student_no = b.student_no
						 AND a.course_no = 'CS110'
						 AND b.course_no = 'CS107');

/*
Problem 3. 
Write a query to find students who take CS220 and no other courses.
*/

SELECT s.*
FROM students s JOIN student_enrollment se
ON s.student_no = se.student_no
AND s.student_no NOT IN (SELECT student_no
						 FROM student_enrollment
						 WHERE course_no != 'CS220');

/*
Problem 4. 
Write a query that finds those students who take at most 2 courses.
Your query should exclude students that don't take any courses as well
as those that take more than 2 course.
*/

SELECT s.student_no, s.student_name, s.age
FROM students s JOIN student_enrollment se
ON s.student_no = se.student_no
GROUP BY s.student_no, s.student_name, s.age
HAVING COUNT(*) <= 2;

/*
Problem 5. 
Write a query to find students who are older than at most two other students.
*/

SELECT s1.*
FROM students s1
WHERE 2 >= (SELECT count(*)
			FROM students s2
			WHERE s2.age < s1.age);