select distinct date(a.ShippedDate) as ShippedDate, 
    a.OrderID, 
    b.Subtotal, 
    year(a.ShippedDate) as Year
from orders a 
inner join
(
    -- Get subtotal for each order
    select distinct OrderID, 
        format(sum(UnitPrice * Quantity * (1 - Discount)), 2) as Subtotal
    from `order details`
    group by OrderID    
) b on a.OrderID = b.OrderID
where a.ShippedDate is not null
order by a.ShippedDate
