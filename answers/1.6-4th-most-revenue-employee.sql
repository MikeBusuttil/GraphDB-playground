SELECT Employees.*
FROM (
  SELECT Orders.EmployeeID, Details.UnitPrice, Details.Discount, Details.Quantity
  FROM northwind.`order details` AS Details
  LEFT JOIN northwind.orders AS Orders
  ON Details.OrderID = Orders.OrderID
) AS O
LEFT JOIN northwind.employees AS Employees
ON O.EmployeeID = Employees.EmployeeID
GROUP BY EmployeeID
ORDER BY SUM(Quantity * UnitPrice * (1 - Discount)) DESC
LIMIT 3,1
