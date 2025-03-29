-- ------------- DATABASE Queries ------------------ --
-- To Create a new DataBase
CREATE DATABASE new_database;

-- To Use the DataBase
USE new_database;

-- Change the mode of the DataBase
ALTER DATABASE new_database READ ONLY = 1;
ALTER DATABASE new_database READ ONLY = 0;

-- To Drop/Delete a DataBase
DROP DATABASE new_database;

-- -------------- TABLE Queries ------------------- --
-- To create a New Table
CREATE TABLE employees(
	emp_id INT,
    full_name VARCHAR(50),
    salary DECIMAL(6, 2),
    per_day DECIMAL(4, 2),
    joining_date DATE
);

-- To view the Table Data
SELECT * FROM employees;

-- To Rename the Table name
RENAME TABLE employees TO company_staffs;

-- To Drop/Delete the Table
DROP TABLE employees;

-- ------------- COLUMN Queries ---------------- --
-- To Add a Column to the Existing Table
ALTER TABLE employees 
ADD COLUMN email VARCHAR(50);

-- To Change the Position of Column
ALTER TABLE employees
MODIFY email VARCHAR(50) AFTER full_name;

-- To Rename the Column
ALTER TABLE employees
RENAME COLUMN email TO email_id;

-- To Change the DataType of the Column
ALTER TABLE employees
MODIFY COLUMN per_day INT;

-- To Drop/Delete the Column
ALTER TABLE employees
DROP COLUMN per_day;

SELECT * FROM employees;

-- ------------- ROW Queries -------------- --
-- To Insert the Single New Row/Data to the Table
INSERT INTO employees 
VALUES(1, "Prabanjan", "praba@mail.com", 2000, "2025-03-01");

-- To Insert the Many New Rows/Data's to the Table
INSERT INTO employees VALUES
(2, "Thirupathy", "thiru@mail.com", 1800, "2025-03-05"),
(3, "Prasanth", "manas@mail.com", 1700, "2025-03-10"),
(4, "RajKumar", "raj@mail.com", 1500, "2025-03-05");

-- To Insert the required Data only
INSERT INTO employees(emp_id, full_name) 
VALUES(5, "Sathish");

SELECT * FROM employees;

-- To view the Particular Column
SELECT full_name, email_id FROM employees;

-- To Give the Alias Name to the Column
SELECT full_name AS "Employee_Name" FROM employees;

-- To Find the Row's by Giving specific data
SELECT * FROM employees
WHERE emp_id = 2;

-- To Find the Row's by Giving Conditions
SELECT * FROM employees
WHERE salary > 1600;

-- To Find the NULL value Row's
SELECT * FROM employees
WHERE salary IS NULL;

-- To Find the NOT NULL value Row's
SELECT * FROM employees
WHERE salary IS NOT NULL;

-- To Update the Row using WHERE Clause 
-- Otherwise it will update ALL Row's with the same value
UPDATE employees
SET email_id = "satz@mail.com"
WHERE full_name = "Sathish";

SELECT * FROM employees;

-- UNDO the Last Query
-- First set the AutoCommit OFF
SET AUTOCOMMIT = OFF;

-- Commit the Current/last Changes
COMMIT;

-- To DELETE the entire Row's of the Table
DELETE FROM employees;
SELECT * FROM employees;

-- To UNDO the last Query to get Committed Changes
ROLLBACK;

-- To Delete the Row by the Giving Data or Condition
DELETE FROM employees WHERE salary IS NULL;
SELECT * FROM employees;

-- --------------- DATE functions ------------------ --
-- CURRENT_DATE() gives Today Date, We can manipulate this dates
INSERT INTO employees VALUES
(5, "Sathish", "satz@mail.com", NULL, CURRENT_DATE()),
(6, "ManojKumar", "mano@mail.com", 1650, CURRENT_DATE() - 19);
-- CURRENT_DATE() + 1 means Tomorrow
-- CURRENT_DATE() - 1 means Yesterday
-- CURRENT_TIME() gives the exact time also manipulate with seconds
-- NOW() gives the current date and time, Its a DATETIME datatype 

-- -------------- LIMITS, ORDER BY -------------- --
SELECT * FROM employees;

-- To Limit the Row's by giving number
SELECT * FROM employees LIMIT 3;

-- To Limit the Row's by giving step and limit number
-- It return the limited value after the steping value row
SELECT * FROM employees LIMIT 2, 3;

-- To Order the Row's by the specific column by Ascending Order
SELECT * FROM employees ORDER BY emp_id;

-- To Order the Row's by the specific column by descending Order
SELECT * FROM employees ORDER BY emp_id DESC;

-- To Order the Limited Row's 
SELECT * FROM employees ORDER BY emp_id DESC LIMIT 2, 3;

-- -------------- WILD CARD Characters ---------------- --
-- To find the Row whatever characters are after the input
SELECT * FROM employees 
WHERE full_name LIKE "Pr%";

-- To find the Row whatever characters are in between the input
SELECT * FROM employees 
WHERE full_name LIKE "%asa%";

-- To find the Limited number of character before the input
SELECT * FROM employees
WHERE full_name LIKE "_____pathy";

-- To combine both to find the row
SELECT * FROM employees
WHERE full_name LIKE "_ra%";

-- --------------- LOGICAL OPERATORS ----------------- --
-- Both conditions are True then return the value
SELECT * FROM employees
WHERE salary >= 1700 AND joining_date = "2025-03-10";

-- Any one condition is True then return the value
SELECT * FROM employees
WHERE salary >= 1700 OR joining_date = "2025-03-10";

-- To return the Opposite values of the condition
SELECT * FROM employees
WHERE NOT salary > 1800; 

-- To apply AND Conditon in the same column 
SELECT * FROM employees
WHERE salary BETWEEN 1500 AND 1800;

-- -------------- AGGREGATE Functions -------------- --
-- To Find the Average value of the column
SELECT AVG(salary) AS Avg_Salary FROM employees;

-- To Find the Minimum value of the column
SELECT MIN(salary) AS Min_Salary FROM employees;

-- To Find the Maximum value of the column
SELECT MAX(salary) AS Max_Salary FROM employees;

-- To Find the Total/Sum value of the column
SELECT SUM(salary) AS Total_Salary FROM employees;

-- To Find the Number/Count of values in the column
SELECT COUNT(emp_id) AS Emp_Count FROM employees;

-- To Concatinate/Combine the TWO columns
SELECT CONCAT(full_name, " - $.",salary) AS Emp_Info FROM employees
WHERE salary IS NOT NULL;

-- To find the Row's by grouping
SELECT AVG(salary) AS Avg_Salary, joining_date FROM employees
GROUP BY joining_date;

-- Aggregated fn apply to the Aggregated column values return with extra row
SELECT SUM(salary) AS Total_salary, joining_date FROM employees
GROUP BY joining_date WITH ROLLUP;

-- To find the Row's by Grouping with conditions WHERE=>HAVING
SELECT AVG(salary) AS Avg_Salary, joining_date FROM employees
GROUP BY joining_date HAVING Avg_Salary IS NOT NULL;

-- ------------------ SUB QUERIES ----------------- --
-- The return value of SUB Query is take as a value
SELECT salary, (SELECT AVG(salary) FROM employees) AS Avg_Emp_Salary 
FROM employees WHERE salary IS NOT NULL;

SELECT emp_id, full_name, email_id FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- ----------------- CONSTRAINTS ------------------ --
-- ----------------- PRIMARY KEY ------------------ --
-- To add primary key constraint while creating a table
CREATE TABLE employees(
	emp_id INT PRIMARY KEY,
    full_name VARCHAR(50),
    email_id VARCHAR(50),
    salary DECIMAL(6, 2),
    joining_date DATE
);

-- To add primary key constraint to the existing table
ALTER TABLE employees
ADD CONSTRAINT PRIMARY KEY(emp_id);

-- To Drop the Primary Key
ALTER TABLE employees
DROP PRIMARY KEY;

-- ----------------- AUTO INCREMENT ------------------ --
-- To add auto increment while creating a table
-- Its not a constaint and only used with PRIMARY KEY
CREATE TABLE employees(
	emp_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(50),
    email_id VARCHAR(50),
    salary DECIMAL(6, 2),
    joining_date DATE
);

-- To set auto increment starting value
ALTER TABLE employees
AUTO_INCREMENT = 1001;

-- ----------------- UNIQUE ------------------ --
-- To add unique constaint while creating a table
CREATE TABLE employees(
	emp_id INT PRIMARY KEY,
    full_name VARCHAR(50) UNIQUE,
    email_id VARCHAR(50),
    salary DECIMAL(6, 2),
    joining_date DATE
);

-- To add unique constraint to the existing table
ALTER TABLE employees
ADD CONSTRAINT UNIQUE(full_name);

-- ----------------- DEFAULT -------------- --
-- To add default constaint while creating a table
CREATE TABLE employees(
	emp_id INT PRIMARY KEY,
    full_name VARCHAR(50) UNIQUE,
    email_id VARCHAR(50),
    salary DECIMAL(6, 2),
    joining_date DATE,
    reports_to INT DEFAULT 1
);

-- To add default constraint to the existing table
ALTER TABLE employees
ALTER reports_to SET DEFAULT 1;

INSERT INTO employees(emp_id, full_name, salary, joining_date) 
VALUES(1, "Prabanjan", 2000, CURRENT_DATE() - 28);

-- --------------- NOT NULL ----------------- --
-- To add not null constaint while creating a table
CREATE TABLE employees(
	emp_id INT PRIMARY KEY,
    full_name VARCHAR(50) UNIQUE,
    email_id VARCHAR(50) NOT NULL,
    salary DECIMAL(6, 2),
    joining_date DATE,
    reports_to INT DEFAULT 1
);

INSERT INTO employees 
VALUES(1, "Prabanjan", NULL, 2000, CURRENT_DATE() - 28, NULL);

-- To add not null constraint to the existing table
ALTER TABLE employees
MODIFY email_id VARCHAR(50) NOT NULL;

-- ----------------- CHECK ------------------ --
-- To add check constaint while creating a table
CREATE TABLE employees(
	emp_id INT PRIMARY KEY,
    full_name VARCHAR(50) UNIQUE,
    email_id VARCHAR(50) NOT NULL,
    salary DECIMAL(6, 2),
    joining_date DATE,
    reports_to INT DEFAULT 1,
    CONSTRAINT chk_salary CHECK(salary >= 1000)
);

INSERT INTO employees 
VALUES(1, "Prabanjan", "praba@mail.com", 900, CURRENT_DATE() - 28, NULL);

-- To add check constraint to the existing table
ALTER TABLE employees
ADD CONSTRAINT chck_salary CHECK(salary >= 1000);

-- To Drop/Delete the Check Constraint
ALTER TABLE employees
DROP CHECK chck_salary;

-- ------------------ FOREIGN KEY ------------------- --
-- To add foreign key constaint while creating a table
CREATE TABLE managers(
	manager_id INT PRIMARY KEY,
    full_name VARCHAR(50),
    email_id VARCHAR(50)
);

CREATE TABLE employees(
	emp_id INT PRIMARY KEY,
    full_name VARCHAR(50) UNIQUE,
    email_id VARCHAR(50) NOT NULL,
    salary DECIMAL(6, 2),
    joining_date DATE,
    reports_to INT DEFAULT 1,
    CONSTRAINT chk_salary CHECK(salary >= 1000),
    CONSTRAINT reports_to_fk FOREIGN KEY(reports_to) REFERENCES managers(manager_id)
);

-- To add foreign key constraint to the existing table
ALTER TABLE employees
ADD CONSTRAINT report_to_fk FOREIGN KEY(reports_to) REFERENCES managers(manager_id);

-- To Drop/Delete the Foreign Key
ALTER TABLE employees
DROP FOREIGN KEY report_to_fk;

-- ------------- ADD SOME DATA TO PERFORM JOINS ------------- --

INSERT INTO employees 
VALUES(1, "Prabanjan", "praba@mail.com", 2000, CURRENT_DATE() - 28, NULL),
(2, "Thirupathy", "thiru@mail.com", 1800, "2025-03-05", 1),
(3, "Prasanth", "manas@mail.com", 1700, "2025-03-10", 2),
(4, "RajKumar", "raj@mail.com", 1500, "2025-03-05", 2),
(5, "Sathish", "satz@mail.com", 1600, "2025-03-10", NULL);

INSERT INTO managers VALUES
(1, "ManojKumar", "mano@mail.com"),
(2, "Gokul", "gokul@mail.com"),
(3, "Sathish", "satz@mail.com");

-- --------------------- JOINS ---------------------------- --
-- -------------------INNER JOIN -------------------------- --
-- Joins the both table based on the related column by the FOREIGN KEY
SELECT * FROM employees INNER JOIN managers 
ON employees.reports_to = managers.manager_id; 

-- Selected columns in both tables
SELECT emp.emp_id, emp.full_name, emp.email_id, man.full_name AS Reports_to, man.email_id 
	FROM employees AS emp INNER JOIN managers AS man
ON emp.reports_to = man.manager_id; 

-- -------------------LEFT JOIN -------------------------- --
-- Joins the both table based on the related column by the FOREIGN KEY
-- By displaying everything on the LEFT table
SELECT * FROM employees LEFT JOIN managers 
ON employees.reports_to = managers.manager_id; 

-- Selected columns in both tables
SELECT emp.emp_id, emp.full_name, emp.email_id, man.full_name AS Reports_to, man.email_id 
	FROM employees AS emp LEFT JOIN managers AS man
ON emp.reports_to = man.manager_id; 

-- -------------------RIGHT JOIN -------------------------- --
-- Joins the both table based on the related column by the FOREIGN KEY
-- By displaying everything on the RIGHT table
SELECT * FROM employees RIGHT JOIN managers 
ON employees.reports_to = managers.manager_id; 

-- Selected columns in both tables
SELECT emp.emp_id, emp.full_name, emp.email_id, man.full_name AS Reports_to, man.email_id 
	FROM employees AS emp RIGHT JOIN managers AS man
ON emp.reports_to = man.manager_id; 

-- -------------------SELF JOIN -------------------------- --
-- Join the same table having a related values
SELECT * FROM employees AS a INNER JOIN employees AS b
ON a.reports_to = b.emp_id;

-- Selected columns in same table
SELECT a.emp_id, a.full_name, a.email_id, a.reports_to, b.full_name AS Report_to
	FROM employees AS a INNER JOIN employees AS b
ON a.reports_to = b.emp_id;

-- ------------------------- VIEW --------------------------- --
-- Its a virtual table, it will update automatically when the real table get updates
CREATE VIEW emp_info AS
SELECT emp_id, full_name, email_id, joining_date FROM employees;

-- To invoke the VIEW table
SELECT * FROM emp_info;

-- To Drop/Delete the view table
DROP VIEW emp_info;

-- ------------------------ INDEX ------------------------- --
-- To show all the indexes of the table
SHOW INDEXES FROM employees;

-- To create an index to the specific column
CREATE INDEX email_id_idx 
ON employees(email_id);

-- To Drop/Delete index
ALTER TABLE employees
DROP INDEX email_id_idx;

-- -------------------- STORED PROCEDURE ----------------------- --
-- To create procedure
-- DELIMITER are used to change the delimiter ; to $ because we use ; inbetween the query
DELIMITER $$
CREATE PROCEDURE high_paid_emp()
BEGIN
	SELECT * FROM employees WHERE salary > (SELECT AVG(salary) FROM employees);
END $$
DELIMITER ;

-- To invoke the procedure
CALL high_paid_emp();

-- To Drop/Delete the Procedure
DROP PROCEDURE high_paid_emp;

-- To create procedure with parameter and argument
DELIMITER $$
CREATE PROCEDURE find_emp(employee_id INT)
BEGIN
	SELECT * FROM employees WHERE emp_id = employee_id;
END $$
DELIMITER ;

-- To invoke the procedure with valid argument
CALL find_emp(5);

-- To Drop/Delete the Procedure
DROP PROCEDURE find_emp;

-- ------------------- TRIGGERS ------------------------- --
-- To create a trigger (BEFORE/AFTER  ==== INSERT, UPDATE, DELETE)
CREATE TRIGGER salary_with_bonus
BEFORE UPDATE ON employees 				-- MENTION THE EVENT AND WHEN ITS TRIGGERED
FOR EACH ROW							-- FOR EACH ROW means EVERY ROW on that table
SET NEW.salary = NEW.salary * 1.1;		-- NEW means updated input

-- To check salary before updating 
SELECT * FROM employees;

-- To update the salary, trigger will trigger the event 
UPDATE employees SET salary = 2100 WHERE emp_id = 1;

-- To show the all Triggers
SHOW TRIGGERS;

-- --------------------ON DELETE SET NULL ------------------- --
-- First Delete the FOREIGN KEY 
-- Delete the another table row it will set the null value to the related row on this table
CREATE TABLE employees(
	emp_id INT PRIMARY KEY,
    full_name VARCHAR(50) UNIQUE,
    email_id VARCHAR(50) NOT NULL,
    salary DECIMAL(6, 2),
    joining_date DATE,
    reports_to INT DEFAULT 1,
    CONSTRAINT chk_salary CHECK(salary >= 1000),
    CONSTRAINT reports_to_fk FOREIGN KEY(reports_to) REFERENCES managers(manager_id)
    ON DELETE SET NULL
);

-- To add on delete set null constraint to the existing table
ALTER TABLE employees
ADD CONSTRAINT report_to_fk FOREIGN KEY(reports_to) REFERENCES managers(manager_id)
ON DELETE SET NULL;

-- --------------------ON DELETE CASCADE ------------------- --
-- First Delete the FOREIGN KEY 
-- Delete the another table row it will DELETE the entire related row of this table
CREATE TABLE employees(
	emp_id INT PRIMARY KEY,
    full_name VARCHAR(50) UNIQUE,
    email_id VARCHAR(50) NOT NULL,
    salary DECIMAL(6, 2),
    joining_date DATE,
    reports_to INT DEFAULT 1,
    CONSTRAINT chk_salary CHECK(salary >= 1000),
    CONSTRAINT reports_to_fk FOREIGN KEY(reports_to) REFERENCES managers(manager_id)
    ON DELETE CASCADE
);

-- To add on delete set null constraint to the existing table
ALTER TABLE employees
ADD CONSTRAINT report_to_fk FOREIGN KEY(reports_to) REFERENCES managers(manager_id)
ON DELETE CASCADE;

-- ================================= THE END ========================================== --