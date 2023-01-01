# Database Querying Exercises

The following exercises are meant to be tacked by both SQL and CQL to illustrate how each paradigm compares.

## 1. Featured

1. Visualize the org chart

2. Lets see an order

3. How much does each order cost?

4. Sales by year?

5. Which Employees had the Highest Cross-Selling Count of 'Chocolade' and Another Product?

6. How much revenue did each employee bring in?

7. How Many Orders were Made under each employee?

## 2. Introductory

1. Which shippers do we have?

2. What is the description for each category?

3. Get FirstName,LastName,HireDate of the Sales Representatives from USA.

4. Find orders placed by employee # 4.

5. Show supplier contacts of suppliers who are not 'Marketing Manager'.

6. List products with "queso" in the name.

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

## 3. Intermediate

1. categories, and the total products in each category

2. Total customers per country/city

3. Find products that are below inventory thresholds

4. Find products that need reordering

5. Customer list by region and get nulls at the bottom

6. High freight charges for top 3 shipping countries in 1996

7. customers with no orders

## 4. Advanced Problems

1. Customers with orders over $10k in 1997

2. orders- accidental double-entry

3. ordersShipped Late

4. Which salespeople have the most orders arriving late?

5. For each employee compare Late ordersvs. total orders

6. Customer grouping

7. Customer grouping with percentage

8. Countries with suppliers or customers

9. First order in each country

10. customers with multiple orders in 5 day period
