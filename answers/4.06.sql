WITH orders.996 AS (
  SELECT
    customers.CustomerID,
    customers.CompanyName,
    TotalOrderAmount = SUM(Quantity * UnitPrice)
  FROM
    customers
    JOIN orders ON orders.CustomerID = customers.CustomerID
    JOIN `order details` ON orders.OrderID = `order details`.OrderID
  WHERE
    OrderDate >= '1996-01-01'
    and OrderDate < '1997-01-01'
  GROUP BY
    customers.CustomerID,
    customers.CompanyName
)
SELECT
  CustomerID,
  CompanyName,
  TotalOrderAmount,
  CustomerGroup = CASE
    WHEN TotalOrderAmount BETWEEN 0
    AND 1000 THEN 'Low'
    WHEN TotalOrderAmount BETWEEN 1001
    AND 5000 THEN 'Medium'
    WHEN TotalOrderAmount BETWEEN 5001
    AND 10000 THEN 'High'
    WHEN TotalOrderAmount > 10000 THEN 'Very High'
  END
FROM
  orders.996
ORDER BY
  CustomerGroup
