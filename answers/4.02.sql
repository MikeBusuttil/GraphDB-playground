SELECT
  OrderID
FROM
  `order details`
WHERE
  Quantity >= 60
GROUP BY
  OrderID,
  Quantity
HAVING
  COUNT(*) > 1
