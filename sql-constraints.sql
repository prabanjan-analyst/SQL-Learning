USE my_database;

-- 1.Add PRIMARY KEY Constraint to the table --
CREATE TABLE transactions(
	transaction_id INT PRIMARY KEY,
    amount DECIMAL(6, 2),
    transaction_date DATE,
    product_id INT
);

-- Add PRIMARY KEY to the existing table
ALTER TABLE transactions
ADD CONSTRAINT PRIMARY KEY(transaction_id);

-- 2.Add UNIQUE constraint to the table --
CREATE TABLE products(
	product_id INT PRIMARY KEY,
    product_name VARCHAR(50) UNIQUE,
    price DECIMAL(3, 2)
);

-- Add UNIQUE Constraint to the existing table
ALTER TABLE products
ADD CONSTRAINT UNIQUE(product_name);

-- 3.Add CHECK Constraint to the table --
CREATE TABLE products(
	product_id INT PRIMARY KEY,
    product_name VARCHAR(50) UNIQUE,
    price DECIMAL(4, 2)
    CONSTRAINT chk_price CHECK(price > 50)
);

INSERT INTO products VALUES(1, "Mobile", 40);

-- Add CHECK Constraint to the existing table
ALTER TABLE products 
ADD CONSTRAINT chk_price CHECK(price > 40);

-- To delete/drop the CHECK Constraint
ALTER TABLE products
DROP CHECK chk_price;

-- 4.Add DEFAULT Constraint to the table --
CREATE TABLE transactions(
	transaction_id INT PRIMARY KEY,
    amount DECIMAL(6, 2) DEFAULT 0,
    transaction_date DATE,
    product_id INT
);

INSERT INTO transactions(transaction_id, transaction_date, product_id) 
VALUES(1, CURRENT_DATE(), 2);	-- It sets the amount 0.00

-- Add DEFAULT Constraint to the existing table
ALTER TABLE transactions
ALTER amount SET DEFAULT 0;

-- 5.Add NOT NULL Constraint to the table --
CREATE TABLE transactions(
	transaction_id INT PRIMARY KEY,
    amount DECIMAL(6, 2) DEFAULT 0 NOT NULL,
    transaction_date DATE,
    product_id INT
);

INSERT INTO transactions 
VALUES(1, NULL, CURRENT_DATE(), 2);		-- It returns Error

-- Add NOT NULL Constraint to the existing table
ALTER TABLE transactions
MODIFY amount DECIMAL(4, 2) NOT NULL;

-- AUTO INCREMENT --
CREATE TABLE transactions(
	transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    amount DECIMAL(6, 2) DEFAULT 0 NOT NULL,
    transaction_date DATE,
    product_id INT
);

-- To set the increment starting values
ALTER TABLE transactions
AUTO_INCREMENT = 1001;

INSERT INTO transactions(transaction_date, product_id) 
VALUES(CURRENT_DATE(), 2);

-- 6.Add FOREIGN KEY Constraint to the table --
CREATE TABLE transactions(
	transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    amount DECIMAL(6, 2) DEFAULT 0 NOT NULL,
    transaction_date DATE,
    product_id INT,
    CONSTRAINT transaction_id_fk FOREIGN KEY(product_id) 
    REFERENCES products(product_id)
);

-- Add FOREIGN KEY Constraint to the existing table
ALTER TABLE transactions
ADD CONSTRAINT transac_id_fk FOREIGN KEY(product_id)
REFERENCES products(product_id);

-- To delete/drop the FOREIGN KEY
ALTER TABLE transactions
DROP FOREIGN KEY transaction_id_fk;
 
-- ------ These are the 6 Important Constraints in SQL -- ------