SELECT CategoryName, COUNT(*) AS TotalProducts
FROM products
JOIN categories
ON products.CategoryID = categories.CategoryID
GROUP BY CategoryName
ORDER BY TotalProducts DESC
