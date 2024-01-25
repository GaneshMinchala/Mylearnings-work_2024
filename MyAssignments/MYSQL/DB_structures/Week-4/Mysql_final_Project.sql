CREATE DATABASE IF NOT EXISTS Little_Lemon;
USE Little_Lemon;
CREATE TABLE IF NOT EXISTS Customers (
    CustomerID INT NOT NULL PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    PhoneNumber INT NOT NULL UNIQUE
);
INSERT INTO Customers(CustomerID, FullName, PhoneNumber) VALUES 
(1, "Vanessa McCarthy", 0757536378), 
(2, "Marcos Romero", 0757536379), 
(3, "Hiroki Yamane", 0757536376), 
(4, "Anna Iversen", 0757536375), 
(5, "Diana Pinto", 0757536374),     
(6, "Altay Ayhan", 0757636378),      
(7, "Jane Murphy", 0753536379),      
(8, "Laurina Delgado", 0754536376),      
(9, "Mike Edwards", 0757236375),     
(10, "Karl Pederson", 0757936374);

CREATE TABLE Bookings (
    BookingID INT,
    BookingDate DATE NOT NULL,
    TableNumber INT,
    NumberOfGuests INT NOT NULL CHECK(length(NumberOfGuests)<=8),
    CustomerID INT NOT NULL,
    PRIMARY KEY(BookingID),
    FOREIGN KEY(CustomerID) references Customers(CustomerID) ON DELETE CASCADE ON UPDATE cascade
); 
INSERT INTO Bookings 
(BookingID, BookingDate, TableNumber, NumberOfGuests, CustomerID) 
VALUES 
(10, '2021-11-10', 7, 5, 1),  
(11, '2021-11-10', 5, 2, 2),  
(12, '2021-11-10', 3, 2, 4), 
(13, '2021-11-11', 2, 5, 5),  
(14, '2021-11-11', 5, 2, 6),  
(15, '2021-11-11', 3, 2, 7), 
(16, '2021-11-11', 3, 5, 1),  
(17, '2021-11-12', 5, 2, 2),  
(18, '2021-11-12', 3, 2, 4), 
(19, '2021-11-13', 7, 5, 6),  
(20, '2021-11-14', 5, 2, 3),  
(21, '2021-11-14', 3, 2, 4);
CREATE TABLE Courses (
    CourseName VARCHAR(255) PRIMARY KEY,
    Cost DECIMAL(4 , 2 )
);
INSERT INTO Courses (CourseName, Cost) VALUES 
("Greek salad", 15.50), 
("Bean soup", 12.25), 
("Pizza", 15.00), 
("Carbonara", 12.50), 
("Kabasa", 17.00), 
("Shwarma", 11.30);

							-- LET'S BEGIN DOING TASKS
-- Task 1: Filter data using the WHERE clause and logical operators.
-- Create SQL statement to print all records from Bookings table for the following bookings dates using the BETWEEN operator: 2021-11-11, 2021-11-12 and 2021-11-13. -- 
SELECT *
FROM Bookings
WHERE BookingDate between '2021-11-11' and '2021-11-13';

-- Task 2: Create a JOIN query.
-- Create a JOIN SQL statement on the Customers and Bookings tables. The statement must print the customers full names and related bookings IDs from the date 2021-11-11.
SELECT 
    Cust.FullName, BK.BookingID
FROM
    Customers AS Cust,
    Bookings AS BK
WHERE
    Cust.CustomerID = BK.CustomerID
        AND BK.BookingDate = '2021-11-11';

SELECT 
    Cust.FullName, BK.BookingID
FROM
    Customers AS Cust INNER JOIN
    Bookings AS BK
	ON Cust.CustomerID = BK.CustomerID
WHERE
    BK.BookingDate = '2021-11-11';

-- Task 3: Create a GROUP BY query.
-- Create a SQL statement to print the bookings dates from Bookings table. The statement must show the total number of bookings placed on each of the printed dates using the GROUP BY BookingDate. 

SELECT 
    BookingDate, COUNT(BookingDate)
FROM
    Bookings
GROUP BY BookingDate;

-- Task 4: Create a REPLACE statement.
-- Create a SQL REPLACE statement that updates the cost of the Kabsa course from $17.00 to $20.00.
select * from Courses;
REPLACE INTO Courses (CourseName, Cost) VALUES ("Kabasa", 20.00);
Replace into Courses set Cost = 20.00, CourseName = 'Kabasa';
select * from Courses;

Replace into Courses set Cost = 17.00, CourseName = 'Kabasa';
select * from Courses;

UPDATE Courses
set Cost = 20.00
WHERE CourseName = 'Kabasa' ;
 
select * from Courses;

-- Task 5: Create constraints
-- Create a new table called "DeliveryAddress" in the Little Lemon database with the following columns and constraints:
CREATE TABLE IF NOT EXISTS DeliveryAddress(
	ID INT PRIMARY KEY,
    Address varchar(255) NOT NULL,
    Type VARCHAR(100) NOT NULL DEFAULT "Private",
    CustomerID INT NOT NULL,
    FOREIGN KEY(CustomerID) references Customers(CustomerID) ON DELETE cascade ON UPDATE cascade
);
SHOW COLUMNS FROM DeliveryAddress;

-- Task 6: Alter table structure
-- Create a SQL statement that adds a new column called 'Ingredients' to the Courses table
ALTER TABLE Courses
ADD Ingredients varchar(255);

DESC Courses;

-- Task 7: Create a subquery
-- Create a SQL statement with a subquery that prints the full names of all customers who made bookings in the restaurant on the following date: 2021-11-11.

SELECT FullName
FROM Customers
WHERE CustomerID in (select CustomerID
					FROM Bookings
					WHERE BookingDate = '2021-11-11');

SELECT FullName
FROM Customers INNER JOIN Bookings
ON Customers.CustomerID = Bookings.CustomerID
where BookingDate = '2021-11-11';

SELECT FullName 
FROM Customers 
WHERE (SELECT CustomerID FROM Bookings WHERE Customers.CustomerID = Bookings.CustomerID and BookingDate = "2021-11-11");

-- Task 8: Create a virtual table
-- Create the "BookingsView" virtual table to print all bookings IDs, bookings dates and the number of guests for bookings made in the restaurant before 2021-11-13 and where number of guests is larger than 3.

create view BookingsView as 
select BookingID, BookingDate, NumberOfGuests
from Bookings
where BookingDate < '2021-11-13' and NumberOfGuests >3;
 select * from BookingsView;
 show columns from BookingsView;

-- Task 9: Create a stored procedure
-- Create a stored procedure called 'GetBookingsData'. The procedure must contain one date parameter called "InputDate". This parameter retrieves all data from the Bookings table based on the user input of the date.

CREATE PROCEDURE GetBookingsData(InputDate date)
select *
from Bookings
where BookingDate = InputDate;
CALL GetBookingsData('2021-11-13');

-- Task 10: Use the String function

-- Create a SQL SELECT query using appropriate MySQL string function to list "Booking Details" including booking ID, booking date and number of guests. The data must be listed in the same format as the following example:
SELECT CONCAT('ID: ',BookingID, ',',' Date: ', BookingDate, ',', ' NumberOfGuests: ', NumberOfGuests) AS "Booking Details"
FROM Bookings;
 


