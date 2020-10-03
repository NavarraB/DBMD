-- subquery

-- Select all customers (first name, last name, order date) in New York who made at least one order


SELECT c.first_name, c.last_name, o.order_date, COUNT(o.order_date) AS 'Number of Orders'
FROM sales.customers as c
JOIN sales.orders as o 
ON c.customer_id = o.customer_id
WHERE c.customer_id IN (
    SELECT customer_id                           -- subquery part.
    FROM sales.customers
    WHERE city = 'New York')
GROUP BY c.first_name, c.last_name, o.order_date
HAVING COUNT(o.order_date) >= 1
ORDER BY 4 DESC


SELECT c.first_name, c.last_name, COUNT(o.order_date) AS 'Number of Orders'
FROM sales.customers as c
JOIN sales.orders as o 
ON c.customer_id = o.customer_id
WHERE c.customer_id IN (
    SELECT customer_id                           -- subquery part.
    FROM sales.customers
    WHERE city = 'New York')
GROUP BY c.first_name, c.last_name
HAVING COUNT(o.order_date) >= 1
ORDER BY 3 DESC

-- nested queries 
-- select all products where list price is greater than avg list price of Stride and Trek (brands)

SELECT product_name, list_price
FROM production.products
WHERE list_price > (
    SELECT AVG(list_price)
    FROM production.products
    WHERE brand_id IN(
        SELECT brand_id
        FROM production.brands
        WHERE brand_name in ('Strider', 'Trek')))
ORDER BY 2 DESC

--- Get the difference between the product price and the avg product price

SELECT product_name, list_price - (SELECT AVG(list_price) FROM production.products) AS 'AVG Difference'
FROM production.products

-- Exists in subquery

SELECT customer_id, first_name, last_name, email, city
FROM sales.customers
WHERE customer_id IN (
    SELECT customer_id
    FROM sales.orders
    WHERE year(order_date) = 2017
)

SELECT customer_id, first_name, last_name, email, city
FROM sales.customers
WHERE EXISTS (
    SELECT customer_id
    FROM sales.orders
    WHERE year(order_date) = 2017
)

SELECT customer_id, first_name, last_name, email, city
FROM sales.customers
WHERE EXISTS (
    SELECT c.customer_id
    FROM sales.customers as c
    JOIN sales.orders as o
    ON c.customer_id = o.customer_id
    WHERE year(order_date) = 2017
)


-- subquery in FROM

SELECT t.full_name, AVG(order_count)
FROM(
    SELECT [first_name]+' ' + [last_name] [full_name],
    COUNT(order_id) [order_count]
    FROM [sales].[orders] o
    inner join [sales].[staffs] s
    on s.staff_id = o.staff_id
    GROUP BY [first_name]+' ' + [last_name]
) t
GROUP BY t.full_name
ORDER BY 2 DESC

---------------------------------------------------------------

-- UNION

SELECT first_name, last_name, 'staff' AS [Type]
FROM sales.staffs 
UNION                                              -- UNION ALL
SELECT first_name, last_name, 'customer'
FROM sales.customers
ORDER BY first_name, last_name


SELECT first_name + ' ' + last_name AS [name], 'staff' AS [Type]
FROM sales.staffs 
UNION ALL
SELECT first_name + ' ' + last_name AS [name], 'customer'
FROM sales.customers


-- Synonym

CREATE SYNONYM  orders FOR sales.orders

SELECT *
FROM orders           -- FROM sales.orders

-- CASE
/*
CASE input 
     WHEN e1 THEN r1
     WHEN e2 THEN r2
     ...
     WHEN en THEN rn
     [ELSE re]
END
*/

SELECT DISTINCT order_status
FROM sales.orders

--1 : Pending
--2 : Processing
--3 : Rejected
--4 : Completed


SELECT 
CASE order_status
    WHEN 1 THEN 'Pending'
    WHEN 2 THEN 'Processing'
    WHEN 3 THEN 'Rejected'
    ELSE 'Completed'
END order_status,
COUNT(order_id) AS 'Order Count'
FROM sales.orders
GROUP BY order_status


SELECT 
CASE order_status
    WHEN 1 THEN 'Pending'
    WHEN 2 THEN 'Processing'
    WHEN 3 THEN 'Rejected'
    ELSE 'Completed'
END order_status,
COUNT(order_id) AS 'Order Count'
FROM sales.orders
WHERE year(order_date) = 2018
GROUP BY order_status
ORDER BY 2 DESC