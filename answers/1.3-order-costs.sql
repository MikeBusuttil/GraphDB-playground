SELECT OrderID, 
    format(sum(UnitPrice * Quantity * (1 - Discount)), 2) AS Subtotal
FROM `order details`
GROUP BY OrderID
ORDER BY OrderID
