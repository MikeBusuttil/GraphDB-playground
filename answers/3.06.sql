SELECT ShipCountry, AVG(freight) AS AverageFreight
FROM orders
WHERE YEAR(OrderDate) = 1996
GROUP BY ShipCountry
ORDER BY AverageFreight DESC
LIMIT 3
