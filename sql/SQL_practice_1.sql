-- SQL Practice Tasks

--------------------------------------------------
-- Task 1
-- Table: sales (sale_id, product, amount)
-- Calculate the total sales amount for each product.
--------------------------------------------------

SELECT
    product,
    SUM(amount) AS total_amount
FROM sales
GROUP BY product;


--------------------------------------------------
-- Task 2
-- Table: orders (order_id, customer_id, amount)
-- Find customers who made orders totaling more than 1000.
--------------------------------------------------

SELECT
    customer_id,
    SUM(amount) AS total_amount
FROM orders
GROUP BY customer_id
HAVING SUM(amount) > 1000;


--------------------------------------------------
-- Task 3
-- Table: transactions (transaction_id, customer_id, amount, status)
-- Calculate the total amount of completed transactions for each customer.
-- Show only customers whose total completed transactions exceed 500.
--------------------------------------------------

SELECT
    customer_id,
    SUM(amount) AS total_amount
FROM transactions
WHERE status = 'completed'
GROUP BY customer_id
HAVING SUM(amount) > 500;


--------------------------------------------------
-- Task 4
-- Table: transactions (transaction_id, transaction_date, amount)
-- Calculate the total transaction amount per month.
-- Show only months where total transactions exceed 1000.
--------------------------------------------------

SELECT
    MONTH(transaction_date) AS month,
    SUM(amount) AS total_amount
FROM transactions
GROUP BY MONTH(transaction_date)
HAVING SUM(amount) > 1000;


--------------------------------------------------
-- Task 5
-- Table: orders (order_id, customer_id, region, amount, status)
-- Calculate the total amount of completed orders for each region and customer.
-- Show only region–customer pairs where total orders exceed 2000.
--------------------------------------------------

SELECT
    region,
    customer_id,
    SUM(amount) AS total_amount
FROM orders
WHERE status = 'completed'
GROUP BY region, customer_id
HAVING SUM(amount) > 2000;


--------------------------------------------------
-- Task 6
-- Table: transactions (transaction_id, customer_id, amount, transaction_date, status)
-- Find customers who made completed transactions totaling more than 1000
-- in the current month.
--------------------------------------------------

SELECT
    customer_id,
    SUM(amount) AS total_amount
FROM transactions
WHERE status = 'completed'
AND MONTH(transaction_date) = MONTH(CURRENT_TIMESTAMP)
AND YEAR(transaction_date) = YEAR(CURRENT_TIMESTAMP)
GROUP BY customer_id
HAVING SUM(amount) > 1000;


--------------------------------------------------
-- Task 7
-- Tables:
-- customers (customer_id, customer_name, region)
-- accounts (account_id, customer_id, balance)
-- Retrieve customer names and the total balance of their accounts
-- for customers from the 'Kyiv' region.
--------------------------------------------------

SELECT
    c.customer_id,
    c.customer_name,
    SUM(a.balance) AS total_balance
FROM customers c
LEFT JOIN accounts a
    ON c.customer_id = a.customer_id
WHERE c.region = 'Kyiv'
GROUP BY c.customer_id, c.customer_name;


--------------------------------------------------
-- Task 8
-- Table: transactions (transaction_id, customer_id, amount, transaction_date)
-- Find customers whose transaction amounts are greater than
-- the average transaction amount.
--------------------------------------------------

SELECT
    customer_id,
    SUM(amount) AS total_amount
FROM transactions
GROUP BY customer_id
HAVING SUM(amount) > (
    SELECT AVG(amount)
    FROM transactions
);


--------------------------------------------------
-- Task 9
-- Table: transactions (transaction_id, customer_id, transaction_date)
-- Find pairs of customers who made transactions on the same day
-- without duplicate pairs.
--------------------------------------------------

SELECT DISTINCT
    t1.customer_id,
    t2.customer_id,
    t1.transaction_date
FROM transactions t1
JOIN transactions t2
    ON t1.transaction_date = t2.transaction_date
WHERE t1.customer_id < t2.customer_id;


--------------------------------------------------
-- Task 10
-- Table: employees (employee_id, name, salary)
-- Find pairs of employees who have the same salary.
--------------------------------------------------

SELECT
    e1.employee_id,
    e1.name,
    e2.employee_id,
    e2.name,
    e1.salary
FROM employees e1
JOIN employees e2
    ON e1.salary = e2.salary
WHERE e1.employee_id < e2.employee_id;