1. Visualize the org chart

2. Lets see an order

. How much does each order cost?

select OrderID, 
    format(sum(UnitPrice * Quantity * (1 - Discount)), 2) as Subtotal
from `order details`
group by OrderID
order by OrderID;

MATCH (order:Order)-[i:INCLUDES]->(p:Product)
RETURN order.orderID as orderID, SUM(i.quantity * i.unitPrice) as totalPrice
order by orderID

. Sales by year?

select distinct date(a.ShippedDate) as ShippedDate, 
    a.OrderID, 
    b.Subtotal, 
    year(a.ShippedDate) as Year
from Orders a 
inner join
(
    -- Get subtotal for each order
    select distinct OrderID, 
        format(sum(UnitPrice * Quantity * (1 - Discount)), 2) as Subtotal
    from order_details
    group by OrderID    
) b on a.OrderID = b.OrderID
where a.ShippedDate is not null
    and a.ShippedDate between date('1996-12-24') and date('1997-09-30')
order by a.ShippedDate;

MATCH (order:Order)-[i:INCLUDES]->(p:Product)
RETURN order.orderID as orderID, SUM(i.quantity * i.unitPrice) as totalPrice, DISTINCT order.shippedDate
order by orderID

3. Which Employees had the Highest Cross-Selling Count of 'Chocolade' and Another Product?

MATCH (choc:Product {productName:'Chocolade'})<-[:INCLUDES]-(:Order)<-[:SELLS]-(employee),
      (employee)-[:SELLS]->(order2)-[:INCLUDES]->(other:Product)
RETURN employee.firstName + " " + employee.lastName as employee, other.productName as otherProduct, count(distinct order2) as count
ORDER BY count DESC
LIMIT 

4. How Many Orders were Made under each employee?

MATCH (e:Employee)
OPTIONAL MATCH (e)-[:MANAGES*0..]->(sub)-[:SELLS]->(order)
RETURN e.firstName + " " + e.lastName as name, e.employeeID as employee, [x IN COLLECT(DISTINCT sub.employeeID) WHERE x <> e.employeeID] AS reportsTo, COUNT(distinct order) AS totalOrders
ORDER BY totalOrders DESC;

5. How much revenue did each employee bring in?

MATCH (e:Employee)-[:SELLS]->(order)-[i:INCLUDES]->(p:Product)
RETURN e.firstName + " " + e.lastName as employee, SUM(i.quantity * i.unitPrice) AS revenue
ORDER BY revenue DESC;

6. How much revenue was brought in under each employee?

MATCH (e:Employee)-[:SELLS]->(order)-[i:INCLUDES]->(p:Product)
OPTIONAL MATCH (e)-[:MANAGES*0..]->(sub)-[:SELLS]->(order)-[i:INCLUDES]->(p:Product)
RETURN e.employeeID as employee, [x IN COLLECT(DISTINCT sub.employeeID) WHERE x <> e.employeeID] AS reportsTo, SUM(i.quantity * i.unitPrice) AS revenue
ORDER BY revenue DESC;
