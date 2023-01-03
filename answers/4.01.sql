SELECT
  Customers.CompanyName,
  SUM(Quantity * UnitPrice * (1 - Discount)) AS TotalOrderAmount
FROM
  Customers
  JOIN Orders ON Orders.CustomerID = Customers.CustomerID
  JOIN `Order Details` ON Orders.OrderID = `Order Details`.OrderID
WHERE
  OrderDate >= '1997-01-01'
  AND OrderDate < '1998-01-01'
GROUP BY
  Customers.CustomerID,
  Customers.CompanyName,
  Orders.Orderid
HAVING
  TotalOrderAmount > 10000
ORDER BY
  TotalOrderAmount DESC
