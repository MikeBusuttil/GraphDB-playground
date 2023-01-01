SELECT ProductID,ProductName,CompanyName AS Supplier
FROM products P
JOIN suppliers S
ON P.SupplierID = S.SupplierID
ORDER BY CompanyName
