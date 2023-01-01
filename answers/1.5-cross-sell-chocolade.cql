MATCH (choc:Product {productName:'Chocolade'})<-[:INCLUDES]-(:Order)<-[:SELLS]-(employee),
      (employee)-[:SELLS]->(order2)-[:INCLUDES]->(other:Product)
RETURN
  employee.firstName + " " + employee.lastName as employee,
  other.productName as otherProduct,
  count(distinct order2) as count
ORDER BY count DESC
