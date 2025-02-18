create database project4;

go

use project4;

create table Employees(
empID int,
lastname nvarchar(20),
firstname nvarchar(10),
title nvarchar(30),
titleofcourtesy nvarchar(25),
birthdate date
check (birthdate<=Current_timestamp),
hiredata date,
address nvarchar(60),
city nvarchar(15),
region nvarchar(15),
postalcode nvarchar(10),
country nvarchar(15),
phone nvarchar(24),
mgrid int,
primary key (empID),
foreign key (mgrID) references Employees(empID)
);

create nonclustered index lastname on Employees(lastname);
create nonclustered index postalcode on Employees(postalcode);

create table Suppliers(
supplierID int,
companyname nvarchar(40),
contactname nvarchar(30),
contacttitle nvarchar(30),
address nvarchar(60),
city nvarchar(15),
region nvarchar(15),
postalcode nvarchar(10),
country nvarchar(15),
phone nvarchar(24),
fax nvarchar(24),
primary key (supplierID)
);

create nonclustered index companyname on Suppliers(companyname);
create nonclustered index postalcode on Suppliers(postalcode);

create table Categories(
categoryID int,
categoryname nvarchar(15),
description nvarchar(200),
primary key (categoryID)
);

create index categoryname on Categories(categoryname);

create table Products(
productID int,
productname nvarchar(40),
supplierID int,
categoryID int,
unitprice money
check (unitprice>=0),
discontinued BIT,
primary key(productID),
foreign key (supplierID) references Suppliers(supplierID),
foreign key (categoryID) references Categories(categoryID)
);

create nonclustered index categoryID on Products(categoryID);
create nonclustered index productname on Products(productname);
create nonclustered index supplierID on Products(supplierID);

create table Customers(
custID int,
companyname nvarchar(40),
contactname nvarchar(30),
contacttitle nvarchar(30),
address nvarchar(60),
city nvarchar(15),
region nvarchar(15),
postalcode nvarchar(10),
country nvarchar(15),
phone nvarchar(24),
fax nvarchar(24),
primary key (custID)
);

create nonclustered index city on Customers(city);
create nonclustered index companyname on Customers(companyname);
create nonclustered index postalcode on Customers(postalcode);
create nonclustered index region on Customers(region);

create table Shippers(
shipperID int,
companyname nvarchar(40),
phone nvarchar(24),
primary key (shipperID)
);

create nonclustered index companyname on Shippers(companyname);
create nonclustered index phone on Shippers(phone);

create table Orders(
orderID int,
custID int,
empID int,
orderdate date,
requireddate date,
shippeddate date,
shipperID int,
freight money,
shipname nvarchar(40),
shipaddress nvarchar(60),
shipcity nvarchar(15),
shipregion nvarchar(15),
shippostalcode nvarchar(10),
shipcountry nvarchar(15),
primary key (orderID),
foreign key (custID) references Customers(custID),
foreign key (empID) references Employees(empID),
foreign key (shipperID) references Shippers(shipperID),
);

create nonclustered index custID on Orders(custID);
create nonclustered index empID on Orders(empID);
create nonclustered index shipperID on Orders(shipperID);
create nonclustered index orderdate on Orders(orderdate);
create nonclustered index shippeddate on Orders(shippeddate);
create nonclustered index shippostalcode on Orders(shippostalcode);

create table OrderDetails(
orderID int,
productID int,
unitprice money
check (unitprice>=0),
qty smallint
check (qty>0),
discount numeric(4,3)
check (1>=discount and discount>=0),
primary key (orderID, productID),
foreign key (orderID) references Orders(orderID),
foreign key (productID) references Products(productID)
);

create nonclustered index orderID on Orderdetails(orderID);
create nonclustered index productID on Orderdetails(productID);
