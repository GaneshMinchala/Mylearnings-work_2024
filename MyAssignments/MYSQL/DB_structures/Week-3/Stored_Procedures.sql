USE LUCKY_SHRUB;
SELECT * FROM Orders;
-- Task 1: Write a SQL statement that creates a stored procedure called 'GetOrdersData' which retrieves all data from the Orders table.
create procedure GetOrdersData()
select * 
from Orders;
call GetOrdersData();

-- Task 2: Write a SQL statement that creates a stored procedure called “GetListOfOrdersInRange”. The procedure must contain two parameters that determine the range of retrieved data based on the user input of two cost values “MinimumValue” and “MaximumValue”.
Create procedure GetListOfOrdersInRange(MinimumValue INT , MaximumValue int)
Select *
from Orders
where Cost Between MinimumValue and MaximumValue;
call GetListOfOrdersInRange(150,600);








