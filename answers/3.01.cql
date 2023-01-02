MATCH (c:Category)-[:CONTAINS]-(p:Product)
RETURN c.categoryName, COUNT(p) AS TotalProducts
ORDER BY TotalProducts DESC
