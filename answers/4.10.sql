SELECT
  InitialOrder.CustomerID,
  InitialOrder.OrderID AS InitialOrderID,
  InitialOrder.OrderDate AS InitialOrderDate,
  NextOrder.OrderID AS NextOrderID,
  NextOrder.OrderDate AS NextOrderDate,
  DATEDIFF(NextOrder.OrderDate, InitialOrder.OrderDate) AS DaysBetween
FROM
  orders AS InitialOrder
  JOIN orders AS NextOrder ON InitialOrder.CustomerID = NextOrder.CustomerID
WHERE
  InitialOrder.OrderID < NextOrder.OrderID
  AND DATEDIFF(NextOrder.OrderDate, InitialOrder.OrderDate) <= 5
ORDER BY
  InitialOrder.CustomerID,
  InitialOrder.OrderID