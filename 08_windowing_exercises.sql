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
LEFT JOIN regions ON employees.region_id = regions.region_id;

/*
2. 
Give running total of salaries partitioned by department.
*/

SELECT first_name, hire_date, SUM(salary) OVER(PARTITION BY department ORDER BY hire_date) as running_total_of_salaries 
FROM employees;

/*
3. 
Write a query to give a bonus to all employees of 
EACH department ranked as seventh largest salary.
*/

SELECT * FROM (SELECT first_name, department, salary,
	       RANK() OVER(PARTITION BY department ORDER BY salary DESC) FROM employees) s
WHERE rank = 7;

/*
4.
Split each department into 5 salary brackets.
*/

SELECT first_name, department, salary, NTILE(5) OVER(PARTITION BY department ORDER BY salary DESC) as salary_bracket
FROM employees;

/*
5.
Run this script to create a sales table. 

How would grouping by GROUPING SETS, ROLLUP, and CUBE for the sum of the units sold by continent, country, & city?:

CREATE TABLE sales
(
	continent varchar(20),
	country varchar(20),
	city varchar(20),
	units_sold integer
);

INSERT INTO sales VALUES ('North America', 'Canada', 'Toronto', 10000);
INSERT INTO sales VALUES ('North America', 'Canada', 'Montreal', 5000);
INSERT INTO sales VALUES ('North America', 'Canada', 'Vancouver', 15000);
INSERT INTO sales VALUES ('Asia', 'China', 'Hong Kong', 7000);
INSERT INTO sales VALUES ('Asia', 'China', 'Shanghai', 3000);
INSERT INTO sales VALUES ('Asia', 'Japan', 'Tokyo', 5000);
INSERT INTO sales VALUES ('Europe', 'UK', 'London', 6000);
INSERT INTO sales VALUES ('Europe', 'UK', 'Manchester', 12000);
INSERT INTO sales VALUES ('Europe', 'France', 'Paris', 5000);
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
