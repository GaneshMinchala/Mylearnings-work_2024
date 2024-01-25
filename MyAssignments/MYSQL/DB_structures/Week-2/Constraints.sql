create database if not exists Mangata_Gallo;
use Mangata_Gallo;
create table if not exists Client(
ClientID int not null Primary key,
FullName varchar(100) not null, 
PhoneNumber int not null unique check(length(PhoneNumber)=10)
);
show columns from Client;

CREATE TABLE IF NOT EXISTS Items(
ItemID int not null primary key default 0,
ItemName varchar(100) not null default 'null',
Price decimal(5,2) default null
); 
show columns from Items;

CREATE TABLE IF NOT EXISTS Orders(
OrderID int not null primary key ,
ItemID int not null ,  
ClientID int not null ,
Quantity int not null check(length(Quantity)<=3) ,
Cost decimal(6,2) not null ,
foreign key(ItemID) references Items(ItemID),
foreign key(ClientID) references Client(ClientID)
);
show columns from Orders;

#lab EXERCISE :- CHANGING TABLE STRUCTURE
#Task 1: Write a SQL statement that creates the Staff table with the following columns.
#Task 2:-Write a SQL statement to apply the following constraints to the Staff table:
CREATE TABLE IF NOT exists Staff(
StaffID int not null primary key,
PhoneNumber int not null unique check(length(PhoneNumber)=10),
FullName varchar(100) not null
);
show columns from Staff;

Create table if not exists ContractInfo(
ContractID int not null primary key,
StaffID int not null, 
Salary decimal(7,2) not null,
Location varchar(50) not null default 'Texas',
StaffType varchar(20) not null check(StaffType in ("Junior","Senior")),
foreign key(StaffID) references Staff(StaffID) on delete cascade on update cascade
);
show columns from ContractInfo;

CREATE TABLE Staff1 like Staff;
show columns from Staff1; /* it can copy the exiting table and also retains the constraints #exact structure it can copy*/
select * from staff1;

use lucky_shrub;
Create table Orderscopy select * from Orders; /*#This query did not copy the constraints*/
select * from Orderscopy;
show columns from Orderscopy; /* primay key constraint is missing #The above query did not copy the constraints*/
show columns from Orders; /*In this original table primary key constraint is presented*/

create table Ordercopy2 select ClientID, ProductID, Cost from Orders where Cost >=500;
select * from Ordercopy2;

#use case of ALTER TABLE statement
use lucky_shrub;
#1.RENAME
ALTER TABLE Ordercopy2 
RENAME to Ordercopy1; 
select * from Ordercopy1;
#1.ADD column




#lab EXERCISE :- CHANGING TABLE STRUCTURE
#Task 3:- Write a SQL statement that adds a new column called 'Role' to the Staff table with the following constraints:
use mangata_gallo;
show columns from staff;
ALTER TABLE Staff 
ADD Role varchar(50) not null;
#Task 4:- Write a SQL statement that drops the Phone Number column from the 'Staff' table.
ALTER TABLE Staff
 DROP column PhoneNumber;
/*Staff1 table is copy of staff table*/

/*READING EXERCISE:- ALTER TABLE Statement*/
use little_lemon_restaurant;
CREATE TABLE IF NOT EXISTS FoodOrders(
OrderID int,
Quantity int,
Order_Status varchar(15),
Cost decimal(4,2)
);
show columns from FoodOrders;
#Task 1: Use the ALTER TABLE statement with MODIFY command to make the OrderID the primary key of the 'FoodOrders' table. 
ALTER TABLE FoodOrders
MODIFY column OrderID int primary key;
#Task 2: Apply the NOT NULL constraint to the quantity and cost columns.
ALTER TABLE FoodOrders
MODIFY Quantity int not null,
Modify Cost decimal(4,2) not null;

#Task 3: Create two new columns, OrderDate with a DATE datatype and CustomerID with an INT datatype. Declare both must as NOT NULL. Declare the CustomerID as a foreign key in the FoodOrders table to reference the CustomerID column existing in the Customers table.
alter table foodorders
add OrderDate date not null,
add CustomerID int not null,
add foreign key(CustomerID) references Customers(CustomerID);

#Task 4: Use the DROP command with ALTER statement to delete the OrderDate column from the 'FoodOrder' table. 
alter table foodorders
drop column OrderDate;

#Task 5: Use the CHANGE command with ALTER statement to rename the column Order_Status in the FoodOrders table to DeliveryStatus.
alter table foodorders
change Order_Status DeliveryStatus varchar(15);
#Task 6: Use the RENAME command with ALTER statement to change the table name from OrderStatus to FoodDeliveryStatus.
alter table foodorders
rename FoodDeliveyStatus; /*TABLE SPELL MISTAKE*/
alter table FoodDeliveyStatus
rename FoodDeliveryStatus;
show columns from FoodDeliveryStatus;


