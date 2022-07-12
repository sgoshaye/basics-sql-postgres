/*
1. 
Let's combine non-aggregate column with aggregate column with OVER.
I also want to see number of employees partitioned by department after first name & department columns.
I also want to see number of employees partitioned by region.
*/

SELECT employees.first_name, employees.department, 
	COUNT(*) OVER(PARTITION BY employees.department) dept_count,
	regions.region,
	COUNT(*) OVER(PARTITION BY employees.region_id) region_count
FROM employees
LEFT JOIN regions 
ON employees.region_id = regions.region_id;

/*
2. 
Give running total of salaries partitioned by department.
*/

SELECT first_name, hire_date, 
SUM(salary) OVER(PARTITION BY department ORDER BY hire_date) as running_total_of_salaries 
FROM employees;

/*
3. 
Write a query to give a bonus to all employees of 
EACH department ranked as seventh largest salary.
*/

SELECT * FROM (SELECT first_name, department, salary,
			   RANK() OVER(PARTITION BY department ORDER BY salary DESC)
			   FROM employees) s
WHERE rank = 7;

/*
4.
Split each department into 5 salary brackets.
*/

SELECT first_name, department, salary,
NTILE(5) OVER(PARTITION BY department ORDER BY salary DESC) as salary_bracket
FROM employees;

/*
5.
What are the differences with GROUP BY GROUPING SETS, ROLLUP, and CUBE?
*/

--GROUPING SETS groups each column individually

SELECT continent, country, city, sum(units_sold)
FROM sales
GROUP BY GROUPING SETS(continent, country, city, ());

---ROLLUP groups all three columns, then two, then 1

SELECT continent, country, city, sum(units_sold)
FROM sales
GROUP BY ROLLUP(continent, country, city);

---CUBE gives all grouping by combinations

SELECT continent, country, city, sum(units_sold)
FROM sales
GROUP BY CUBE(continent, country, city);