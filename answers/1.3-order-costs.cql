MATCH (order:Order)-[i:INCLUDES]->(p:Product)
RETURN 
  order.orderID as orderID,
  SUM(i.quantity * i.unitPrice * (100 - i.discountPercent)/100) as totalPrice
order by orderID
