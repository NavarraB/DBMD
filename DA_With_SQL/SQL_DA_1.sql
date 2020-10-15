--DA_W_SQL-1

-- HAVING Clause (GROUP BY with HAVING)

SELECT column_1, aggregate_function(column_2)
FROM table_name
GROUP BY column_1
HAVING search_condition;

SELECT *
FROM [production].[products]

SELECT brand_id, AVG(list_price) AS 'AVG Price'
FROM production.products
GROUP BY brand_id

SELECT brand_id, AVG(list_price) AS 'AVG Price'
FROM production.products
GROUP BY brand_id
HAVING AVG(list_price) > 500                             -- we can input a criteria. HAVING filters the results after grouped.


-- CASE 
/*
Every CASE expression must end with the END keyword
*/

SELECT *
FROM [production].[products]

SELECT
CASE [model_year]
WHEN 2016 THEN 'This is old'
ELSE 'This is new'
END AS cars
FROM [production].[products]
GROUP BY model_year


SELECT
CASE 
WHEN model_year < 2018 THEN 'This is old'
ELSE 'This is new'
END AS cars
FROM [production].[products]
GROUP BY model_year

-- CROSS JOIN   cartesian product

SELECT colors.color, brands.brand           -- used to combine each row of the first table with each row of the second table.
FROM colors
CROSS JOIN brands

-- SELF JOIN 
/*
Join table to itself
*/

-- For example we have table (employees), emp_id, fname, lname, mng_id

SELECT A.emp_id, A.fname, A.lname, B.fname AS 'Manager'
FROM employees AS A
LEFT JOIN employees AS B
ON A.mng_id = B.emp_id

-- UNION / UNION ALL

/*
UNION is used to combine similar columns of different tables.
Both select statements, must contain the same number of columns.
Corresponding columns must have the same data type.
*/

-- UNION doesn't duplicate same values, UNION ALL duplicates. (Like concat on row index.)

SELECT first_name, last_name, 'staff' AS [Type]
FROM sales.staffs 
UNION                                            -- UNION ALL
SELECT first_name, last_name, 'customer' AS[Type]
FROM sales.customers
ORDER BY first_name, last_name

-- VIEW

CREATE VIEW sales.product_info                   -- ORDER BY invalid in VIEW
AS
SELECT b.brand_name, p.product_name, p.list_price
FROM production.products as p
INNER JOIN production.brands as b
ON b.brand_id = p.brand_id;

-- VIEW create a small table (database object)

SELECT *
FROM sales.product_info

-- CTE(Common Table Expression) / WITH
/*
it is a inline VIEW.
VIEW is a physical object on database but CTE is temporarily.
*/

-- Ordinary / Non-recursice CTE

WITH  cte_sales_amounts (staff, sales, [year]) AS (           
    SELECT
        first_name + ' ' + last_name,
        SUM(quantity * list_price * (1 - discount)),
        YEAR(order_date)
    FROM
        sales.orders o
    INNER JOIN sales.order_items i ON i.order_id = o.order_id
    INNER JOIN sales.staffs s ON s.staff_id = o.staff_id
    GROUP BY
        first_name + ' ' + last_name,
        year(order_date)
)
SELECT top 1 staff, sales FROM cte_sales_amounts
WHERE year = 2018 order by 2;


WITH cte_1 (person, m_f)
AS
(SELECT FIRSTNAME, GENDER
FROM PERSON)
SELECT person, m_f FROM cte_1

-- Recursive CTE

WITH cte
    AS (SELECT 1 AS n -- anchor member
        UNION ALL
        SELECT n + 1 -- recursive member
        FROM   cte
        WHERE  n < 10 -- terminator)
SELECT n
FROM cte;

WITH COMP(empid,ename,mgrid,lvl) AS (
 SELECT EMPLOYEE_ID,EMPLOYEE_NAME,MANAGER_ID,0 as lvl
  FROM COMPANY
  WHERE MANAGER_ID=3
 UNION ALL
 SELECT EMPLOYEE_ID,EMPLOYEE_NAME,MANAGER_ID,lvl+1
  FROM COMP R INNER JOIN COMPANY F
  ON F.MANAGER_ID = R.empid
)
SELECT A.EMPID,A.ENAME,A.MGRID,A.LVL,
       B.EMPLOYEE_NAME AS MGR_NAME
 FROM COMP A LEFT JOIN COMPANY B
 ON A.MGRID=B.EMPLOYEE_ID
 ORDER BY A.LVL,A.EMPID

