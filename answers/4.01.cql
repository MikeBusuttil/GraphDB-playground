MATCH (c:Customer)-[:PURCHASES]-(o:Order)-[i:INCLUDES]-(:Product)
WITH
  SUM(i.quantity*i.unitPrice*(100-i.discountPercent)/100) AS FinalPrice,
  o.orderID AS orderID,
  c.companyName AS company,
  o.orderDate.year as year
WHERE
  FinalPrice > 10_000 AND
  year = 1997
RETURN company, COLLECT('$' + toString(FinalPrice)) AS prices
