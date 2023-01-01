SELECT
  DISTINCT date(a.ShippedDate) AS ShippedDate,
  a.OrderID,
  b.Subtotal,
  year(a.ShippedDate) AS Year
FROM
  orders a
  INNER JOIN (
    -- Get subtotal for each order
    SELECT
      DISTINCT OrderID,
      format(sum(UnitPrice * Quantity * (1 - Discount)), 2) AS Subtotal
    FROM
      `order details`
    GROUP BY
      OrderID
  ) b ON a.OrderID = b.OrderID
WHERE
  a.ShippedDate IS NOT NULL
ORDER BY
  a.ShippedDate
