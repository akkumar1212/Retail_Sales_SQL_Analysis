USE cp_db;

CREATE TABLE raw_Sales(
	transaction_id VARCHAR(50) NULL,
    customer_id VARCHAR(50) NULL,
    category VARCHAR(50) NULL,
    item VARCHAR(100) NULL,
    price_per_unit DECIMAL(10,2) NULL,
    quantity INT NULL,
    total_spend DECIMAL(10,2) NULL,
    payment_mode VARCHAR(50) NULL,
    location VARCHAR(50) NULL,
    transaction_date DATE NULL,
    discount_applied VARCHAR(10) NULL
);

SELECT count(*) FROM raw_Sales;

# Null Values
SELECT COUNT(*) AS total_rows,
	SUM(CASE WHEN item IS NULL THEN 1 ELSE 0 END) AS missing_item,
    SUM(CASE WHEN total_spend IS NULL THEN 1 ELSE 0 END) AS missing_total_spend
FROM raw_sales;

# Checking for Duplcates
SELECT transaction_id , COUNT(*)
FROM raw_sales
GROUP BY transaction_id
HAVING count(*) > 1;

SELECT * FROM raw_sales 
WHERE (price_per_unit * quantity) != total_spend;

# Remove Duplicates /find only distinct rows 
CREATE TABLE temp_tb AS 
SELECT DISTINCT * FROM raw_sales;

# Drop table raw_sales and rename temp_tb to raw_sales :--
DROP TABLE raw_sales;
ALTER TABLE temp_tb RENAME TO raw_sales;

# Fill / Remove the Null or empty Rows in table :--
DELETE FROM raw_sales 
WHERE transaction_id IS NULL OR transaction_id = '';

UPDATE raw_sales
SET total_spend = price_per_unit * quantity
WHERE total_spend IS NULL OR total_spend = 0;

select * from raw_sales; # -------
 
# Upper case the Category Column :--
UPDATE raw_sales
SET category = UPPER(category);
 
# Filling the NULL values in discount_applied column :--
UPDATE raw_sales
SET discount_applied = 0
WHERE discount_applied IS NULL;

# Filling NULL values in price_per_unit :--
UPDATE raw_Sales
SET price_per_unit = total_spend/quantity
WHERE price_per_unit IS NULL;

# Filling NULL values in item column :--
UPDATE raw_sales t1
JOIN raw_sales t2 
	ON t1.price_per_unit = t2.price_per_unit 
    AND t1.category = t2.category 
SET t1.item = t2.item 
WHERE (t1.item IS NULL OR t1.item = '')
	AND (t2.item IS NOT NULL OR t2.item != '');
    
# Delete other rows having NULL values in quantity and total_spend(both have null values) :--
DELETE FROM raw_sales
WHERE quantity IS NULL AND total_spend IS NULL;

# Count if any values left :--
SELECT 	transaction_id ,
	SUM(CASE WHEN item IS NULL THEN 1 ELSE 0 END) AS null_item,
    SUM(CASE WHEN price_per_unit IS NULL THEN 1 ELSE 0 END) AS null_price,
    SUM(CASE WHEN quantity IS NULL THEN 1 ELSE 0 END) AS NULL_quantity,
    SUM(CASE WHEN total_spend IS NULL THEN 1 ELSE 0 END) AS null_total_spend
FROM raw_sales
group by transaction_id
HAVING null_item = 1;

# DELETE the row having NULL values left :--
DELETE FROM raw_sales
WHERE transaction_id = 'TXN_1972761';

# Overview of the table :--
DESCRIBE raw_sales;
