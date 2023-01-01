MATCH (order:Order)-[i:INCLUDES]->(p:Product)
RETURN 
  order.orderID AS orderID,
  SUM(i.quantity * i.unitPrice * (100 - i.discountPercent)/100) AS totalPrice
ORDER BY orderID
