-- D/A With SQL

-- SQL Server String Functions

-- LEN
/*
Syntax : LEN(string)
*/

SELECT LEN('Navarra') AS 'Length of word'

SELECT LEN(NULL)     -- it returns NULL

SELECT LEN(14)       -- it returns character size / 2

SELECT FIRSTNAME, LEN(FIRSTNAME) AS 'len of firstname'
FROM PERSON

-- UPPER / LOWER
/*
Syntax : UPPER(string)
Syntax : LOWER(string)
*/

SELECT UPPER('navarra')

SELECT LOWER('NAVARRA')

SELECT LOWER(FIRSTNAME) AS 'Firstname'
FROM PERSON

-- SUBSTRING
/*
Syntax : SUBSTRING(string, start, length)
*/
-- index starts from 1. negative index is posible.

SELECT SUBSTRING('SQL Server SUBSTRING', 12, LEN('SQL Server SUBSTRING'))

SELECT email, SUBSTRING(email, CHARINDEX('@', email) +1, LEN(email)) AS 'Domain Name'
FROM sales.customers

SELECT SUBSTRING('SQL Server SUBSTRING', -10, 18)         -- length must be positive. other one can be negative index.

-- TRIM
/*
Syntax : TRIM(characters FROM string)
*/
-- it can be also LTRIM() and RTRIM
-- it makes strip

SELECT TRIM('  Reinvent Yourself  ')

SELECT RTRIM('  Reinvent Yourself  ')

SELECT TRIM('self' FROM TRIM('  Reinvent Yourself    '))

-- STRING
/*
Syntax : REPLACE(string, old_string, new_string)
*/

SELECT REPLACE('SQL Tutorial', 'SQL', 'HTML')

SELECT job_title, REPLACE(job_title, 'Scientist', 'Analyst')
FROM employees
WHERE job_title = 'Data Scientist';

SELECT REPLACE('ABC ABC ABC', 'a', 'c')      -- default no case sensitive

-- CHARINDEX
/*
Syntax : CHARINDEX(substring, string, start)
start point is optional
if it can't find anything, gives 0
*/

SELECT CHARINDEX('yourself', 'Reinvent yourself') AS start_position

SELECT first_name,
       last_name,
       job_title,
       CHARINDEX(job_title, 'er') AS er       -- filters if title contain 'er'.
FROM employees
WHERE er > 0;


-- CONCAT
/*
Syntax : CONCAT(string1, string2, ...., string_n)
Synatx : string1 + string2 + string_n
*/

SELECT 'John' + '/' + 'Doe' AS full_name

SELECT
    CONCAT(
        CONCAT(first_name,' ',last_name, ' '),
        phone,
        CONCAT(' ', city,' ',state),
        zip_code
    ) customer_address
FROM
    sales.customers




