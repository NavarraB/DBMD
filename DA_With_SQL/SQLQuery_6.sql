-- CREATE DATABASE

CREATE DATABASE food2
ON
(
Name=FoodData1,
FileName='/home/FoodData1.mdf',
size=10MB, --KB, MB,GB,TB
maxsize=unlimited,
filegrowth= 1GB
)
log on
(
Name=FoodLog,
FileName='/home/FoodLog1.ldf',
size=10MB, --KB, MB, GB,TB
maxsize=unlimited,
filegrowth= 1024MB
)


CREATE DATABASE food
GO

USE food

CREATE TABLE snack
( [snack name] varchar(50),
   [amount] int,
   [calories] int
)

SELECT *
FROM snack

INSERT snack
SELECT 'Cholote Raisins',10,100

INSERT snack
SELECT 'Honeycomb',10,15

CREATE DATABASE food2

USE food2

CREATE SYNONYM snack FOR food.snack

SELECT *
FROM snack

USE BikeStores
-- SQL Server Date Functions

SELECT SYSDATETIME()     -- it gives actual time (of system)

SELECT GETUTCDATE()      -- it gives GMT time

SELECT GETDATE()         -- it gives actual time 

SELECT CONVERT(CHAR(20), GETDATE(),113)       -- 03 Oct 2020 18:09:21

SELECT CONVERT(CHAR(20), GETDATE(),112)       -- 20201003            

SELECT CURRENT_TIMESTAMP AS current_date_time

SELECT SYSUTCDATETIME()                                -- 2020-10-03 15:13:14.7801481

SELECT CONVERT(DATE, SYSUTCDATETIME()) AS utc_date     -- 2020-10-03

SELECT DATENAME (YEAR,GETDATE())
SELECT DATENAME (quarter,GETDATE()) --
SELECT DATENAME (MONTH,GETDATE()) --
SELECT DATENAME (dayofyear,GETDATE()) --
SELECT DATENAME (DAY,GETDATE()) --
SELECT DATENAME (week,GETDATE()) --
SELECT DATENAME (weekday,GETDATE()) --
SELECT DATENAME (hour,GETDATE()) --
SELECT DATEPART (ISO_WEEK,GETDATE()) --
SELECT DATEPART (MINUTE,GETDATE()) --


-- DATEADD

SELECT '2007-01-01 00:00:00', DATEADD(YEAR,10,'2007-01-01 00:00:00.000')
SELECT '2007-01-01 00:00:00', DATEADD(quarter,100,'2007-01-01 00:00:00.000')
SELECT '2007-01-01 00:00:00', DATEADD(MONTH,100,'2007-01-01 00:00:00.000')
SELECT '2007-01-01 00:00:00', DATEADD(dayofyear,100,'2007-01-01 00:00:00.000')
SELECT '2007-01-01 00:00:00', DATEADD(DAY,100,'2007-01-01 00:00:00.000')
SELECT '2007-01-01 00:00:00', DATEADD(week,100,'2007-01-01 00:00:00.000')
SELECT '2007-01-01 00:00:00', DATEADD(weekday,100,'2007-01-01 00:00:00.000')
SELECT '2007-01-01 00:00:00', DATEADD(hour,100,'2007-01-01 00:00:00.000')
SELECT '2007-01-01 00:00:00', DATEADD(minute,100,'2007-01-01 00:00:00.000')
SELECT '2007-01-01 00:00:00', DATEADD(second ,100,'2007-01-01 00:00:00.000')
SELECT '2007-01-01 00:00:00', DATEADD(millisecond,100,'2007-01-01 00:00:00.000')

-- DATEDIFF

SELECT DATEDIFF(DAY,'15 jul  2016','1 feb  2020')
SELECT DATEDIFF(DAY,'1 feb  2008','1 mar 2008')

-- FORMATTING DATES

SELECT DATENAME(dw,GETDATE()) --To get the full Weekday name
SELECT LEFT(DATENAME(dw,GETDATE()),3) --abbreviated Weekday name (MON, TUE, WED etc)
SELECT DATEPART(dw,GETDATE())+(((@@Datefirst+3)%7)-4) --ISO-8601 Weekday number
SELECT RIGHT('00' + CAST(DAY(GETDATE()) AS VARCHAR),2)--Day of month -- leading zeros
SELECT CAST(DAY(GETDATE()) AS VARCHAR) --Day of the month without leading space
SELECT DATEPART(dy,GETDATE()) --day of the year

-- SQL Server String Functions
/*
char, nchar
varchar (8 bit), nvarchar(16 bit)
text, ntext
*/

SELECT DATALENGTH(N'Sunday')      -- 12
SELECT DATALENGTH('Sundat')       -- 6

-- SQL Server ASCII Function to get the ASCII code of a character

SELECT NCHAR(0x20Ac) 'Euro'

SELECT NCHAR(0xA3) 'Pound'

-- CHARINDEX Function

SELECT CHARINDEX('/', 'SQL Server/CHARINDEX')            -- it gives position of value (value, text)

SELECT CHARINDEX('SERVER', 'SQL Server CHARINDEX')       -- dafault CI_AS

SELECT CHARINDEX('SERVER', 'SQL Server CHARINDEX' COLLATE Latin1_General_CS_AS)   -- case sensitive

SELECT CHARINDEX('SERVER', 'SQL Server CHARINDEX' COLLATE Latin1_General_CI_AS)   -- no case sensitive

SELECT CHARINDEX('is', 'This is a my sister')               -- it starts to seacrh from beginning

SELECT CHARINDEX('is', 'This is a my sister', 10)           -- it starts to seacrh from 10.char

-- SQL Server CONCAT()

SELECT 'John' + '/' + 'Doe' AS full_name

SELECT
    CONCAT(
        CHAR(13),
        CONCAT(first_name,' ',last_name),
        CHAR(13),
        phone,
        CHAR(13),
        CONCAT(city,' ',state),
        CHAR(13),
        zip_code
    ) customer_address
FROM
    sales.customers
ORDER BY
    first_name,
    last_name;