CREATE DATABASE IF NOT EXISTS littlelemon_db;
USE littlelemon_db;
CREATE TABLE MenuItems ( 
  ItemID INT, 
  Name VARCHAR(200), 
  Type VARCHAR(100), 
  Price INT, 
  PRIMARY KEY (ItemID) 
); 

INSERT INTO MenuItems VALUES(1,'Olives','Starters', 5), 
(2,'Flatbread','Starters', 5),
(3, 'Minestrone', 'Starters', 8), 
(4, 'Tomato bread','Starters', 8), 
(5, 'Falafel', 'Starters', 7), 
(6, 'Hummus', 'Starters', 5), 
(7, 'Greek salad', 'Main Courses', 15), 
(8, 'Bean soup', 'Main Courses', 12), 
(9, 'Pizza', 'Main Courses', 15), 
(10,'Greek yoghurt','Desserts', 7), 
(11, 'Ice cream', 'Desserts', 6),
(12, 'Cheesecake', 'Desserts', 4), 
(13, 'Athens White wine', 'Drinks', 25), 
(14, 'Corfu Red Wine', 'Drinks', 30), 
(15, 'Turkish Coffee', 'Drinks', 10), 
(16, 'Turkish Coffee', 'Drinks', 10), 
(17, 'Kabasa', 'Main Courses', 17);

CREATE TABLE Menus ( 
  MenuID INT, 
  ItemID INT, 
  Cuisine VARCHAR(100), 
  PRIMARY KEY (MenuID,ItemID)
); 

INSERT INTO Menus VALUES(1, 1, 'Greek'), (1, 7, 'Greek'), (1, 10, 'Greek'), (1, 13, 'Greek'), (2, 3, 'Italian'), (2, 9, 'Italian'), (2, 12, 'Italian'), (2, 15, 'Italian'), (3, 5, 'Turkish'), (3, 17, 'Turkish'), (3, 11, 'Turkish'), (3, 16, 'Turkish');

CREATE TABLE Bookings ( 
  BookingID INT, 
  TableNo INT, 
  GuestFirstName VARCHAR(100), 
  GuestLastName VARCHAR(100), 
  BookingSlot TIME, 
  EmployeeID INT, 
  PRIMARY KEY (BookingID) 
);  

INSERT INTO Bookings VALUES(1,12,'Anna','Iversen','19:00:00',1),  
(2, 12, 'Joakim', 'Iversen', '19:00:00', 1), (3, 19, 'Vanessa', 'McCarthy', '15:00:00', 3), 
(4, 15, 'Marcos', 'Romero', '17:30:00', 4), (5, 5, 'Hiroki', 'Yamane', '18:30:00', 2),
(6, 8, 'Diana', 'Pinto', '20:00:00', 5);

CREATE TABLE TableOrders ( 
  OrderID INT, 
  TableNo INT, 
  MenuID INT, 
  BookingID INT, 
  BillAmount INT, 
  Quantity INT, 
  PRIMARY KEY (OrderID,TableNo) 
);  

INSERT INTO TableOrders VALUES(1, 12, 1, 1, 2, 86), (2, 19, 2, 2, 1, 37), (3, 15, 2, 3, 1, 37), (4, 5, 3, 4, 1, 40), (5, 8, 1, 5, 1, 43);

#Task 1: Write a SQL SELECT query to find all bookings that are due after the booking of the guest ‘Vanessa McCarthy’.
select * 
from Bookings
where BookingSlot > all (select BookingSlot
from Bookings
where concat(GuestFirstName," ",GuestLastName)='Vanessa McCarthy');

#Task 2: Write a SQL SELECT query to find the menu items that are more expensive than all the 'Starters' and 'Desserts' menu item types.
select *
from menuitems
where Price > all (select Price
from menuitems
where Type in ('Starters','Desserts')
);

#Task 3: Write a SQL SELECT query to find the menu items that costs the same as the starter menu items that are Italian cuisine.

select * 
from menuitems
where Price =   (select Price
from menus,menuitems
where menus.ItemID = menuitems.ItemID and menuitems.Type = 'Starters' and Cuisine = 'Italian');

SELECT * FROM MenuItems WHERE Price = (SELECT Price 
FROM Menus, MenuItems WHERE Menus.ItemID = MenuItems.ItemID AND 
MenuItems.Type = 'Starters' AND Cuisine = 'Italian'); 

#Task 4: Write a SQL SELECT query to find the menu items that were not ordered by the guests who placed bookings.
select *
from menuitems
where ItemID not in (select ItemID
FROM Menus,TableOrders
where Menus.MenuID = TableOrders.MenuID);

select *
from menuitems
where not exists (select *
FROM Menus,TableOrders
where Menus.MenuID = TableOrders.MenuID AND Menus.ItemID = MenuItems.ItemID);

#Reading Exercise:- Practicing Subqueries
#Task 1: Find the minimum and the maximum average prices at which the customers can purchase food and drinks.
use littlelemon_db;
select * from menuitems;
select * from menus;
select Type, Min(AVGprice) , max(AVGprice)
from (select Type, avg(price) AVGprice
from menuitems 
group by Type) as ItemsPrice_filtered;

#Task 2: Insert data of menu items with a minimum price based on the 'Type' into the LowCostMenuItems table.
CREATE TABLE IF NOT EXISTS LowCostMenuItems like MenuItems;
select * from LowCostMenuItems;
Insert into LowCostMenuItems (select *
from menuitems
where price in (select min(price)
from menuitems
group by type));
select * from LowCostMenuItems;
show columns from LowCostMenuItems;
-- #Task 3: Delete all the low-cost menu items whose price is more than the minimum price of menu items that have a price between $5 and $10.
-- Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.  To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.

-- This error occurs because you are using safe update mode, which prevents you from updating or deleting records without specifying a key column in the WHERE clause12. This is a safety feature to avoid accidental changes to large amounts of data3

---- You can disable safe update mode by running SET SQL_SAFE_UPDATES = 0; before your query, and then enable it again by running SET SQL_SAFE_UPDATES = 1; after your query 

SET SQL_SAFE_UPDATES = 0;

DELETE FROM LowCostMenuItems 
WHERE
    Price > ALL (SELECT 
        MIN(Price) AS p
    FROM
        MenuItems
    GROUP BY Type
    HAVING p BETWEEN 5 AND 10); -- PRICE = 12 HAS BEEN DELETED
    
SELECT * 
FROM LowCostMenuItems;

SET SQL_SAFE_UPDATES = 1;



