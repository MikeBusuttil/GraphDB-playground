MATCH (o:Order)-[:SHIPS]-(s:Shipper)
WHERE date('1997-05-01') <= o.orderDate <= date('1997-05-14')
RETURN o.orderID, o.orderDate, s.companyName
ORDER BY o.orderDate
