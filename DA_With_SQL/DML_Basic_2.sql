-- DATA Manipulation Language (DML)

-- INSERT

SELECT *
FROM authors

INSERT INTO Authors
VALUES('555-93-4627', 'Martin', 'April', '281 555-5673', '816 Market St.', 'Vancouver', 'BC', '34431', 0);

SELECT *
FROM publishers

INSERT INTO Publishers (pub_id, pub_name, city, [state])          -- country column has a default value as an USA
VALUES ('9900', 'Acme Publishing', 'Vancouver', 'BC');

SELECT *
FROM jobs

INSERT INTO jobs
VALUES ('DBA', 100, 175);             -- job_id has a IDENTITY

-- INSERT INTO an IDENTITY column

SET IDENTITY_INSERT jobs ON
INSERT INTO jobs (job_id, job_desc, min_lvl, max_lvl)
VALUES (4, 'DBA2', 100, 175)
SET IDENTITY_INSERT jobs OFF;

-- INSERT with SELECT

CREATE TABLE dbo.tmpPublishers(                      -- we create temporary small table
pub_id char(4) NOT NULL,
pub_name varchar(40) NULL,
city varchar(20) NULL,
[state] char(2) NULL,
country varchar(30) NULL DEFAULT ('USA')
)

SELECT *
FROM tmpPublishers
 
INSERT tmpPublishers                         -- we add publishers data to temporary table wşth SELECT
SELECT * FROM publishers

SELECT *
FROM tmpPublishers

INSERT tmpPublishers (pub_id, pub_name)       -- we add publishers's specific data to temporary table wşth SELECT
SELECT pub_id, pub_name
FROM publishers

INSERT tmpPublishers (pub_id, pub_name, city, [state], country)
SELECT pub_id, pub_name, city, [state], 'USA'
FROM publishers;

SELECT *
FROM tmpPublishers

-- UPDATE

SELECT *
FROM publishers

UPDATE publishers                            -- we update country column as a Mexico
SET country = 'Mexico'

SELECT *
FROM roysched

UPDATE roysched                              -- we update royalty column with conditions
SET royalty = royalty + (royalty * .10)
WHERE royalty BETWEEN 10 AND 20

-- UPDATE Including subqueries

SELECT *
FROM employee

SELECT *
FROM jobs

UPDATE employee
SET job_lvl = 
(SELECT max_lvl FROM jobs
WHERE employee.job_id = jobs.job_id)
WHERE DATEPART(year, employee.hire_date) = 2010;

SELECT *
FROM employee

-- DELETE

DELETE FROM discounts             -- it deletes all rows in the table

DELETE FROM sales                 -- it deletes the rown that meet condition
WHERE stor_id = '6380'

DELETE FROM sales                  -- DELETE with subqueries
WHERE titles IN 
   (SELECT title_id FROM Books WHERE type = 'mood');



