1. Visualize the org chart

2. Lets see an order

3. How much does each order cost?

4. Sales by year?

5. Which Employees had the Highest Cross-Selling Count of 'Chocolade' and Another Product?

6. How much revenue did each employee bring in?

7. How Many Orders were Made under each employee?

/*
	From the book 57 beginning, intermediate, and advanced challenges for you to solve using a "learn-by-doing" approach
	By Sylvia Moestl Vasilik
*/

--Introductory Problems

USE Northwind

--1. Which shippers do we have?
SELECT *
FROM shippers

--2. Select certain fields from categories
SELECT CategoryName, Description
FROM categories


--3. Get FirstName,LastName,HireDate of the Sales Representatives from USA
SELECT FirstName, LastName, HireDate
FROM employees
WHERE Title = 'Sales Representative' AND Country = 'USA'

--4. Find ordersplaced by specific EmployeeID
SELECT OrderID, OrderDate
FROM orders
WHERE EmployeeID = 5

--5. suppliers and ContactTitles of suppliers who are not 'Marketing Manager'
SELECT SupplierID, ContactName, ContactTitle
FROM suppliers
WHERE ContactTitle <> 'Marketing Manager'

--6. products with "queso" in ProductName
SELECT ProductID, ProductName
FROM products
WHERE ProductName LIKE '%queso%'

--7. Find ordersshipping to France or Belgium
SELECT OrderID, CustomerID, ShipCountry
FROM orders
WHERE ShipCountry = 'France' OR ShipCountry = 'Belgium'

--8. ordersshipping to any country in Latin America
SELECT OrderID, CustomerID, ShipCountry
FROM orders
WHERE ShipCountry  IN ('Brazil', 'Mexico', 'Argentina', 'Venezuela')

--9. employees, in order of age
SELECT FirstName, LastName, Title, BirthDate, TIMESTAMPDIFF(YEAR, BirthDate, CURDATE()) AS Age
FROM employees
ORDER BY Birthdate

--10. employees full name
SELECT CONCAT(TitleOfCourtesy, ' ', FirstName, ' ', LastName) AS name
FROM employees

--15. Count customers per each contact titles
SELECT ContactTitle,COUNT(*) AS TotalContactTitle
FROM customers
GROUP BY ContactTitle
Order by COUNT(*) DESC

--16. products and associated supplier names
SELECT ProductID,ProductName,CompanyName AS Supplier
FROM products P
JOIN suppliers S
ON P.SupplierID = S.SupplierID
ORDER BY CompanyName

--17. orders and the Shipper that was used for OrderDate BETWEEN '1996-05-01' AND '1996-05-12'
SELECT OrderID, CONVERT(DATE, OrderDate) AS OrderDate,Shipper = CompanyName
FROM orders
JOIN shippers
ON shippers.ShipperID = orders.ShipVia
WHERE OrderDate BETWEEN '1996-05-01' AND '1996-05-12'
ORDER BY OrderID

--Intermediate Problems

--1. categories, and the total products in each category

SELECT CategoryName, COUNT(*) AS TotalProducts
FROM products
JOIN categories
ON products.CategoryID = categories.CategoryID
GROUP BY CategoryName
ORDER BY TotalProducts DESC

--2. Total customers per country/city
SELECT Country, City, COUNT(*) AS TotalCustomers
FROM customers
GROUP BY Country, City
ORDER BY TotalCustomers DESC

--3. Find products that are below inventory thresholds
SELECT ProductID, ProductName, UnitsInStock, ReorderLevel
FROM products
WHERE UnitsInStock <= ReorderLevel
AND ReorderLevel > 0
ORDER BY ProductID

--3. Find products that need reordering
SELECT ProductID, ProductName, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued
FROM products
WHERE
    UnitsInStock + UnitsOnOrder <= ReorderLevel AND
    Discontinued = 0 AND
    ReorderLevel > 0
ORDER BY ProductID

--4. Customer list by region and get nulls at the bottom
SELECT CustomerID,CompanyName,Region
FROM customers
ORDER BY 
CASE
WHEN Region IS NULL then 1
ELSE 0
END
,Region,CustomerID

--5. High freight charges for top 3 shipping countries in 1996
SELECT ShipCountry, AVG(freight) AS AverageFreight
FROM orders
WHERE YEAR(OrderDate) = 1996
GROUP BY ShipCountry
ORDER BY AverageFreight DESC
LIMIT 3

--10. customers with no orders
SELECT customers.CompanyName
FROM customers
LEFT JOIN orders
ON orders.CustomerID = customers.CustomerID
WHERE orders.CustomerID IS NULL

--Advanced Problems
--1. Customers with orders over $10k in 1997
SELECT
customers.CustomerID
,customers.CompanyName
, orders.OrderID
, SUM(Quantity * UnitPrice * (1-Discount)) AS TotalOrderAmount
FROM customers
JOIN orders
ON orders.CustomerID = customers.CustomerID
JOIN `order details`
ON orders.OrderID = `order details`.OrderID
WHERE
OrderDate >= '1996-01-01'
AND OrderDate < '1997-01-01'
GROUP BY
customers.CustomerID
,customers.CompanyName
, orders.Orderid
HAVING SUM(Quantity * UnitPrice) > 10000
ORDER BY TotalOrderAmount DESC

--7. orders- accidental double-entry
SELECT
OrderID
FROM `order details`
WHERE Quantity >= 60
GROUP BY
OrderID
,Quantity
HAVING COUNT(*) > 1

--9. ordersShipped Late

SELECT
OrderID
,OrderDate
,RequiredDate
,ShippedDate
FROM orders
WHERE
RequiredDate <= ShippedDate

--10. Which salespeople have the most orders arriving late?

SELECT
employees.EmployeeID
,LastName
,COUNT(*) AS TotalLateOrders
FROM orders
JOIN employees
ON employees.EmployeeID = orders.EmployeeID
WHERE
RequiredDate <= ShippedDate
GROUP BY employees.EmployeeID
,employees.LastName
ORDER BY TotalLateOrders DESC

--11. For each employee compare Late ordersvs. total orders

WITH LateOrders AS 
(
SELECT EmployeeID, COUNT(*) AS TotalOrders
FROM orders
WHERE RequiredDate <= ShippedDate
GROUP BY EmployeeID
),
AllOrders AS
(
SELECT EmployeeID, COUNT(*) AS TotalOrders
FROM orders
GROUP BY EmployeeID
)
SELECT employees.EmployeeID, LastName
, AllOrders.TotalOrders AS AllOrders
, LateOrders.TotalOrders AS LateOrders,
LateOrders.TotalOrders * 100 / AllOrders.TotalOrders AS percentLate
FROM employees
JOIN AllOrders
ON AllOrders.EmployeeID = employees.EmployeeID
JOIN LateOrders
ON LateOrders.EmployeeID = employees.EmployeeID
ORDER BY percentLate DESC

--13. Customer grouping
WITH orders.996 AS
(
SELECT customers.CustomerID,customers.CompanyName
,TotalOrderAmount = SUM(Quantity * UnitPrice)
FROM customers
JOIN orders
ON orders.CustomerID = customers.CustomerID
JOIN `order details`
ON orders.OrderID = `order details`.OrderID
WHERE OrderDate >= '1996-01-01'and OrderDate < '1997-01-01'
GROUP BY
customers.CustomerID,customers.CompanyName
)
SELECT CustomerID,CompanyName
,TotalOrderAmount,
CustomerGroup =
CASE
WHEN TotalOrderAmount BETWEEN 0 AND 1000 THEN 'Low'
WHEN TotalOrderAmount BETWEEN 1001 AND 5000 THEN 'Medium'
WHEN TotalOrderAmount BETWEEN 5001 AND 10000 THEN 'High'
WHEN TotalOrderAmount > 10000 THEN 'Very High'
END
FROM orders.996
ORDER BY CustomerGroup

--14. Customer grouping with percentage
WITH orders.996 AS
(
SELECT customers.CustomerID,customers.CompanyName
,TotalOrderAmount = SUM(Quantity * UnitPrice)
FROM customers
JOIN orders
ON orders.CustomerID = customers.CustomerID
JOIN `order details`
ON orders.OrderID = `order details`.OrderID
WHERE OrderDate >= '1996-01-01'and OrderDate < '1997-01-01'
GROUP BY
customers.CustomerID,customers.CompanyName
)
,CustomerGrouping AS
(
SELECT CustomerID,CompanyName
,TotalOrderAmount,
CustomerGroup =
CASE
WHEN TotalOrderAmount BETWEEN 0 AND 1000 THEN 'Low'
WHEN TotalOrderAmount BETWEEN 1001 AND 5000 THEN 'Medium'
WHEN TotalOrderAmount BETWEEN 5001 AND 10000 THEN 'High'
WHEN TotalOrderAmount > 10000 THEN 'Very High'
END
FROM orders.996
)
SELECT CustomerGroup, TotalInGroup = COUNT(*), 
PercentageInGroup = COUNT(*) * 100/ (SELECT COUNT(*) FROM CustomerGrouping)
FROM CustomerGrouping
GROUP BY CustomerGroup
ORDER BY TotalInGroup DESC

--15. Countries with suppliers or customers
SELECT Country FROM customers
UNION
SELECT Country FROM suppliers
ORDER BY Country

--18. First order in each country
WITH yCountry AS
(
	SELECT
		ShipCountry, CustomerID, OrderID, OrderDate AS OrderDate,
        ROW_NUMBER() OVER (PARTITION BY ShipCountry ORDER BY ShipCountry, OrderDate) AS RowNumberPerCountry
	FROM orders
)
SELECT ShipCountry, CustomerID, OrderID, OrderDate
FROM yCountry
WHERE RowNumberPerCountry = 1
ORDER BY ShipCountry

--19. customers with multiple orders in 5 day period
SELECT 
InitialOrder.CustomerID
,InitialOrder.OrderID AS InitialOrderID
, InitialOrder.OrderDate AS InitialOrderDate
,NextOrder.OrderID AS NextOrderID
,NextOrder.OrderDate AS NextOrderDate
, DATEDIFF(NextOrder.OrderDate, InitialOrder.OrderDate) AS DaysBetween
FROM orders AS InitialOrder
JOIN orders AS NextOrder
ON InitialOrder.CustomerID = NextOrder.CustomerID
WHERE
InitialOrder.OrderID < NextOrder.OrderID
AND DATEDIFF(NextOrder.OrderDate, InitialOrder.OrderDate) <= 5
ORDER BY
InitialOrder.CustomerID
,InitialOrder.OrderID
