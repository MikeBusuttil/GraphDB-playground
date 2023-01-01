MATCH (order:Order)-[i:INCLUDES]->(p:Product)
RETURN 
  order.shippedDate AS shipped,
  order.orderID AS orderID,
  SUM(i.quantity * i.unitPrice * (100 - i.discountPercent)/100) AS subTotal,
  order.shippedDate.year AS year
ORDER BY shipped
