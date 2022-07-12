/*
1.
Get all employees whose salaries are above average departmental salary.
That is, they make more than the average of their departments.
Form a relationship and cause it to be correlated.

Also, note the, inner query runs for every single record of the outer query
because we are forming link of departments in outer and inner department.

Get average of clothing department and then it compares it to the average.
Inner subquery uses information obtained from outer query.
CORRELATED SUBQUERY RUN FOR EVERY SINGLE RECORD OF THE OUTER QUERY
*/

SELECT first_name, salary
FROM employees e1
WHERE salary > (SELECT round(AVG(salary))
		FROM employees e2 WHERE e1.department = e2.department);

-- ALSO CAN DO IT THIS WAY

SELECT first_name, salary, department, (SELECT round(AVG(salary))
					FROM employees e2 WHERE e1.department = e2.department) as avg_department_salary 
FROM employees e1;
