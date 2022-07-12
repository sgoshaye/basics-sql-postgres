/*
1.
Using subqueries only, write a SQL statement that returns the names of those students that are taking the courses Physics and US History.
       NOTE: Do not jump ahead and use joins. I want you to solve this problem using only what you've learned in this section.
       SELECT student_name
*/

FROM students WHERE student_no 
IN (SELECT student_no 
	FROM student_enrollment
	WHERE course_no IN (SELECT course_no 
						FROM courses 
						WHERE course_title 
						IN ('Physics', 'US History')));

/*
Using subqueries only, write a query that returns the name of the student that is taking the highest number of courses.
NOTE: Do not jump ahead and use joins. I want you to solve this problem using only what you've learned in this section. 
*/

SELECT student_name 
FROM students 
WHERE student_no 
IN (SELECT student_no 
	FROM(SELECT student_no, COUNT(course_no) course_cnt
		 FROM STUDENT_ENROLLMENT        
		 GROUP BY student_no         
		 ORDER BY course_cnt desc         
		 LIMIT 1) a);

/* 
3.
Write a query to find the student that is the oldest. 
You are not allowed to use LIMIT or the ORDER BY clause to solve this problem.
*/

SELECT *
FROM students
WHERE age = (SELECT MAX(age) FROM students)