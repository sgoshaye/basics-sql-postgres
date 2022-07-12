/*
1. 
Write a query that shows the student's name, the courses the 
student is taking and the professors that teach that course.
*/

SELECT student_name, courses.course_no, teach.last_name as professor
FROM students JOIN student_enrollment
ON students.student_no = student_enrollment.student_no
JOIN courses ON courses.course_no = student_enrollment.course_no
JOIN teach ON teach.course_no = courses.course_no
ORDER BY student_name;
       
/* 
2. 
How can we eliminate repeating data, also known as redundancy? 
Let's say we only care to see a single professor teaching a course 
and we don't care for all the other professors that teach the
particular course. Write a query that will accomplish this so that 
every record is distinct.
HINT: Using the DISTINCT keyword will not help. :-)
*/

SELECT student_name, course_number, min(professor)
FROM (SELECT student_name, courses.course_no course_number, teach.last_name as 	professor
      FROM students JOIN student_enrollment
      ON students.student_no = student_enrollment.student_no
      JOIN courses ON courses.course_no = student_enrollment.course_no
      JOIN teach ON teach.course_no = courses.course_no
      ORDER BY student_name) m
GROUP BY student_name, course_number
ORDER BY student_name, course_number;

/*
3.
Why are correlated subqueries slower that non-correlated subqueries and joins?
*/

/*
A "correlated subquery" (i.e., one in which the where condition 
depends on values obtained from the rows of the containing/outer query)
will execute once for each row. A non-correlated subquery (one in which 
the where condition is independent of the containing query) will execute 
once at the beginning. If a subquery needs to run for each row of the outer
query, that is slow.
*/

/*
4. 
In the video lectures, we've been discussing the employees table and the departments table. 
Considering those tables, write a query that returns employees whose salary 
is above average for their given department.
*/

SELECT first_name
FROM employees outer_emp
WHERE salary > (SELECT AVG(salary)
		FROM employees
      		WHERE department = outer_emp.department);

/* 
5.
Write a query that returns ALL of the students as well as 
any courses they may or may not be taking.
*/

SELECT student_name, student_enrollment.course_no
FROM students LEFT OUTER JOIN student_enrollment 
ON students.student_no = student_enrollment.student_no;
