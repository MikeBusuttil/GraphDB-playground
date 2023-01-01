MATCH (order:Order)-[i:INCLUDES]->(p:Product)
RETURN 
  order.shippedDate as shipped,
  order.orderID as orderID,
  SUM(i.quantity * i.unitPrice * (100 - i.discountPercent)/100) as subTotal,
  order.shippedDate.year as year
order by shipped
