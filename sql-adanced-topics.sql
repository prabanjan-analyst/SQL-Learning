USE my_database;

-- VIEW its a virtual table 
CREATE VIEW employees_data AS
SELECT full_name, email_id, salary FROM employees;

SELECT * FROM employees_data;

-- To insert a data to the original table, this virtual table get updated
INSERT INTO employees VALUES
(6, "ManojKumar", "mano@mail.com", "2025-03-07", 1600, 2);

-- To delete/drop the view
DROP VIEW employees_data;

-- To create INDEX for fast querying
-- To show the all indexes from this table
SHOW INDEXES FROM employees;

-- To create INDEX on which colum based
CREATE INDEX full_name_idx 
ON employees(full_name);

-- To drop the INDEX
ALTER TABLE employees
DROP INDEX full_name_idx;

-- To create a STORED PRODCEDURE Just like a function
DELIMITER $$ -- We are using ; inbetween the query so change the delimiter to $$
CREATE PROCEDURE get_emp_info()
BEGIN
	SELECT full_name, email_id, salary FROM employees;
END $$
DELIMITER ; -- To back the delimiter is ;

-- To invoke the function
CALL get_emp_info();

-- Procedure with parameter & arg
DELIMITER $$
CREATE PROCEDURE high_paid_emp(high_pay DECIMAL(6, 2))
BEGIN
	SELECT * FROM employees
    WHERE salary > high_pay;
END $$
DELIMITER ;

CALL high_paid_emp(1600);

-- To delete/drop the procedure -- no need () to delete a procedure
DROP PROCEDURE get_emp_info;

-- TRIGGERS
CREATE TRIGGER update_emp
BEFORE UPDATE ON employees			-- When the event was trigger before/after
FOR EACH ROW						-- NOT only specific row each row we can update with this trigger
SET NEW.salary = NEW.salary * 1.1;	-- NEW means your updated salary with *
-- When you will update the salary 
-- it will automatically update the salary with 10% hike

SELECT * FROM employees;

UPDATE employees
SET salary = 1700		-- You update 1700 it will update with 10% extra
WHERE emp_id = 1;

-- To delete/drop the trigger
DROP TRIGGER update_emp;

-- ON DELETE SET NULL
-- First we drop the Foreign Key
ALTER TABLE transactions
DROP FOREIGN KEY transac_id_fk;

-- Add this ON DELETE SET NULL to the existing table
ALTER TABLE transactions
ADD CONSTRAINT transac_id_fk FOREIGN KEY(product_id)
REFERENCES products(product_id)
ON DELETE SET NULL; 

-- Now product_id 4 is deleted in products 
-- and set the null value to the transactions table
DELETE FROM products WHERE product_id = 4;
SELECT * FROM products;
SELECT * FROM transactions;

-- ON DELETE CASCADE
-- First we drop the Foreign Key
ALTER TABLE transactions
DROP FOREIGN KEY transac_id_fk;

-- Add this ON DELETE CASCADE to the existing table
ALTER TABLE transactions
ADD CONSTRAINT transac_id_fk FOREIGN KEY(product_id)
REFERENCES products(product_id)
ON DELETE CASCADE; 

-- Now product_id 3 is deleted in products 
-- and it will delete the entire row in the transactions table
DELETE FROM products WHERE product_id = 3;
SELECT * FROM products;
SELECT * FROM transactions;