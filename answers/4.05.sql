WITH LateOrders AS (
  SELECT
    EmployeeID,
    COUNT(*) AS TotalOrders
  FROM
    orders
  WHERE
    RequiredDate <= ShippedDate
  GROUP BY
    EmployeeID
),
AllOrders AS (
  SELECT
    EmployeeID,
    COUNT(*) AS TotalOrders
  FROM
    orders
  GROUP BY
    EmployeeID
)
SELECT
  employees.EmployeeID,
  LastName,
  AllOrders.TotalOrders AS AllOrders,
  LateOrders.TotalOrders AS LateOrders,
  LateOrders.TotalOrders * 100 / AllOrders.TotalOrders AS percentLate
FROM
  employees
  JOIN AllOrders ON AllOrders.EmployeeID = employees.EmployeeID
  JOIN LateOrders ON LateOrders.EmployeeID = employees.EmployeeID
ORDER BY
  percentLate DESC
