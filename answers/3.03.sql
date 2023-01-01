SELECT ProductID, ProductName, UnitsInStock, ReorderLevel
FROM products
WHERE UnitsInStock <= ReorderLevel
AND ReorderLevel > 0
ORDER BY ProductID
