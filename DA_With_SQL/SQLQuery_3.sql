-- VIEW

SELECT *
FROM production.products

SELECT *
FROM production.brands

SELECT b.brand_id, b.brand_name, p.product_name, p.list_price
FROM production.products as p
INNER JOIN production.brands as b
ON b.brand_id = p.brand_id
ORDER BY b.brand_id

SELECT *
FROM production.products p, production.brands b
WHERE p.brand_id=b.brand_id

CREATE VIEW sales.product_info                   -- ORDER BY invalid in VIEW
AS
SELECT b.brand_name, p.product_name, p.list_price
FROM production.products as p
INNER JOIN production.brands as b
ON b.brand_id = p.brand_id;

-- VIEW create a small table (database object)

SELECT *
FROM sales.product_info

SELECT *
FROM (
    SELECT b.brand_name, p.product_name, p.list_price
    FROM production.products as p
    INNER JOIN production.brands as b
    ON b.brand_id = p.brand_id ) qwerty

CREATE VIEW sales.daily_sales
AS
SELECT o.order_date AS [Date], p.product_id AS 'Product Code', p.product_name AS 'Product Name', i.quantity AS Quantity, i.list_price AS Price
FROM sales.orders as o
JOIN sales.order_items i
ON o.order_id = i.order_id
JOIN production.products as p
ON i.product_id = p.product_id

SELECT *
FROM [sales].[daily_sales]

SELECT *
FROM [sales].[daily_sales]
WHERE [Product Code] = 20
ORDER BY Quantity

DROP VIEW sales.daily_sales                     -- we can drop VIEW with DROP VIEW.

EXEC sp_rename 'sales.daily_sales', 'sales'     -- we can change name of VIEW.