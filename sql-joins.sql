USE my_database;

-- ------------- JOINS --------------- --

CREATE TABLE products(
	product_id INT PRIMARY KEY,
    product_name VARCHAR(50) UNIQUE
);
INSERT INTO products VALUES
(1, "IPhone 13"),
(2, "Samsung S24"),
(3, "Nokia Lumia"),
(4, "One Plus");

INSERT INTO transactions(amount, transaction_date, product_id) VALUES
(1500, CURRENT_DATE() - 3, 2),
(1200, CURRENT_DATE() - 2, 3),
(1600, CURRENT_DATE(), 1),
(1550, CURRENT_DATE() -3, 4),
(1600, CURRENT_DATE(), 1);

INSERT INTO transactions(transaction_date) VALUES
(CURRENT_DATE());

SELECT * FROM products;
SELECT * FROM transactions;

-- INNER JOIN --
SELECT tr.transaction_id, tr.amount, tr.transaction_date, 
	   pd.product_id, pd.product_name 
FROM transactions tr INNER JOIN products pd
ON tr.product_id = pd.product_id;

-- LEFT JOIN it show the all data from the left table --
SELECT tr.transaction_id, tr.amount, tr.transaction_date, 
	   pd.product_id, pd.product_name 
FROM transactions tr LEFT JOIN products pd
ON tr.product_id = pd.product_id;

-- RIGHT JOIN it show the all data from the right table --
SELECT tr.transaction_id, tr.amount, tr.transaction_date, 
	   pd.product_id, pd.product_name 
FROM transactions tr RIGHT JOIN products pd
ON tr.product_id = pd.product_id;

-- SELF JOIN --
ALTER TABLE employees
ADD COLUMN report_to INT;

UPDATE employees SET report_to = 3 WHERE emp_id = 5;
SELECT * FROM employees;

-- It joins the same table information using inner join --
SELECT a.full_name, a.email_id, a.salary,
	   b.full_name AS "Reports_to", b.email_id
FROM employees AS a INNER JOIN employees AS b
ON a.report_to = b.emp_id;

-- UNION it combines two or more SELECT statements --
-- UNION ALL combine tables including duplicates -- 
SELECT transaction_id, amount FROM transactions
UNION 
SELECT product_id, product_name FROM products;
