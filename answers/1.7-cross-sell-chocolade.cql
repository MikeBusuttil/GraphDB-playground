MATCH (choc:Product {productName:'Chocolade'})<-[:INCLUDES]-(:Order)<-[:SELLS]-(employee),
      (employee)-[:SELLS]->(order2)-[:INCLUDES]->(other:Product)
RETURN
  employee.firstName + " " + employee.lastName AS employee,
  other.productName AS otherProduct,
  count(DISTINCT order2) AS count
ORDER BY count DESC
