-- This is incorrect!!

-- It only captures the orders under a manager and their direct employees
-- It does not capture the orders of employees of the manager's employees
-- The correct answer should capture infinite levels of recursion
-- Bonus points for handling the edge case of a circular management structure

SELECT name, employeez.revenue + managers.revenue as revenue FROM
(
  SELECT
    CONCAT(TitleOfCourtesy, ' ', FirstName, ' ', LastName) AS name,
    SUM(Quantity * UnitPrice * (1 - Discount)) AS revenue
  FROM
    (
      SELECT
        Orders.EmployeeID,
        Details.UnitPrice,
        Details.Discount,
        Details.Quantity
      FROM
        northwind.`order details` AS Details
        LEFT JOIN northwind.orders AS Orders ON Details.OrderID = Orders.OrderID
    ) AS O
    LEFT JOIN northwind.employees AS Employees ON O.EmployeeID = Employees.EmployeeID
  GROUP BY
    name
  ORDER BY
    SUM(Quantity * UnitPrice * (1 - Discount)) DESC
) AS employeez
LEFT JOIN 
 (
  SELECT
    SUM(Quantity * UnitPrice * (1 - Discount)) AS revenue,
    (
      SELECT
        CONCAT(TitleOfCourtesy, ' ', FirstName, ' ', LastName)
      FROM
        employees
      WHERE
        EmployeeID = Employees.ReportsTo
    ) AS reportsTo
  FROM
    (
      SELECT
        Orders.EmployeeID,
        Details.UnitPrice,
        Details.Discount,
        Details.Quantity
      FROM
        northwind.`order details` AS Details
        LEFT JOIN northwind.orders AS Orders ON Details.OrderID = Orders.OrderID
    ) AS O
    LEFT JOIN northwind.employees AS Employees ON O.EmployeeID = Employees.EmployeeID
  GROUP BY
    reportsTo
  ORDER BY
    SUM(Quantity * UnitPrice * (1 - Discount)) DESC
) AS managers
ON employeez.name = managers.reportsTo