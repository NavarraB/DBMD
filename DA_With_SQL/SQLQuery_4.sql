-- Aggregate Functions

-- COUNT example

SELECT *
FROM [production].[products]

SELECT COUNT(*)
FROM production.products

SELECT COUNT(*)
FROM [production].[products]
WHERE list_price > 500

CREATE TABLE tab(
    val INT
)

INSERT INTO tab(val)
VALUES(1), (2), (2), (3), (null), (null), (4), (5)

SELECT * 
FROM tab    

SELECT COUNT(*)             -- 8
FROM tab     

SELECT COUNT (DISTINCT val)  -- 5
FROM tab

SELECT COUNT(val)            -- 6
FROM tab

SELECT c.category_name, COUNT(*) AS 'Product Count'
FROM [production].[products] as p
JOIN [production].[categories] as c
ON p.category_id = c.category_id
GROUP BY c.category_name
HAVING COUNT(*) > 30
ORDER BY [Product Count] DESC

SELECT b.brand_name, COUNT(*) AS 'Product Count'
FROM [production].[brands] as b 
JOIN [production].[products] as p
ON b.brand_id = p.brand_id
WHERE brand_name = 'Electra'
GROUP BY b.brand_name
HAVING COUNT(*) > 20

-- MAX/MIN Example

SELECT MAX(list_price)
FROM production.products

SELECT *
FROM production.products
WHERE list_price = (SELECT MAX(list_price)
FROM production.products)

SELECT b.brand_name, MAX(list_price) AS 'Max Price'
FROM production.products as p
JOIN production.brands as b
ON b.brand_id = p.brand_id
GROUP BY b.brand_name
HAVING MAX(list_price) > 1000

SELECT MIN(list_price)
FROM production.products

SELECT *
FROM production.products
WHERE list_price = (SELECT MIN(list_price) FROM production.products)

SELECT c.category_name, MIN(p.list_price) AS 'Cheapest'
FROM [production].[categories] as c
JOIN [production].[products] as p
ON  c.category_id = p.category_id
GROUP BY c.category_name

-- SUM Example

SELECT SUM(quantity)
FROM [production].[stocks]

SELECT stocks.product_id, SUM(quantity)
FROM production.stocks
GROUP BY product_id

SELECT order_id, SUM(quantity*list_price)
FROM sales.order_items
GROUP BY order_id

SELECT * 
FROM sales.order_items

SELECT order_id, SUM(quantity*list_price*(1 - discount))
FROM sales.order_items
GROUP BY order_id

-- AVG Example

SELECT AVG(list_price)
FROM production.products

SELECT c.category_name, AVG(p.list_price) AS 'Average Price'
FROM production.products as p
JOIN production.categories as c
ON c.category_id = p.category_id 
GROUP BY c.category_name

SELECT AVG(list_price)
FROM production.products

SELECT ROUND(AVG(list_price), 2)                                -- decimal 2  abc.xx000
FROM production.products

SELECT CAST(ROUND(AVG(list_price), 2) AS DEC(10, 2))            -- decimal 2  abc.xx
FROM production.products

SELECT CONVERT(INT, ROUND(AVG(list_price), 2))                  -- int abc
FROM production.products 

-- STDEV Example

SELECT *
FROM production.products

SELECT STDEV(list_price), AVG(list_price)
FROM production.products