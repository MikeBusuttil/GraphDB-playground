// tag::nodes[]

// Create orders
LOAD CSV WITH HEADERS FROM 'file:///orders.csv' AS row
MERGE (order:Order {orderID: row.OrderID})
  ON CREATE SET order.shipName = row.ShipName;

// Create products
LOAD CSV WITH HEADERS FROM "file:///products.csv" AS row
MERGE (product:Product {productID: row.ProductID})
  ON CREATE SET product.productName = row.ProductName, product.unitPrice = toFloat(row.UnitPrice);

// Create suppliers
LOAD CSV WITH HEADERS FROM "file:///suppliers.csv" AS row
MERGE (supplier:Supplier {supplierID: row.SupplierID})
  ON CREATE SET supplier.companyName = row.CompanyName;

// Create employees
LOAD CSV WITH HEADERS FROM "file:///employees.csv" AS row
MERGE (e:Employee {employeeID:row.EmployeeID})
  ON CREATE SET e.firstName = row.FirstName, e.lastName = row.LastName, e.title = row.Title;

// Create categories
LOAD CSV WITH HEADERS FROM "file:///categories.csv" AS row
MERGE (c:Category {categoryID: row.CategoryID})
  ON CREATE SET c.categoryName = row.CategoryName, c.description = row.Description;

// Create customers
LOAD CSV WITH HEADERS FROM "file:///customers.csv" AS row
MERGE (c:Customer {customerID: row.CustomerID})
  ON CREATE SET c.companyName = row.CompanyName, c.fax = row.Fax, c.phone = row.Phone;
  
// Create shippers
LOAD CSV WITH HEADERS FROM "file:///shippers.csv" AS row
MERGE (s:Shipper {shipperID: row.ShipperID})
  ON CREATE SET s.companyName = row.CompanyName, s.phone = row.Phone;

// end::nodes[]

// tag::constraints[]

CREATE INDEX product_id FOR (p:Product) ON (p.productID);
CREATE INDEX product_name FOR (p:Product) ON (p.productName);
CREATE INDEX supplier_id FOR (s:Supplier) ON (s.supplierID);
CREATE INDEX employee_id FOR (e:Employee) ON (e.employeeID);
CREATE INDEX category_id FOR (c:Category) ON (c.categoryID);
CREATE INDEX customer_id FOR (c:Customer) ON (c.customerID);
CREATE INDEX shipper_id FOR (s:Shipper) ON (s.shipperID);
CREATE CONSTRAINT FOR(o:Order) REQUIRE o.orderID IS UNIQUE;
CALL db.awaitIndexes();

// end::constraints[]

// tag::rels_orders[]

// Create relationships between orders and products
LOAD CSV WITH HEADERS FROM "file:///orders.csv" AS row
MATCH (order:Order {orderID: row.OrderID})
MATCH (product:Product {productID: row.ProductID})
MERGE (order)-[pu:INCLUDES]->(product)
ON CREATE SET pu.unitPrice = toFloat(row.UnitPrice), pu.quantity = toFloat(row.Quantity);

// Create relationships between orders and employees
LOAD CSV WITH HEADERS FROM "file:///orders.csv" AS row
MATCH (order:Order {orderID: row.OrderID})
MATCH (employee:Employee {employeeID: row.EmployeeID})
MERGE (employee)-[:SELLS]->(order);

// Create relationships between orders and customers
LOAD CSV WITH HEADERS FROM "file:///orders.csv" AS row
MATCH (order:Order {orderID: row.OrderID})
MATCH (customer:Customer {customerID: row.CustomerID})
MERGE (customer)-[:PURCHASES]->(order);

// Create relationships between orders and shippers
LOAD CSV WITH HEADERS FROM "file:///orders.csv" AS row
MATCH (order:Order {orderID: row.OrderID})
MATCH (shipper:Shipper {shipperID: row.ShipVia})
MERGE (shipper)-[:SHIPS]->(order);

// end::rels_orders[]

// tag::rels_products[]

// Create relationships between products and suppliers
LOAD CSV WITH HEADERS FROM "file:///products.csv" AS row
MATCH (product:Product {productID: row.ProductID})
MATCH (supplier:Supplier {supplierID: row.SupplierID})
MERGE (supplier)-[:SUPPLIES]->(product);

// Create relationships between products and categories
LOAD CSV WITH HEADERS FROM "file:///products.csv" AS row
MATCH (product:Product {productID: row.ProductID})
MATCH (category:Category {categoryID: row.CategoryID})
MERGE (product)<-[:CONTAINS]-(category);

// end::rels_products[]

// tag::rels_employees[]

// Create relationships between employees (reporting hierarchy)
LOAD CSV WITH HEADERS FROM "file:///employees.csv" AS row
MATCH (employee:Employee {employeeID: row.EmployeeID})
MATCH (manager:Employee {employeeID: row.ReportsTo})
MERGE (employee)<-[:MANAGES]-(manager);

// end::rels_employees[]
