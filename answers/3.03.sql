SELECT ProductName, UnitsInStock, ReorderLevel
FROM Products
WHERE UnitsInStock <= ReorderLevel
AND ReorderLevel > 0
ORDER BY ProductID
