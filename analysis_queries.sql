# ------ Business Insights --------------#

# What are our top-performing categories?

SELECT category , 
	COUNT(*) AS total_transaction,
	SUM(total_spend) AS total_income,
    ROUND(AVG(total_spend), 2) AS avg_order_value
FROM raw_sales
GROUP BY category
ORDER BY total_income DESC;

# How do our sales trend over time?

SELECT DATE_FORMAT(transaction_date , "%Y-%m") AS Transaction_date,
	SUM(total_spend) AS total_revenue,
    SUM(quantity) AS Quantity
FROM raw_sales
GROUP BY Transaction_date
ORDER BY Transaction_date;

# What is the most popular payment method by location? :--

SELECT location , 
	payment_mode ,
    COUNT(*) AS transaction_count
FROM raw_sales
GROUP BY payment_mode, location
ORDER BY location , transaction_count DESC;

# The "Senior Analyst" Query (Running Total) :--

SELECT transaction_date ,
	category , 
    total_spend,
    SUM(total_spend) OVER(PARTITION BY category ORDER BY transaction_date) AS running_total
FROM raw_sales
LIMIT 100;
