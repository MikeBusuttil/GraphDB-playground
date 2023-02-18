SELECT
  CONCAT(TitleOfCourtesy, ' ', FirstName, ' ', LastName) AS name,
  FORMAT(SUM(Quantity * UnitPrice * (1-Discount)), 2) AS revenue
FROM (
  SELECT Orders.EmployeeID, Details.UnitPrice, Details.Discount, Details.Quantity
  FROM northwind.`order details` AS Details
  LEFT JOIN northwind.orders AS Orders
  ON Details.OrderID = Orders.OrderID
) AS Orderz
LEFT JOIN northwind.employees AS Employees
ON Orderz.EmployeeID = Employees.EmployeeID
GROUP BY NAME
ORDER BY SUM(Quantity * UnitPrice * (1-Discount)) DESC
