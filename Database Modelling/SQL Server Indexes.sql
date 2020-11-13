--SQL Server Indexes

--Indexes are special data structures associated with tables or views that help speed up the query.
--SQL Server provides two types of indexes: clustered index and non-clustered index.
--A clustered index stores data rows in a sorted structure based on its key values.
--Each table has only one clustered index because data rows can be only sorted in one order.
--The table that has a clustered index is called a clustered table.

CREATE TABLE production.parts(
    part_id   INT NOT NULL, 
    part_name VARCHAR(100)
);

INSERT INTO 
    production.parts(part_id, part_name)
VALUES
    (1,'Frame'),
    (2,'Head Tube'),
    (3,'Handlebar Grip'),
    (4,'Shock Absorber'),
    (5,'Fork');

SELECT 
    part_id, 
    part_name
FROM 
    production.parts
WHERE 
    part_id = 5;

--SQL Server Management Studio, you click the Display Estimated Execution Plan button or select the query and press the keyboard shortcut Ctrl+L:

CREATE CLUSTERED INDEX index_name ON schema_name.table_name (column_list);

CREATE CLUSTERED INDEX ix_parts_id ON production.parts (part_id);

--SQL Server Clustered Index and Primary key constraint

CREATE TABLE production.part_prices(
    part_id int,
    valid_from date,
    price decimal(18,4) not null,
    PRIMARY KEY(part_id, valid_from) 
);

***

--SQL Server non-clustered indexes
--Unlike a clustered index, a nonclustered index sorts and stores data separately from the data rows in the table.

CREATE [NONCLUSTERED] INDEX index_name ON table_name(column_list);

CREATE INDEX ix_customers_city ON sales.customers(city);

***

--SQL Server unique index

--A unique index ensures the index key columns do not contain any duplicate values.
--A unique index can be clustered or non-clustered.

CREATE UNIQUE INDEX index_name ON table_name(column_list);
CREATE UNIQUE INDEX ix_cust_email ON sales.customers(email);

***

--SQL Server Disable Index statements

ALTER INDEX index_name ON table_name DISABLE;
ALTER INDEX ALL ON table_name DISABLE;

ALTER INDEX ix_customers_city ON sales.customers DISABLE;
ALTER INDEX ALL ON sales.customers DISABLE;

***

--Enable index using ALTER INDEX and CREATE INDEX statements

ALTER INDEX index_name ON table_name REBUILD;
ALTER INDEX ALL ON table_name REBUILD;

ALTER INDEX ALL ON sales.customers REBUILD;

DBCC DBREINDEX (table_name, index_name);

***

--SQL Server DROP INDEX

DROP INDEX [IF EXISTS] index_name ON table_name;

DROP INDEX IF EXISTS ix_cust_email ON sales.customers;
