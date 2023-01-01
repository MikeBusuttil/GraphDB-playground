SELECT Country, City, COUNT(*) AS TotalCustomers
FROM customers
GROUP BY Country, City
ORDER BY TotalCustomers DESC
