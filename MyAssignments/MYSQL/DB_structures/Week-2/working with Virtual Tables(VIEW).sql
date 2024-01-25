USE Lucky_Shrub;
select * from Orders;
-- ---- Task 1: Write a SQL statement to create the OrdersView Virtual table based on the Orders table. The table must include the following columns: Order ID, Quantity and Cost.
CREATE VIEW OrdersView AS 
SELECT OrderID, Quantity, Cost
FROM Orders;
select * from OrdersView;

-- -- Task 2: Write a SQL statement that utilizes the ‘OrdersView’ virtual table to Update the base Orders table. In the UPDATE TABLE statement, change the cost to 200 where the order id equals 2. Once you have executed the query, select all data from the OrdersView table.
  UPDATE OrdersView
  set Cost = 200
  where OrderID = 2;
  select * from OrdersView;
  
  -- Task 3: Write a SQL statement that changes the name of the ‘OrdersView’ virtual table to ClientsOrdersView.
  RENAME TABLE OrdersView to ClientsOrdersView;
  SELECT * FROM ClientsOrdersView;
  -- Task 4: Write a SQL statement to delete the Orders virtual table.
  DROP VIEW ClientsOrdersView;
  
  