-- Order of SQL Statement Execution
SELECT *                                        -- 4  : List of items or columns selected
FROM sales.orders                               -- 1  : Defines the source of data set
WHERE shipped_date is not null                  -- 2  : Data set filter
GROUP BY customer_id                            -- 3  : Combines rows into groups with aggregations


select 7 / 2      -- int division int gives int  3


SELECT CAST(7 as decimal(5,2))/2     -- it gives 3.5

SELECT *
FROM sales.customers
WHERE state = 'NY'

SELECT *
FROM sales.customers
WHERE state in ('NY', 'CA')

SELECT *
FROM sales.customers
WHERE state in ('CA')          -- to use = for one condition instead of in better. because of time consumotion of in.

SELECT first_name, last_name, email, street, city, [state]
FROM sales.customers
WHERE state = 'CA'
ORDER BY first_name

SELECT city, count(*) as numberofcustomers
FROM sales.customers
WHERE state = 'CA'
GROUP BY city

SELECT '4' + 4

SELECT '4A' + 4       -- error

SELECT '4' + '4'

SELECT CAST('20200926' AS DATE) AS januaryfirst      -- date format as american format, yyyy-mm-dd

SELECT CAST('20200926' AS DATETIME) AS januaryfirst      -- date format as american format, yyyy-mm-dd with hours hh:mm:ss.sss

SELECT city, count(*) as numberofcustomers
FROM sales.customers
WHERE [state] = 'CA'
GROUP BY city
ORDER BY 2 DESC                        -- second item on select line

SELECT city, count(*) as numberofcustomers
FROM sales.customers
WHERE [state] = 'CA'
GROUP BY city
HAVING count(*) > 9
ORDER BY city                      

SELECT city, count(*) as numberofcustomers
FROM sales.customers
WHERE [state] = 'CA'
GROUP BY city
HAVING count(*) > 8
ORDER BY 2 DESC, city                      -- second item on select line

SELECT city, count(*) as numberofcustomers
FROM sales.customers
WHERE [state] = 'CA'
GROUP BY city
HAVING count(*) > 8
ORDER BY 2 DESC, city DESC                        -- second item on select line

-- Order of execution of T-SQL Query

SELECT		city, COUNT(*)		--5 : list of items to return
FROM 		sales.customers		--1 : Defines the source of data set
WHERE 		state = 'CA'		--2 : Row filter
GROUP BY	city				--3 : Combines rows into groups  with aggretions
HAVING		COUNT (*) > 10		--4 : Group filter
ORDER BY	city;				--6 : Presentation order

SELECT city, first_name + ' ' + last_name as [name]            -- concat columns
FROM sales.customers 
WHERE state = 'NY'
ORDER BY city ASC

SELECT city, first_name, last_name, street
FROM sales.customers
ORDER BY len(first_name) DESC                                  -- it orders with len

SELECT first_name, len(first_name) as lengthofnames
FROM sales.customers
GROUP BY first_name 

SELECT city, first_name, last_name, street
FROM sales.customers
ORDER BY len(first_name) DESC 

SELECT city, first_name,len(first_name), last_name, street
FROM sales.customers
GROUP BY city, first_name, last_name, street 
ORDER BY len(first_name) DESC 

SELECT TOP 10 city, first_name,len(first_name), last_name, street           -- limit 10 rows
FROM sales.customers
GROUP BY city, first_name, last_name, street 
ORDER BY len(first_name) DESC 

-- top percentage % 

SELECT TOP 2 PERCENT [product_name], [list_price]                           -- %2 percentage of total 
FROM production.products
ORDER BY list_price DESC

SELECT [product_name], [list_price]                           
FROM production.products
ORDER BY list_price DESC

SELECT TOP 10 WITH TIES 
[product_name], [list_price], [model_year]
FROM [production].[products]
ORDER BY [list_price] DESC;

SELECT TOP 10
[product_name], [list_price], [model_year]
FROM [production].[products]
ORDER BY [list_price] DESC;

--distinct statement
SELECT distinct city                           -- it gives unique data only
from [sales].[customers]

SELECT city
from [sales].[customers]

SELECT city, [state], zip_code                  -- state reserved word so in the brackets
FROM sales.customers
GROUP BY city, [state], zip_code
ORDER BY city, [state], zip_code