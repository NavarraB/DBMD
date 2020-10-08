-- Data Manipulation Language (DML)
--SELECT

SELECT lname, fname
FROM employee
ORDER BY lname;

SELECT *
FROM publishers

SELECT *
FROM publishers
WHERE city = 'Dallas'

SELECT *
FROM sales

SELECT *
FROM sales
WHERE qty BETWEEN 20 and 50           -- BETWEEN is inclusive

SELECT *
FROM sales
WHERE qty >= 20 and qty <= 50

SELECT *
FROM sales
WHERE qty NOT BETWEEN 20 and 50

SELECT *
FROM publishers
WHERE state = 'MA' or state = 'NY'

SELECT *
FROM publishers
WHERE city in ('Boston', 'Dallas', 'Paris')

SELECT *
FROM discounts
WHERE lowqty IS NULL

SELECT *
FROM discounts
WHERE lowqty IS NOT NULL

-- LIKE 
-- LIKE is used with char, varchar, text, datetime and smalldatetime data.
-- % Any string of zero or more characters
-- - Any single character
-- [] Any single character within the specified range (e.g., [a-f]) or set (e.g., [abcdef])
-- [^] Any single character not within the specified range (e.g., [^a – f]) or set (e.g., [^abcdef])

SELECT *
FROM employee
WHERE lname LIKE 'Mc%'

SELECT *
FROM employee
WHERE lname LIKE '%s'

SELECT *
FROM employee
WHERE lname LIKE '%s%'

--ORDER BY

SELECT *
FROM employee
ORDER BY hire_date       -- default is ASC

SELECT *
FROM employee
ORDER BY hire_date DESC

--GROUP BY & Aggregate Functions

SELECT [type]
FROM titles
GROUP BY [type]

SELECT [type] as Type, MIN(price) as Minimum_Price          
FROM titles                                                 
GROUP BY [type]

SELECT [type], MIN(price) as 'Minimum Price'
FROM titles
WHERE price IS NOT NULL
GROUP BY [type]

SELECT COUNT(*)
FROM titles
GROUP BY [type]

SELECT COUNT (DISTINCT [type])
FROM titles
GROUP BY [type]

SELECT [type], COUNT(*)
FROM titles
GROUP BY [type]

SELECT AVG(royalty)
FROM titles
GROUP BY [type]

SELECT [type], SUM(royalty)
FROM titles
GROUP BY [type]

SELECT [type], SUM(royalty) as sum_royalty, AVG(royalty) as avg_royalty
FROM titles
GROUP BY [type]

SELECT au_fname, city
FROM authors
GROUP BY au_fname, city
HAVING city <> 'Oakland'              -- if WHERE doesn't work (in agg func for example, or with groups) we use HAVING, it filtered the results.