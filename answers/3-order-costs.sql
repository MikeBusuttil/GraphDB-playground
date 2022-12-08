select OrderID, 
    format(sum(UnitPrice * Quantity * (1 - Discount)), 2) as Subtotal
from `order details`
group by OrderID
order by OrderID
