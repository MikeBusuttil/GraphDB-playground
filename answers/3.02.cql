MATCH (c:Customer)
RETURN c.city + ', ' + c.country AS city, COUNT(c) AS TotalCustomers
ORDER BY TotalCustomers DESC
