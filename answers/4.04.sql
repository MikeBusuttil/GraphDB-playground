SELECT
  employees.EmployeeID,
  LastName,
  COUNT(*) AS TotalLateOrders
FROM
  orders
  JOIN employees ON employees.EmployeeID = orders.EmployeeID
WHERE
  RequiredDate <= ShippedDate
GROUP BY
  employees.EmployeeID,
  employees.LastName
ORDER BY
  TotalLateOrders DESC
