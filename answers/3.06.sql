SELECT ShipCountry, AVG(freight) AS AverageFreight
FROM Orders
WHERE YEAR(OrderDate) = 1996
GROUP BY ShipCountry
ORDER BY AverageFreight DESC
LIMIT 3
