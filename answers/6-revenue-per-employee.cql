MATCH (e:Employee)-[:SELLS]->(order)-[i:INCLUDES]->(p:Product)
RETURN
  e.prefix + " " + e.firstName + " " + e.lastName as employee,
  SUM(i.quantity * i.unitPrice * (100 - i.discountPercent)/100) AS revenue
ORDER BY revenue DESC
