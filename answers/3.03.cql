MATCH (p:Product)
WHERE p.unitsInStock <= p.reorderLevel
AND p.reorderLevel > 0
RETURN p.productName, p.unitsInStock, p.reorderLevel
ORDER BY p.productID
