SELECT customers.CompanyName
FROM customers
LEFT JOIN orders
ON orders.CustomerID = customers.CustomerID
WHERE orders.CustomerID IS NULL
