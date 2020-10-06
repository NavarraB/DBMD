-- String Functions

-- Collations

SELECT CASE WHEN 'A' <> 'a' collate Latin1_General_CI_AI
            THEN 'Different' ELSE 'Same' END

SELECT CASE WHEN 'A' <> 'a' collate Latin1_General_Cs_AI
            THEN 'Different' ELSE 'Same' END


-- LEN

SELECT LEN('Who            ')          -- 3   LEN makes rstrip
SELECT LEN('                 Who')     -- 20

-- REPLACE

SELECT REPLACE('This string has trailing spaces', 'S', '/') 
SELECT REPLACE('                 Who', ' ', '') 

SELECT LEN(REPLACE('                 Who', ' ', '')) 

-- PATINDEX

SELECT PATINDEX('%ern%', 'SQL Pattern Index') AS position

/*
This example finds the position of the first occurence of the pattern
2018 in values of the product_name column in the production.products
*/

SELECT *
FROM production.products

SELECT product_name, PATINDEX('%2018%', product_name)
FROM production.products
WHERE product_name like '%2018%'
ORDER BY product_name

/*
The STUFF() functiion deletes a part of a string and then inserts a substring
into the string, beginning at a specified position.

STUFF (input_string, start_position, length, replace_with_substring)
*/

SELECT STUFF('SQL Tutorial', 1, 3, 'SQLL Server')

-- REPLICATE() function
-- function repeats a string a specified number of items

SELECT REPLICATE('z', 13)

-- How to mask a credit card number. It reveals only the last four characters.

DECLARE @cardnumber varchar(20)='4882584254460197'             -- we defined a variable

SELECT STUFF(@cardnumber, 1, LEN(@cardnumber)-4, REPLICATE('X', LEN(@cardnumber)-4))


SELECT RIGHT('Hello World', 3)

SELECT LEFT('Hello World', 3)


--SUBSTRING()
--SUBSTRING() extracts a substring with a specified length starting from a location in an input string.
--SUBSTRING(input_string, start, length);

SELECT SUBSTRING('SQL Server SUBSTRING', 12, Len('SQL Server SUBSTRING')) result;

-- How to extract domain names from email addresses of customers

SELECT email, SUBSTRING(email, CHARINDEX('@', email) +1, LEN(email)) AS 'Domain Name'
FROM sales.customers

-- count domains

SELECT SUBSTRING(email, CHARINDEX('@', email) +1, LEN(email)) AS 'Domain Name', COUNT(SUBSTRING(email, CHARINDEX('@', email) +1, LEN(email))) AS 'Count of Domains'
FROM sales.customers
GROUP BY  SUBSTRING(email, CHARINDEX('@', email) +1, LEN(email))

-- REVERSE

SELECT REVERSE('evil ot sah eh')         -- palindrom

SELECT REPLACE(REVERSE(
    'evil ot sah eh|hcihw ni|pmaws a ylno sa|nam a fo skniht|mreg a tub|
    nem ot elbanoitcejbo|yrev era smreg'),'|','')

SELECT RIGHT(URL, CHARINDEX('/',REVERSE(URL) +'/')-1)
    FROM(SELECT [URL]='http://www.simple-talk.com/content/article.aspx?article=495')f

-- Window Functions

-- OVER and PARTITION BY clause

CREATE TABLE PERSON
(FIRSTNAME VARCHAR(50)
,GENDER VARCHAR(1)
,BIRTHDATE SMALLDATETIME
,HEIGHT SMALLINT
,[WEIGHT] SMALLINT)


INSERT INTO PERSON VALUES('ROSEMARY','F','2000-05-08',35,123);
INSERT INTO PERSON VALUES('LAUREN','F','2000-06-10',54,876);
INSERT INTO PERSON VALUES('ALBERT','M','2000-08-02',45,150);
INSERT INTO PERSON VALUES('BUDDY','M','1998-10-02',45,189);
INSERT INTO PERSON VALUES('FARQUAR','M','1998-11-05',76,198);
INSERT INTO PERSON VALUES('TOMMY','M','1998-12-11',78,167);
INSERT INTO PERSON VALUES('SIMON','M','1999-01-03',87,256);

SELECT *
FROM PERSON

-- Create a column containing row counts within gender

-- SELECT INTO

SELECT GENDER, COUNT(*) 'Gender Count'
INTO PERSON_COUNT_BY_GENDER
FROM PERSON
GROUP BY GENDER

SELECT * FROM PERSON_COUNT_BY_GENDER                    -- create new table with SELECT INTO

SELECT p.*, c.[Gender Count]
FROM PERSON as p
JOIN PERSON_COUNT_BY_GENDER as c
ON p.GENDER = c.GENDER

-- Do same thing with Window Function (Analytic Function)

SELECT p.*, COUNT(*) OVER (PARTITION BY p.GENDER) AS 'Gender Count'
FROM PERSON AS p

-- Calculate running totals of weight by gender

SELECT p.GENDER, p.FIRSTNAME, p.WEIGHT, SUM(p.WEIGHT) OVER (PARTITION BY p.GENDER ORDER BY p.WEIGHT) AS WT_RUN
FROM PERSON AS p

-- Create a column containing row counts within gender

SELECT p.*, COUNT(*) OVER (PARTITION BY p.GENDER)
FROM PERSON as p

-- Create a column containing row counts within gender bithdate year

SELECT p.*, COUNT(*) OVER (PARTITION BY p.GENDER, year(p.BIRTHDATE))
FROM PERSON as p

