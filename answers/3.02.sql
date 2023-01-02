SELECT CONCAT(City, ', ', Country) AS city, COUNT(*) AS TotalCustomers
FROM Customers
GROUP BY Country, City
ORDER BY TotalCustomers DESC
