SELECT OrderID, OrderDate, CompanyName AS Shipper
FROM orders
JOIN shippers
ON shippers.ShipperID = orders.ShipVia
WHERE OrderDate BETWEEN '1996-05-01' AND '1996-05-14'
ORDER BY OrderID
