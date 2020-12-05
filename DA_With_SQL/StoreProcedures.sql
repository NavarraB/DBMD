/** 

                         Stored Procedure Basics

If you ever find yourself writing the same SQL query over and over again, a Stored Procedure could be just the
time-saving tool you're looking for. 
You can chech from Programmability
If you execute a query again and again you can creata a store procedure then just execute it by iys name
A group of select query under a sýngle heading.

**/


-- 1. Basic Query

SELECT
	Title,
	ReleaseDate,
	RunTimeMinutes
FROM
	Film
ORDER BY
	RunTimeMinutes DESC

-- 2. Creating SP

USE Movies -- nn
GO -- begins a new batch -- not necessaary

CREATE PROCEDURE spFilmList -- OR PROC
AS
BEGIN -- NOT NECESSARY
SELECT 
	Title,
	ReleaseDate,
	RunTimeMinutes
FROM
	Film
ORDER BY
	RunTimeMinutes DESC
END -- nn

-- 2. EXECUTION OF sp

EXECUTE spFilmList -- or EXEC or just select spFilmlist

-- 3. Modifying

-- if you need to change sth just write alter instead of Create. You can also modify iT by using object explorer page.
-- we can modify also from object explorer

USE Movies -- nn
GO -- begins a new batch -- nn

ALTER PROCEDURE spFilmList -- OR PROC
AS
BEGIN -- NOT NECESSARY
SELECT 
	Title,
	ReleaseDate,
	RunTimeMinutes
FROM
	Film
ORDER BY
	RunTimeMinutes DESC
END -- nn

EXEC spFilmList


-- 4. Deleting sp

DROP PROC spFilmList

--||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

-- Stored Procedure Parameters
-- Stored Procedures are extremely useful tools in SQL Server, and they become even more powerful
-- when you use parameters to pass information to them.  


-- 1. Store Procedure with one parameter

USE Movies
GO

CREATE PROC spFilmListCriteria
	(
		@MinLength AS INT     -- Adding parameter    -- drop proc spFilmListCriteria
	) 
AS
BEGIN
	SELECT
		Title,
		RunTimeMinutes
	FROM
		Film
	WHERE RunTimeMinutes > @MinLength
	ORDER BY
		RunTimeMinutes ASC
END

-- you can use it without variable.

	EXEC spFilmListCriteria 150
	EXEC spFilmListCriteria @MinLength = 150


-- 2. Adding second parameters

USE Movies
GO
ALTER PROC spFilmListCriteria
	(
		@MinLength AS INT,
		@MaxLength AS INT
	) 
AS
BEGIN
	SELECT
		Title,
		RunTimeMinutes
	FROM
		Film
	WHERE 
		RunTimeMinutes >= @MinLength AND
		RunTimeMinutes <= @MaxLength
	ORDER BY
		RunTimeMinutes ASC
END

EXEC spFilmListCriteria 180,200

EXEC spFilmListCriteria @MinLength = 180, @MaxLength = 200  -- With parametes's name.

-- 3. Adding third parameter as a text

USE Movies
GO
ALTER PROC spFilmListCriteria
	(
		@MinLength AS INT,
		@MaxLength AS INT,
		@Title AS VARCHAR(MAX)
	) -- Adding parameter
AS
BEGIN
	SELECT
		Title,
		RunTimeMinutes
	FROM
		Film
	WHERE 
		RunTimeMinutes >= @MinLength AND
		RunTimeMinutes <= @MaxLength AND
		Title LIKE '%' + @Title + '%'  --  IT WONT WORk IF YOU TYPE '%@Title%'. u need concat 
	ORDER BY
		RunTimeMinutes ASC
END


EXEC spFilmListCriteria 150,200,'LORD'



-- CREATING OPTIONAL PARAMETERS

-- FIRST WAY TO THIS GIVE A DEFAULT VALUE.

USE Movies
GO
ALTER PROC spFilmListCriteria
	(
		@MinLength AS INT = 0,
		@MaxLength AS INT,
		@Title AS VARCHAR(MAX)
	) -- Adding parameter
AS
BEGIN
	SELECT
		Title,
		RunTimeMinutes
	FROM
		Film
	WHERE 
		RunTimeMinutes >= @MinLength AND
		RunTimeMinutes <= @MaxLength AND
		Title LIKE '%' + @Title + '%'  --  IT WONT WORJ OF YOU TYPE '%@Title%'. u need concat 
	ORDER BY
		RunTimeMinutes ASC
END

EXEC spFilmListCriteria @Title = 'Die', @MaxLength = 200


-----

USE Movies
GO
ALTER PROC spFilmListCriteria
	(
		@MinLength AS INT = NULL,  -- maYBE YOU CAN PREDICT MIN. YOU CAN SAY 0 FOR MAX 1000 BUT THIS IS MORE APPROIATE.
		@MaxLength AS INT = NULL,  
		@Title AS VARCHAR(MAX)
	) -- Adding parameter
AS
BEGIN
	SELECT
		Title,
		RunTimeMinutes
	FROM
		Film
	WHERE 
		(@MinLength IS NULL OR RunTimeMinutes >= @MinLength) AND
		(@MaxLength IS NULL OR RunTimeMinutes <= @MaxLength) AND
		Title LIKE '%' + @Title + '%'  --  IT WONT WORJ OF YOU TYPE '%@Title%'. u need concat 
	ORDER BY
		RunTimeMinutes ASC
END

EXEC spFilmListCriteria @Title = 'STAR' -- its sth like that min is 0 max is infinite.