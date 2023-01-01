MATCH (e:Employee)
OPTIONAL MATCH (e)-[:MANAGES*0..]->(sub)-[:SELLS]->(order)
RETURN
  e.prefix + " " + e.firstName + " " + e.lastName as name,
  e.employeeID as employee,
  [x IN COLLECT(DISTINCT sub.employeeID) WHERE x <> e.employeeID] AS reportsTo,
  COUNT(distinct order) AS totalOrders
ORDER BY totalOrders DESC
