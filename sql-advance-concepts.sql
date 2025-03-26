USE my_database;

-- AGGREGATING Functions
SELECT AVG(salary) FROM employees;
SELECT MIN(salary) FROM employees;
SELECT MAX(salary) FROM employees;
SELECT COUNT(salary) FROM employees;
SELECT CONCAT(full_name," ", email_id) AS name_email FROM employees;

-- LOGICAL OPERATORS using check the two conditions 
SELECT * FROM employees
WHERE full_name = "Prabanjan" AND salary > 1400;

SELECT * FROM employees
WHERE full_name = "Prabanjan" OR salary = 1800;

SELECT * FROM employees
WHERE NOT full_name = "Prabanjan";

SELECT * FROM employees
WHERE salary BETWEEN 1400 AND 1600;

SELECT * FROM employees
WHERE email_id IN ("praba@mail.com");

-- WILD CARD CHARACTERS to find the values
SELECT * FROM employees
WHERE full_name LIKE "%ra%";

SELECT * FROM employees
WHERE full_name LIKE "___san%";

-- ORDER BY ASC & DESC orders of the table
SELECT * FROM employees ORDER BY salary;
SELECT * FROM employees ORDER BY salary DESC;

-- LIMIT Clause
SELECT * FROM employees LIMIT 3;
SELECT * FROM employees LIMIT 2, 3;
-- LIMIT Clause with ORDER BY
SELECT * FROM employees ORDER BY emp_id DESC LIMIT 3;

-- GROUP BY the values by particular column based
SELECT AVG(salary), joining_date FROM employees GROUP BY joining_date;

SELECT AVG(salary), joining_date FROM employees 
GROUP BY joining_date HAVING joining_date != "2025-03-05";

-- ROLLUP with GROUP BY Clause
SELECT SUM(salary), joining_date FROM employees
GROUP BY joining_date WITH ROLLUP;