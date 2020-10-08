CREATE DATABASE Manufacturer;

USE Manufacturer;

CREATE TABLE products
(productID INT PRIMARY KEY,
productname Char(50) NOT NULL,
quantity INT);

CREATE TABLE suppliers
(supplierID INT PRIMARY KEY,
suppliername Char(50) NOT NULL);

CREATE TABLE components
(componentID INT PRIMARY KEY,
productID INT,
supplierID INT,
[name] char(50) NOT NULL,
[description] char(150),
FOREIGN KEY (productID) REFERENCES products,
FOREIGN KEY (supplierID) REFERENCES suppliers);