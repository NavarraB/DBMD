-- Data Manipulation Language (DML)
-- Built-in Functions

-- Aggregate Functions

-- AVG, SUM, MAX, MIN, COUNT (it doesn't count NULLs), COUNT(*) (it counts NULLs)

-- Conversion Function

-- CONVERT(data_type(length), expression)

SELECT CONVERT(int, 10.99)   -- it converts 10.99 to int 10

SELECT CONVERT(varchar(12), getdate())

SELECT title_id, [type]
FROM titles
WHERE CONVERT(char(7), [type]) LIKE '%comp%'               -- it converted into 7 characters

SELECT title_id, [type], ytd_sales
FROM titles

SELECT title_id, CONVERT(char(4), ytd_sales) as Sales       -- it changes datatype and size
FROM titles
WHERE [type] LIKE '%cook%'

-- Date Functions

-- DATEADD(interval, number, date)

SELECT TOP 2 *
FROM employee

SELECT TOP 2 DATEADD(day, 3, hire_date)
FROM employee

-- DATEDIFF(datepart, date1, date2)

SELECT DATEDIFF(day, hire_date, 'May 31 1990') 
FROM employee


-- Mathematical Functions

SELECT ROUND(235.415, 2) AS RoundValue

SELECT SQRT(81) AS Square_Root

SELECT FLOOR(123.45)

SELECT discounttype, (discount * 2) AS 'New Discount Rates'
FROM discounts

-- JOINS

SELECT e.job_id, e.fname, j.job_desc
FROM employee as e
INNER JOIN jobs as j
ON e.job_id = j.job_id
ORDER BY e.job_id

SELECT e.job_id, e.fname, j.job_desc
FROM employee as e
LEFT JOIN jobs as j
ON e.job_id = j.job_id
ORDER BY e.job_id

SELECT e.job_id, e.fname, j.job_desc
FROM employee as e
RIGHT JOIN jobs as j
ON e.job_id = j.job_id
ORDER BY e.job_id

SELECT e.job_id, e.fname, j.job_desc
FROM employee as e
FULL OUTER JOIN jobs as j
ON e.job_id = j.job_id
ORDER BY e.job_id
