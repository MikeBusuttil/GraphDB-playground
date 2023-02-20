MATCH (e:Employee)
OPTIONAL MATCH (e)-[:MANAGES*0..]->(sub)-[:SELLS]->(order)
RETURN
  e.prefix + " " + e.firstName + " " + e.lastName AS name,
  e.employeeID AS employee,
  [x IN COLLECT(DISTINCT sub.employeeID) WHERE x <> e.employeeID] AS reportsTo,
  COUNT(distinct order) AS totalOrders
ORDER BY totalOrders DESC
