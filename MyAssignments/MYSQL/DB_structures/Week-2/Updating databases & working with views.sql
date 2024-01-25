Use lucky_shrub;
show tables;
select * from Orders;
replace into Orders set OrderID =9, ClientID='Cl1', ProductID='P1',Quantity=5, Cost = 5000.00;
select * from Orders;
replace into Orders set OrderID =9, ClientID='Cl1', ProductID='P1',Quantity=5, Cost = 500.00;
select * from Orders;

use little_lemon_restaurant;
create table if not exists Starters( 
StarterName varchar(120) not null primary key,
Cost decimal(4,2) not null default 0,
StarterType varchar(100) default 'Mediterranean'
);
show table status ;
show tables;
desc Starters; /*skeleton of table*/
#Task 1: Use the REPLACE statement to insert a new data record with the following details. 
replace into Starters(StarterName, Cost, StarterType) VALUES ('Cheese bread', 9.50, 'Indian');
select * from Starters;
REPLACE INTO Starters set Cost = 9.75, StarterName='Cheese bread', StarterType='Indian';




