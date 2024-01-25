CREATE DATABASE IF NOT EXISTS JewelryStore_db;
use jewelryStore_db;

CREATE TABLE item (
    ItemID INT,
    Name VARCHAR(150),
    Cost INT,
    PRIMARY KEY (ItemID)
);
INSERT INTO item VALUES(1,'Engagement ring',2500),(2,'Silver brooch',400),(3,'Earrings',350),(4,'Luxury watch',1250),(5,'Golden bracelet',800), (6,'Gemstone',1500);

CREATE TABLE mg_orders (
    OrderID INT,
    ItemID INT,
    Quantity INT,
    Cost INT,
    OrderDate DATE,
    DeliveryDate DATE,
    OrderStatus VARCHAR(50),
    PRIMARY KEY (OrderID),
    FOREIGN KEY(ItemID) REFERENCES item(ItemID) on delete cascade on update cascade
);
INSERT INTO mg_orders VALUES(1,1,50,122000,'2022-04-05','2022-05-25', 'Delivered'),(2,2,75,28000,'2022-03-08',NULL, 'In progress'), (3,3,80,25000,'2022-05-19','2022-06-08', 'Delivered'), (4,4,45,100000,'2022-01-10',NULL, 'In progress'),(5,5,70,56000,'2022-05-19',NULL, 'In progress'),(6,6,60,90000,'2022-06-10','2022-06-18', 'Delivered');

-- Task 1: Write a SQL SELECT query using appropriate MySQL string functions to list items, quantities and order status in the following format:

SELECT CONCAT(LCASE(item.Name),'-', Quantity,'-', UCASE(orderstatus)) as Task_1
From item inner join mg_orders
on item.ItemID = mg_orders.ItemID;

-- Task 2: Write a SQL SELECT query using an appropriate date function and a format string to find the name of the weekday on which M&G’s orders are to be delivered.

SELECT DATE_FORMAT(DeliveryDate,'%W')
FROM mg_orders;

SELECT DATE_FORMAT(DeliveryDate,'%W')
FROM mg_orders
where DeliveryDate is not null;

-- Task 3: Write a SQL SELECT query that calculates the cost of handling each order. This should be 5% of the total order cost. Use an appropriate math function to round that value to 2 decimal places.
SELECT * FROM item;
SELECT * FROM mg_orders;
SELECT OrderID, round(Cost*5/100) as HandlingCost
from mg_orders;

-- Task 4: Review the query that you wrote in the second task. Use an appropriate comparison function to filter out the records that do not have a NULL value in the delivery date column.

SELECT DATE_FORMAT(DeliveryDate,'%W')
FROM mg_orders
where DeliveryDate is not null;

SELECT DATE_FORMAT(DeliveryDate,'%W')
FROM mg_orders
where isnull(DeliveryDate)='NULL';

-- OPTIONAL EXCECISES-- 
CREATE TABLE clients 
(ClientID int NOT NULL, 
ClientName varchar(255) DEFAULT NULL, 
Address varchar(255) DEFAULT NULL, 
ContactNo varchar(10) DEFAULT NULL, 
PRIMARY KEY (ClientID));

INSERT INTO clients VALUES 
(1, 'Kishan Hughes','223 Golden Hills, North Austin, TX','387986345'), 
(2, 'Indira Moncada','119 Silver Street, Bouldin Creek, TX','334567243'), 
(3, 'Mosha Setsile','785 Bronze Lane, East Austin, TX','315642597'), 
(4, 'Laura Mills','908 Diamond Crescent, South Lamar, TX','300842509'), 
(5, 'Henrik Kreida','345, Golden Hills, North Austin, TX','358208983'), 
(6, 'Millicent Blou','812, Diamond Crescent, North Burnet, TX','347898755');

select * from Clients;

CREATE TABLE client_orders 
(OrderID INT NOT NULL, 
ClientID INT DEFAULT NULL, 
ItemID INT DEFAULT NULL, 
Cost INT DEFAULT NULL, 
PRIMARY KEY (OrderID));

INSERT INTO client_orders VALUES 
(1,1,1,2500), 
(2,2,2,400), 
(3,3,3,350), 
(4,4,4,1250), 
(5,5,5,800), 
(6,6,6,1500), 
(7,2,4,400), 
(8,3,4,1250), 
(9,4,2,400), 
(10,1,3,350); 

SELECT * FROM client_orders;

-- Task 1: Use the MySQL CEIL function to express the cost after the discount in the form of the smallest integer as follows:
SELECT 
    ClientID,
    OrderID,
    ceil(Cost - (Cost * 5 / 100)) AS afterDiscount
FROM
    client_orders
WHERE
    ItemID = 4;
-- Task 2: Format the afterDiscount column value from the earlier result for 5% discount in '#,###,###.##' format rounded to 2 decimal places using the FORMAT function.
SELECT 
    ClientID,
    OrderID,
    format((Cost - (Cost * 5 / 100)),2) AS afterDiscount
FROM
    client_orders
WHERE
    ItemID = 4;
-- Task 3: Find the expected delivery dates for their orders. The scheduled delivery date is 30 days after the order date. Use the ADDDATE function.

SELECT OrderDate, adddate(OrderDate, interval 30 DAY) as DeliveryDate
FROM mg_orders;

-- Task 4: Generate data required for a report with details of all orders that have not yet been delivered. The DeliveryDate column has a NULL value for orders not yet delivered. It would help if you showed a value of 'NOT DELIVERED' instead of showing NULL for orders that are not yet delivered. Use the COALESCE function to do this.

select OrderID, ItemID, Quantity, Cost, OrderDate, coalesce(DeliveryDate,'NOT DELIVERED'), OrderStatus
from mg_orders;

-- Task 5 solution: Generate data required for the report by retrieving a list of M&G orders that are yet to be delivered. These are the orders with a status of 'In Progress', using the NULLIF function. This is the query that gives the desired result, using the COALESCE function.

SELECT OrderID, nullif(OrderStatus,'In progress') as Status
from mg_orders;

-- 								1.NUMERIC FUNCTIONS
-- --Note Let's look at two meaningful and useful mathematical functions: CEIL and FLOOR.

-- The CEIL function returns the smallest integer value, which is not less than the passed value. For example, passing a value of 1.23 to the CEIL function returns a value of 2.
-- It returns NULL if the value passed is NULL. The syntax of the CEIL function is as follows: 
-- SYNTAX:- SELECT CEIL(VALUE);
-- The following code returns 16 as it is the smallest integer value that is greater than or equal to 15.50. 
SELECT CEIL(15.50); -- RETURNS -->16

-- The FLOOR function does the opposite of CEIL. It returns the largest integer value not greater than the passed value. It returns NULL if the passed value is NULL. 
-- Its syntax is the same as the CEIL function. It's just a matter of replacing the CEIL function with the FLOOR function.
-- SELECT FLOOR(VALUE);
-- Example: The following code returns 15 as it is the largest integer value that is less than or equal to 15.50.
SELECT FLOOR(15.50);

-- 								2.STRING FUNCTIONS
-- Now let's look at some more String functions like FORMAT, LENGTH and REPLACE. 

-- The FORMAT function formats the number passed into a format like '#,###,###.##', rounded to the specified number of decimal places. It returns the result as a string.

-- Here's the syntax: SELECT FORMAT(number_to_be_formatted, number_of_decimal_places);

-- Example: The following code returns 3,750.75  as it formats the number (3750.753, 2) as "#,###.##" and rounds it within two decimal places. 
SELECT FORMAT(3750.753, 2); -- RETURN -->'3,750.75'
SELECT FORMAT(NULL,2); -- RETURNS ---> NULL
-- NOTE;-If the number of decimal places is 0, the result has no decimal point or fractional part. If the number to be formatted or the number of decimal places is NULL, then the function returns NULL.

--							 -- 3.DATE FUNCTIONS
-- You’ve explored MySQL date functions such as CURRENT_DATE, CURRENT_TIME, DATE_FORMAT and DATEDIFF. Now let’s explore a few more essential date functions with some examples.

-- The ADDDATE function is used to perform arithmetic with dates. It comes in two forms.

-- ADDDATE(date, INTERVAL expr unit) / DATE_ADD() IS SIMILLAR

-- ADDDATE(date, days)

-- The first argument specifies the starting date or datetime value in the first form. The second argument is an expression that determines the interval value to be added to the starting date. 

-- It has three parts:

-- INTERVAL is a keyword

-- expr represents a quantity

-- and unit represents the unit for interpreting the quantity; such as HOUR, DAY, or WEEK

-- The syntax for the first form is as follows:
-- SELECT ADDDATE(date, INTERVAL expr unit);
-- In the second form, the first argument is the same and the second argument is the integer, or number of days, to be added to the given date in the first argument.

-- Example: the following code returns 2020-05-15 because it adds 5 days to the specified date. 
SELECT ADDDATE("2020-05-10", INTERVAL 5 DAY);
-- The syntax for the second form is as follows:
-- SELECT ADDDATE(date, days);
-- Example: The following code returns 2020-06-25 because it adds 10 days to the specified date.  
SELECT ADDDATE("2020-06-15", 10);

-- The QUARTER function is also a very versatile function that returns the quarter of the year for the given date. The return value is in the range 1 to 4, or NULL if date is NULL.
-- The syntax is as follows:SELECT QUARTER(date_value);
-- The DATE, MONTH, YEAR and DAY functions extract the date, month, year and 'day of the month' parts respectively, of a given date or date time expression.

-- Example: The following code returns a value of 3. The QUARTER() function returns the quarter of the year for the given date value.
 SELECT QUARTER("2020-09-15");

-- 										4.COMPARISON FUNCTIONS
-- You may know of a few comparison functions of MySQL like GREATEST, LEAST and ISNULL. 

-- COALESCE is another comparison function that takes several arguments and returns the first non-NULL argument. In case all arguments are NULL, the COALESCE function returns NULL. You can think of this function as a NULL checking function.

-- The syntax for this function is as follows:SELECT COALESCE (value1, value2);
-- This function is particularly useful when you replace a column value with a NULL value with some other value.

-- Example: The following code returns Coursera, because the COALESCE() function returns the first non-null value in a list.
SELECT COALESCE(NULL, 'Coursera', NULL, 'Database');

-- 								5. CONTROL FLOW FUNCTIONS
-- MySQL also has a function that lets you evaluate conditions and decide how the query should be executed accordingly. You should be familiar with the CASE function in MySQL and IFNULL, another function. It accepts two arguments and returns the first argument if it is not NULL. Otherwise, the IFNULL function returns the second argument. The two arguments can be literal values or expressions.

-- The syntax is as follows:SELECT IFNULL(evaluated_expression, alternative_value);
-- Example: The following code returns Coursera as the value because the evaluated expression is NULL.
SELECT IFNULL(NULL, "Coursera"); -- Otherwise, the IFNULL function returns the second argument IF IT IS NULL
SELECT IFNULL("UDEMY","COURSERA"); - -- returns the first argument if it is not NULL


-- there’s also the NULLIF function that takes in two values or expressions. If they're equal then it returns NULL. Otherwise, it returns the first value or expression.

-- This is an example of the syntax:SELECT NULLIF(expression1, expression2);
-- Example: The following NULLIF() function returns 10, as it compares the two expressions (10 and 15) and returns NULL if they are equal. Otherwise, the first expression is returned. 
SELECT NULLIF(10, 15); -- RETURNS ---> FIRST EXPRESSION IS 10
SELECT NULLIF(10, 10); -- RETURNS ---> NULL



