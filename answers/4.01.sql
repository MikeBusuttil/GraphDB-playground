SELECT
  customers.CustomerID,
  customers.CompanyName,
  orders.OrderID,
  SUM(Quantity * UnitPrice * (1 - Discount)) AS TotalOrderAmount
FROM
  customers
  JOIN orders ON orders.CustomerID = customers.CustomerID
  JOIN `order details` ON orders.OrderID = `order details`.OrderID
WHERE
  OrderDate >= '1996-01-01'
  AND OrderDate < '1997-01-01'
GROUP BY
  customers.CustomerID,
  customers.CompanyName,
  orders.Orderid
HAVING
  SUM(Quantity * UnitPrice) > 10000
ORDER BY
  TotalOrderAmount DESC
