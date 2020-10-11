-- Data Definition Language (DDL)

-- Create Database

CREATE DATABASE SW

USE SW

-- Create Table

-- CREATE TABLE table_name
-- (Columnname1, Dtype, optional Constraints
-- Columnname2, Dtype, optional Constraints)

CREATE TABLE employees
(EmployeeNo CHAR(10) NOT NULL UNIQUE,
DepartmentName CHAR(30) NOT NULL DEFAULT 'Human Resources',
FirstName CHAR(25) NOT NULL,
LastName CHAR(25) NOT NULL,
Category CHAR(20) NOT NULL,
HourlyRate DATETIME NOT NULL,
TimeCard BIT NOT NULL,
HourlySalaried CHAR(1)NOT NULL,
EmpType CHAR(1) NOT NULL,
Terminated BIT NOT NULL,
ExemptCode CHAR(2) NOT NULL,
Supervisor BIT NOT NULL,
SupervisorName CHAR(50) NOT NULL,
BirthDate DATE NOT NULL,
CollegeDegree CHAR(5) NOT NULL,
CONSTRAINT employees_PK PRIMARY KEY(EmployeeNo))


CREATE TABLE DEPARTMENT
(
DepartmentName Char(35) NOT NULL,
BudgetCode Char(30) NOT NULL,
OfficeNumber Char(15) NOT NULL,
Phone Char(15) NOT NULL,
CONSTRAINT DEPARTMENT_PK PRIMARY KEY(DepartmentName)
)

CREATE TABLE PROJECT
(
ProjectID Int NOT NULL IDENTITY (1000,100),
ProjectName Char(50) NOT NULL,
Department Char(35) NOT NULL,
MaxHours Numeric(8,2) NOT NULL DEFAULT 100,
StartDate DateTime NULL,
EndDate DateTime NULL,
CONSTRAINT ASSIGNMENT_PK PRIMARY KEY(ProjectID)
);

CREATE TABLE ASSIGNMENT
(
ProjectID INT NOT NULL,
EmployeeNumber Int NOT NULL,
HoursWorked Numeric(6,2)NULL
)

-- IDENTITY constraint
-- Usually used with PK. for numeric data types.

-- IDENTITY (inital value, increment)

CREATE TABLE tblHotel
(HotelNo Int IDENTITY (1,1),
Name Char(50) NOT NULL,
Address Char(50) NULL,
City Char(25) NULL)

-- PK, FK

CREATE TABLE tblRoom
(HotelNo Int NOT NULL,
RoomNo Int NOT NULL,
Type Char(50) NULL,
Price Money NULL,
PRIMARY KEY (HotelNo, RoomNo),
FOREIGN KEY (HotelNo) REFERENCES tblHotel)

-- CHECK constraint

CREATE TABLE tblRoom
(HotelNo Int NOT NULL,
RoomNo Int NOT NULL,
Type Char(50) NULL,
Price Money NULL,
PRIMARY KEY (HotelNo, RoomNo),
FOREIGN KEY (HotelNo) REFERENCES tblHotel,
CONSTRAINT Valid_Type
CHECK (Type IN ('Single', 'Double', 'Suite', 'Executive')))           -- it rules Type columns should be 'Single', 'Double', 'Suite', 'Executive' only.

CREATE TABLE SALESREPS
(Empl_num Int Not Null,
CHECK (Empl_num BETWEEN 101 and 199),
Name Char (15),
Age Int CHECK (Age >= 21),
Quota Money CHECK (Quota >= 0.0),
HireDate DateTime,
CONSTRAINT QuotaCap CHECK ((HireDate < “01-01-2004”) OR (Quota <=300000)));      -- double check with and/or

-- User Defined Types

CREATE TYPE TypeName FROM VARCHAR(100) NOT NULL 

-- ALTER TABLE

ALTER TABLE employees
ADD CONSTRAINT emp_category 
DEFAULT 'HR' FOR Category

-- DROP TABLE

DROP TABLE tblHotel