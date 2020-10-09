-- Window Functions

SELECT p.*, COUNT(*) OVER (PARTITION BY p.GENDER) AS 'Gender Count'
FROM PERSON AS p

SELECT *
FROM PERSON

SELECT p.GENDER, p.FIRSTNAME, p.WEIGHT, SUM(p.WEIGHT) OVER (PARTITION BY p.GENDER ORDER BY p.WEIGHT) AS WT_RUN
FROM PERSON AS p

-- ROW_NUMBER()
/*
Creates rows start from 1. if we use with partition by it makes groups.
takes no parameter
*/

-- Create a cloumn containing row numbers ordered by ascending name

SELECT p.*,
ROW_NUMBER() OVER(ORDER BY p.FIRSTNAME) AS 'row_number'
FROM PERSON AS p

-- Create a cloumn containing row numbers within gender

SELECT p.*,
ROW_NUMBER() OVER(PARTITION BY p.GENDER ORDER BY p.FIRSTNAME) AS 'row_number'
FROM PERSON AS p

--------------------------------------------------------

-- LEAD() / LAG()

/*
LEAD peek forward number of rows
LAG look back on rows
ORDER BY is required
*/

/*
LEAD(column_name, num_rows_to_lead, def_value)
LAG(column_name, num_rows_to_lag, def_value)
*/

-- Create two additional columns using the weight
-- the next heaviest weight
-- the 2 previous lightest weight

SELECT p.FIRSTNAME, p.WEIGHT,
LEAD(p.WEIGHT,1,-1) OVER(ORDER BY p.WEIGHT) AS 'lead 1 weight',           -- (to forward)
LAG(p.WEIGHT,2,-1) OVER(ORDER BY p.WEIGHT) AS 'lag 2 weight'              -- (to back)
FROM PERSON AS p
ORDER BY p.WEIGHT

-- RANK() / DENSE_RANK()
/*
Provide ranks based on ORDER BY column
tied for first RANK --> 1,1,3,4
tied for first DENSE_RANK --> 1,1,2,3
ORDER BY required
takes no parameter
*/

-- Create ranks using ascending height within gender

SELECT p.FIRSTNAME, p.GENDER, p.HEIGHT,
RANK() OVER(PARTITION BY p.GENDER ORDER BY p.HEIGHT) AS 'rank',
DENSE_RANK() OVER(PARTITION BY p.GENDER ORDER BY p.HEIGHT) AS 'dense rank'
FROM PERSON AS p

-- FIRST_VALUE() / LAST_VALUE()
/*
Retrieves first or last value of column
*/

-- Find names of the heaviest/lightest male/female child

SELECT p.FIRSTNAME, p.GENDER, p.WEIGHT,
FIRST_VALUE(p.FIRSTNAME) OVER (PARTITION BY p.GENDER ORDER BY p.WEIGHT) AS 'Lightest',
FIRST_VALUE(p.FIRSTNAME) OVER (PARTITION BY p.GENDER ORDER BY p.WEIGHT DESC) AS 'Heaviest'
FROM PERSON AS p

/*
ROWS BETWEEN UNBOUNDED PRECEDING
AND CURRENT ROW
*/

/*
ROWS BETWEEN UNBOUNDED PRECEDING    ****
AND UNBOUNDED FOLLOWING
*/

/*
ROWS BETWEEN CURRENT ROW
AND UNBOUNDED FOLLOWING
*/

-- Find names of the heaviest/lightest male/female child

SELECT p.FIRSTNAME, p.GENDER, p.WEIGHT,
FIRST_VALUE(p.FIRSTNAME) OVER (PARTITION BY p.GENDER ORDER BY p.WEIGHT
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS 'Lightest',
LAST_VALUE(p.FIRSTNAME) OVER (PARTITION BY p.GENDER ORDER BY p.WEIGHT
ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS 'Heaviest'
FROM PERSON AS p
-- give me all rows between current row and after current row with current row

-- Compute the average weight using current, previous and next rows. Use the ROWS Window Clause.

SELECT p.FIRSTNAME, p.GENDER, p.WEIGHT, 
AVG(p.WEIGHT) OVER (PARTITION BY p.GENDER ORDER BY p.WEIGHT) AS 'AVG Cumulative'
FROM PERSON AS p

SELECT p.FIRSTNAME, p.GENDER, p.WEIGHT, 
AVG(p.WEIGHT) OVER (PARTITION BY p.GENDER ORDER BY p.WEIGHT
ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS 'AVG of -1, current, +1 rows'
FROM PERSON AS p

-- NTILE()

/*
NTILE - splits rows into a specified number of buckets
NTILE(4) for 7 row table
7/4 = 1.75 ==> 2 (2-2-2-1)
*/

SELECT p.FIRSTNAME, p.HEIGHT,
NTILE(4) OVER (PARTITION BY p.GENDER ORDER BY p.HEIGHT) AS 'GRP4_HT'
FROM PERSON AS p

SELECT p.FIRSTNAME, p.HEIGHT,
NTILE(4) OVER (ORDER BY p.HEIGHT) AS 'GRP4_HT'
FROM PERSON AS p


-- CUME_DIST()

/*
CUME_DIST distributions of values
takes no parameter
*/

SELECT p.FIRSTNAME, p.HEIGHT,
CUME_DIST() OVER (ORDER BY p.HEIGHT) AS CUMDIST_HEIGHT
FROM PERSON AS p


-- PERCENT_RANK()

/*
PERCENT_RANK computes rank and cumulative dist. value from 0 to 1
formula : rank-1 / total_rows-1
takes no parameter
*/

-- Compute the percent rank on the height

SELECT p.FIRSTNAME, p.HEIGHT,
RANK() OVER (ORDER BY p.HEIGHT) AS 'Rank of Height',
PERCENT_RANK() OVER (ORDER BY p.HEIGHT) AS 'Percent Rank of Height'
FROM PERSON AS p


-- PERCENTILE_DISC()

/*
Inverse of CUME_DIST()
PERCENTILE_DISC(percentile) WITHIN GROUP (ORDER BY ....) OVER()
*/

-- Compute the height associated with the percentiles .50 and .72

SELECT p.FIRSTNAME, p.HEIGHT,
CUME_DIST() OVER (ORDER BY p.HEIGHT),
PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY p.HEIGHT) OVER() AS 'Percent_of_50',
PERCENTILE_DISC(0.72) WITHIN GROUP (ORDER BY p.HEIGHT) OVER() AS 'Percent_of_72'
FROM PERSON AS p


SELECT DISTINCT
PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY p.HEIGHT) OVER() AS 'Percent_of_50',
PERCENTILE_DISC(0.72) WITHIN GROUP (ORDER BY p.HEIGHT) OVER() AS 'Percent_of_72'
FROM PERSON AS p

