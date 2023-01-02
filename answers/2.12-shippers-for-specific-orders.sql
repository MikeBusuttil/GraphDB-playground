SELECT OrderID, OrderDate, CompanyName AS Shipper
FROM Orders
JOIN Shippers
ON Shippers.ShipperID = Orders.ShipVia
WHERE OrderDate BETWEEN '1997-05-01' AND '1997-05-14'
ORDER BY OrderID
