-- DATABASE
-- To create a Database
CREATE DATABASE my_database;

-- To use the database
USE my_database;

-- To Set the database in Read Only Mode
ALTER DATABASE my_database READ ONLY=1; 
ALTER DATABASE my_database READ ONLY=0;

-- To Delete Database
DROP DATABASE my_database;

-- To create a Table 
CREATE TABLE employees(
	emp_id INT,
    full_name VARCHAR(50),
    email VARCHAR(50),
    salary DECIMAL(6, 2)
);

-- To view the table
SELECT * FROM employees;

-- To Rename the table
RENAME TABLE employees TO workers;
RENAME TABLE workers TO employees;

-- To add column to the existing table
ALTER TABLE employees
ADD COLUMN joining_date DATE;

-- To rename the column
ALTER TABLE employees
RENAME COLUMN email TO email_id;

-- To modify the column datatype
ALTER TABLE employees
MODIFY email_id VARCHAR(75);

-- To change the column position
ALTER TABLE employees
MODIFY joining_date DATE AFTER email_id;

-- To Delete the column
ALTER TABLE employees
ADD COLUMN yearly_salary DECIMAL(8, 2);

ALTER TABLE employees
DROP COLUMN yearly_salary;

-- To Delete the Table
DROP TABLE employees;

-- INSERTING the values to the table
-- Insert the single value to the table
INSERT INTO employees VALUES(1, "Prabanjan", "praba@mail.com", "2025-03-01", 1500);

-- Insert the Multiple values to the table
INSERT INTO employees VALUES
(2, "Thirupathy", "thiru@mail.com", "2025-03-05", 1700),
(3, "Prasanth", "prasanth@mail.com", "2025-03-07", 1600),
(4, "RajKumar", "raj@mail.com", "2025-03-05", 1650);

-- Insert the specific column values
INSERT INTO employees(emp_id, full_name, salary) 
VALUES (5, "Sathish", 1550);

-- FIND the specific values
SELECT * FROM employees
WHERE emp_id = 2;

SELECT * FROM employees
WHERE salary > 1600;

SELECT full_name, email_id FROM employees
WHERE salary < 1600;

SELECT * FROM employees
WHERE joining_date IS NULL;

SELECT * FROM employees
WHERE joining_date IS NOT NULL;

-- Update the values in the table
UPDATE employees
SET email_id = "satz@gmail.com"
WHERE full_name = "Sathish";	-- Without WHERE clause it will update all rows to the email_id column

-- Delete the values
DELETE FROM employees;			-- Use WHERE clause bcoz its delete entire rows of the table

-- Delete the Rows
DELETE FROM employees
WHERE emp_id = 5;

DELETE FROM employees
WHERE salary < 1600;

SELECT * FROM employees;

-- UNDO THE LAST action
-- First set auto commit OFF
SET AUTOCOMMIT = OFF;

-- Commit the current changes incase we did some actions mistakenly we can undo it
COMMIT;

-- To undo the last action to get last commited changes
ROLLBACK;

-- Date and Time
-- DATE is the datatype
-- CURRENT_DATE() returns the current date (today)
-- CURRENT_TIME() returns the current time (now)
-- DATETIME is also datatype
-- NOW() returns the current date and time
-- we can manipulate the date and time
-- CURRENT_DATE() + 1 return the tomorrow
-- CURRENT_DATE() - 1 return the yesterday
-- CURRENT_TIME() + 60 return the current time with 60 seconds added

