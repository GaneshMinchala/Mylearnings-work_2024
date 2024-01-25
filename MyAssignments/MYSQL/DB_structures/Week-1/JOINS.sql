CREATE DATABASE IF NOT exists Little_Lemon_Restaurant;
USE Little_Lemon_Restaurant;
CREATE table if not exists Customers(
CustomerID int not null, 
FullName varchar(120) default null,
PhoneNumber varchar(120) default null,
primary key(CustomerID)
);

insert INTO Customers VALUES (1,'Vanessa McCarthy','757536378'),
(2,'Marcos Romero','757536379'),
(3,'Hiroki Yamane','757536376'),
(4,'Anna Iversen','757536375'),
(5,'Diana Pinto','757536374');

Select * from Customers;

create table if not exists Bookings
(BookingID int not null primary key default 0,
BookingDate date not null,
TableNumber int not null,
NumberOfGuests int not null,
CustomerID int not null,
foreign key(CustomerID) references Customers(CustomerID)
);
insert into Bookings values (10, '2021-11-11', 7,5,1),
(11,'2021-11-10',5,2,2),
(12,'2021-11-10',3,2,4);
select * from Bookings;
#INNER JOINS
SELECT Customers.FullName, Bookings.BookingID 
 FROM Customers INNER JOIN Bookings 
 ON Customers.CustomerID = Bookings.CustomerID;
 
 SELECT Cust.FullName, BkInfo.BookingID
 from Customers as Cust, Bookings as BkInfo 
where Cust.CustomerID = BkInfo.CustomerID;

#LEFT JOIN
SELECT Customers.FullName, Bookings.BookingID 
FROM Customers LEFT JOIN Bookings 
ON Customers.CustomerID = Bookings.CustomerID; 

#RIGHT JOIN
SELECT Customers.FullName, Bookings.BookingID 
FROM Customers RIGHT JOIN Bookings 
ON Customers.CustomerID = Bookings.CustomerID;

#SELF JOIN
select *
from Customers c1, Customers c2
where c1.CustomerID = c2.CustomerID;

#Task 1: Little Lemon want a list of all customers who have made bookings. Write an INNER JOIN SQL statement to combine the full name and the phone number of each customer from the Customers table with the related booking date and 'number of guests' from the Bookings table. 
select c.FullName, c.PhoneNumber, b.BookingDate,b.NumberOfGuests
from Customers c, Bookings b
where c.CustomerID = b.CustomerID;
#another way
select c.FullName, c.PhoneNumber, b.BookingDate,b.NumberOfGuests
from Customers c inner join Bookings b
on c.CustomerID = b.CustomerID;

#Task 2: Little Lemon want to view information about all existing customers with bookings that have been made so far. This data must include customers who haven’t made any booking yet. 
select C.CustomerID, b.BookingID
from Customers c left join Bookings b
on c.CustomerID = b.CustomerID;

