CREATE DATABASE Howse;

USE Howse;

--Queries to have a look to the dataset
SELECT * FROM Howse_Sales;
SELECT * FROM Howse_Costs;
SELECT COUNT(Sale_ID) FROM Howse_Sales;
SELECT COUNT(Order_ID) FROM Howse_Costs;

--Joining tables
--Sales AND Products AND Supplier AND Stores
SELECT * FROM Howse_Sales 
FULL JOIN Howse_Products
ON Howse_Sales.Product_ID = Howse_Products.Product_ID
FULL JOIN Howse_Suppliers
ON Howse_Products.Supplier_ID = Howse_Suppliers.Supplier_ID
FULL JOIN Howse_Stores
ON Howse_Sales.Store_ID = Howse_Stores.Store_ID
ORDER BY Sale_ID;

--3 
-- SHOW PRODUCT_ID, DESCRIPTION, UNIT PRICE, SUPPLIERS NAME, SUPPLIER ID
SELECT Howse_Products.Product_ID, Howse_Products.Description, Howse_Products.Unit_Price, Howse_Suppliers.Name, Howse_Suppliers.Supplier_ID FROM Howse_Products
FULL JOIN Howse_Suppliers
ON Howse_Products.Supplier_ID = Howse_Suppliers.Supplier_ID
ORDER BY Howse_Suppliers.Supplier_ID;

--HOW MANY PRODUCTS PER SUPPLIER
SELECT COUNT(Supplier_ID) AS ProductsQty, Supplier_ID FROM
(
SELECT Howse_Products.Product_ID, Howse_Products.Unit_Price, Howse_Suppliers.Name, Howse_Suppliers.Supplier_ID FROM Howse_Products
FULL JOIN Howse_Suppliers
ON Howse_Products.Supplier_ID = Howse_Suppliers.Supplier_ID 
) AS Q1
GROUP BY Supplier_ID
ORDER BY Supplier_ID

--HOW MANY PRODUCTS AND AVERAGE OF COSTS PER SUPPLIER
SELECT COUNT(Supplier_ID) AS ProductsQty, AVG(Unit_Price) AS AVG_UnitPrice, Supplier_ID FROM
(
SELECT Howse_Products.Product_ID, Howse_Products.Unit_Price, Howse_Suppliers.Name, Howse_Suppliers.Supplier_ID FROM Howse_Products
FULL JOIN Howse_Suppliers
ON Howse_Products.Supplier_ID = Howse_Suppliers.Supplier_ID 
) AS Q2
GROUP BY Supplier_ID;

--JOIN SALE ID AND DISCOUNTS TABLES
--WHAT WAS THE BIGGEST DISCOUNT ON A DAY?
--ORDER BY DISCOUNT
--NO DISPLAY RECORDS WITH ZERO DISCOUNT
--FECHA IS BIGGER THAN 2023-01-01
SELECT SUM(Amount) - SUM(Sales_Amount) AS TotalDiscount, Fecha FROM
(
SELECT Howse_Sales.Sale_ID, Howse_Sales.Amount, Howse_Sales.Total_Discount, Howse_Sales.Sales_Amount, Howse_Discounts.Fecha, Howse_Discounts.Discount FROM Howse_Sales
LEFT JOIN Howse_Discounts
ON Howse_Sales.Date = Howse_Discounts.Fecha 
) AS Q3
WHERE Fecha >= '2023-01-01'
GROUP BY Fecha
HAVING SUM(Amount) - SUM(Sales_Amount) != 0
ORDER BY TotalDiscount DESC

--HOW MANY PRODUCTS WERE SOLD FROM OUR A, B. AND C SUPPLIERS?
SELECT SUM(Item_Quantity) AS ItemQuantity, Category FROM
(
SELECT Howse_Sales.Sale_ID, Howse_Sales.Item_Quantity, Howse_Sales.Sales_Amount, Howse_Products.Product_ID, Howse_Suppliers.Supplier_ID, Howse_Suppliers.Category FROM Howse_Sales
LEFT JOIN Howse_Products
ON Howse_Sales.Product_ID = Howse_Products.Product_ID
LEFT JOIN Howse_Suppliers
ON Howse_Products.Supplier_ID = Howse_Suppliers.Supplier_ID
) AS Q4
GROUP BY Category
ORDER BY Category

--WHAT PRODUCTS WERE SOLD AND HOW MANY, BUT DISPLAYING CATEGORY OF SUPPLIER. ORDER BY ITEM QUANTITY
SELECT SUM(Item_Quantity) AS ItemQuantity, Product_ID, Category FROM
(
SELECT Howse_Sales.Sale_ID, Howse_Sales.Item_Quantity, Howse_Sales.Sales_Amount, Howse_Products.Product_ID, Howse_Suppliers.Supplier_ID, Howse_Suppliers.Category FROM Howse_Sales
LEFT JOIN Howse_Products
ON Howse_Sales.Product_ID = Howse_Products.Product_ID
LEFT JOIN Howse_Suppliers
ON Howse_Products.Supplier_ID = Howse_Suppliers.Supplier_ID
) AS Q4
GROUP BY Product_ID, Category
ORDER BY ItemQuantity

--SAME THAT BEFORE, BUT USING AVG
SELECT AVG(Item_Quantity) AS ItemQuantity, Product_ID, Category FROM
(
SELECT Howse_Sales.Sale_ID, Howse_Sales.Item_Quantity, Howse_Sales.Sales_Amount, Howse_Products.Product_ID, Howse_Suppliers.Supplier_ID, Howse_Suppliers.Category FROM Howse_Sales
LEFT JOIN Howse_Products
ON Howse_Sales.Product_ID = Howse_Products.Product_ID
LEFT JOIN Howse_Suppliers
ON Howse_Products.Supplier_ID = Howse_Suppliers.Supplier_ID
) AS Q4
GROUP BY Product_ID, Category
ORDER BY ItemQuantity

--JUST FOR FUN
--YOU CAN DOWNLOAD THE FILES I´VE CREATED AND PRACTICE WHATEVER YOU WANT 
--fluci0