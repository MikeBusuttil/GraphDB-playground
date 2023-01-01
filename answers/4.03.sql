SELECT
  OrderID,
  OrderDate,
  RequiredDate,
  ShippedDate
FROM
  orders
WHERE
  RequiredDate <= ShippedDate
