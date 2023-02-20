MATCH (e:Employee)-[:SELLS]->(order)-[i:INCLUDES]->(p:Product)
RETURN
  e, SUM(i.quantity * i.unitPrice * (100 - i.discountPercent)/100) AS revenue
ORDER BY revenue DESC
SKIP 3
LIMIT 1
