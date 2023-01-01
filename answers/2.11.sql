SELECT ContactTitle,COUNT(*) AS TotalContactTitle
FROM customers
GROUP BY ContactTitle
Order by COUNT(*) DESC
