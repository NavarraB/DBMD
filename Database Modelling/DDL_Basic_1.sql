-- DDL

-- CREATE DATABASE

CREATE DATABASE TestDb;

USE TestDb;

SELECT *                              -- list all databases on system
FROM master.sys.databases
ORDER BY name;

EXEC sp_databases;                    -- list all databases on system

-- DROP DATABASE

DROP DATABASE IF EXISTS TestDb;       -- you have to be on another db or master

-- CREATE SCHEMA

CREATE SCHEMA customer_services;

-- CREATE TABLE

CREATE TABLE customer_services.jobs(
    job_id INT PRIMARY KEY IDENTITY,                    -- column dtype constraints
    customer_id INT NOT NULL,
    [description] VARCHAR(200),
    created_at DATETIME2 NOT NULL 
)

CREATE TABLE dbo.offices(                              -- dbo is default schema
    office_id INT PRIMARY KEY IDENTITY,
    office_name NVARCHAR(40) NOT NULL,
    office_address NVARCHAR(255) NOT NULL,
    phone VARCHAR(20)
)

INSERT INTO dbo.offices(office_name, office_address)
VALUES('Silicon Valley','400 North 1st Street, San Jose, CA 95130'),
('Sacramento','1070 River Dr., Sacramento, CA 95820');

SELECT *
FROM dbo.offices                            -- dbo is default schema we can write offices

-- ALTER SCHEMA OF TABLE

ALTER SCHEMA customer_services
TRANSFER OBJECT ::dbo.offices;              -- we change dbo schema to customer_services for offices table

-- DROP SCHEMA

CREATE SCHEMA logistics;

CREATE TABLE logistics.deliveries
(
    order_id        INT
    PRIMARY KEY, 
    delivery_date   DATE NOT NULL, 
    delivery_status TINYINT NOT NULL
);

DROP SCHEMA IF EXISTS logistics;             -- it cant be dropped because it has table

DROP TABLE logistics.deliveries;

DROP SCHEMA IF EXISTS logistics;   

-- CREATE TABLE

CREATE TABLE customer_services.visits(
    visit_id INT PRIMARY KEY IDENTITY (1, 1),
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    visited_at DATETIME,
    phone VARCHAR (20),
    store_id INT NOT NULL,
    FOREIGN KEY (store_id) REFERENCES customer_services.offices (office_id)
)

-- ADD COLUMN with ALTER TABLE

ALTER TABLE customer_services.visits
ADD [description] VARCHAR (255) NOT NULL;

SELECT *
FROM customer_services.visits

-- MODIFY COLUMN'S DATA TYPE WITH ALTER TABLE

ALTER TABLE customer_services.visits
ALTER COLUMN visited_at VARCHAR (10) NOT NULL;

ALTER TABLE customer_services.visits
ALTER COLUMN visited_at VARCHAR (15) NOT NULL;


SELECT *
FROM customer_services.visits

-- DROP COLUMN with ALTER TABLE

ALTER TABLE customer_services.visits
DROP COLUMN [description]

-- DROP COLUMN which have CONSTRAINT (Cons. name)

CREATE TABLE price_lists(
    product_id int,
    valid_from DATE,
    price DEC(10,2) NOT NULL CONSTRAINT ck_positive_price CHECK(price >= 0),    -- becuse of constarint it cant be dropped.
    discount DEC(10,2) NOT NULL,
    surcharge DEC(10,2) NOT NULL,
    note VARCHAR(255),
    PRIMARY KEY(product_id, valid_from)
);

ALTER TABLE price_lists
DROP CONSTRAINT ck_positive_price

ALTER TABLE price_lists
DROP COLUMN price

SELECT *
FROM price_lists

-- CREATE COLUMN with other columns

ALTER TABLE customer_services.visits
ADD full_name AS (first_name + ' ' + last_name)

SELECT full_name
FROM customer_services.visits

-- DROP TABLE

DROP TABLE IF EXISTS price_lists;

-- TRUNCATE TABLE

CREATE TABLE customer_groups (
    group_id INT PRIMARY KEY IDENTITY,
    group_name VARCHAR (50) NOT NULL
);

INSERT INTO customer_groups (group_name)
VALUES ('Intercompany'), ('Third Party'), ('One time');

SELECT * 
FROM customer_groups

TRUNCATE TABLE customer_groups                -- it deletes all info without log

SELECT * 
FROM customer_groups

--IDENTITY

IDENTITY[(seed,increment)]

IDENTITY (10,10)                -- start from 10 and goes 10, 20, 30 (+10)

CREATE SCHEMA hr;

CREATE TABLE hr.person (
    person_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender CHAR(1) NOT NULL
);

INSERT INTO hr.person(first_name, last_name, gender)
OUTPUT inserted.person_id                            -- we can see person_id each time
VALUES('John','Doe', 'M');

SELECT *
FROM hr.person

SELECT @@IDENTITY

-- PRIMARY KEY

CREATE TABLE table_name (
    pk_column_1 data_type PRIMARY KEY,
    pk_column_2 data type,
    ...
    PRIMARY KEY (pk_column_1, pk_column_2)        -- if we add two PK(composite key) we use CONSTRAINT line (last line)
);

ALTER TABLE table_name
ADD PRIMARY KEY column_name

-- FOREIGN KEY

CREATE TABLE procurement.vendors (
        vendor_id INT IDENTITY PRIMARY KEY,
        vendor_name VARCHAR(100) NOT NULL,
        group_id INT NOT NULL,
        CONSTRAINT fk_group FOREIGN KEY (group_id) 
        REFERENCES procurement.vendor_groups(group_id)            -- we use reference (another table's PK)
);

CREATE TABLE tblRoom
(HotelNo Int NOT NULL,
RoomNo Int NOT NULL,
Type Char(50) NULL,
Price Money NULL,
PRIMARY KEY (HotelNo, RoomNo),                             -- Two PK as a composite key
FOREIGN KEY (HotelNo) REFERENCES tblHotel)                 -- One FK

-- UNIQUE

CREATE TABLE hr.persons(
    person_id INT IDENTITY PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE
);

CREATE TABLE hr.persons(
    person_id INT IDENTITY PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    UNIQUE(email)
);

CREATE TABLE hr.persons (
    person_id INT IDENTITY PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    CONSTRAINT unique_email UNIQUE(email)
);

ALTER TABLE hr.persons
ADD CONSTRAINT unique_email UNIQUE(email);

ALTER TABLE hr.persons
ADD CONSTRAINT unique_phone UNIQUE(phone);

-- Delete UNIQUE constraints

ALTER TABLE table_name
DROP CONSTRAINT constraint_name;

ALTER TABLE hr.persons
DROP CONSTRAINT unique_phone;

-- CHECK

CREATE TABLE products(
    product_id INT IDENTITY PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    unit_price DEC(10,2) CONSTRAINT positive_price CHECK(unit_price > 0)
);

INSERT INTO test.products(product_name, unit_price)
VALUES ('Awesome Free Bike', 0);                      -- error

INSERT INTO test.products(product_name, unit_price)
VALUES ('Awesome Bike', 599);

CREATE TABLE test.products(
    product_id INT IDENTITY PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    unit_price DEC(10,2) CHECK(unit_price > 0),
    discounted_price DEC(10,2) CHECK(discounted_price > 0),
    CHECK(discounted_price < unit_price)
);

CREATE TABLE test.products(
    product_id INT IDENTITY PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    unit_price DEC(10,2),
    discounted_price DEC(10,2),
    CHECK(unit_price > 0),
    CHECK(discounted_price > 0),
    CHECK(discounted_price > unit_price)
);

CREATE TABLE test.products(
    product_id INT IDENTITY PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    unit_price DEC(10,2),
    discounted_price DEC(10,2),
    CHECK(unit_price > 0),
    CHECK(discounted_price > 0),
    CONSTRAINT valid_prices CHECK(discounted_price > unit_price)
);

-- Add CHECK constraints to an existing table

CREATE TABLE test.products(
    product_id INT IDENTITY PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    unit_price DEC(10,2) NOT NULL
);

ALTER TABLE test.products
ADD CONSTRAINT positive_price CHECK(unit_price > 0);

ALTER TABLE test.products
ADD discounted_price DEC(10,2)
CHECK(discounted_price > 0);

ALTER TABLE test.products
ADD CONSTRAINT valid_price 
CHECK(unit_price > discounted_price);

-- Remove CHECK constraints

ALTER TABLE table_name
DROP CONSTRAINT constraint_name;              -- then we can drop column

ALTER TABLE test.products
DROP CONSTRAINT positive_price;

-- Disable CHECK constraints for insert or update

ALTER TABLE table_name
NOCHECK CONSTRAINT constraint_name;

ALTER TABLE test.products
NOCHECK CONSTRAINT valid_price;
