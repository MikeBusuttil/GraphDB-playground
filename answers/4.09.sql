WITH yCountry AS (
  SELECT
    ShipCountry,
    CustomerID,
    OrderID,
    OrderDate AS OrderDate,
    ROW_NUMBER() OVER (
      PARTITION BY ShipCountry
      ORDER BY
        ShipCountry,
        OrderDate
    ) AS RowNumberPerCountry
  FROM
    orders
)
SELECT
  ShipCountry,
  CustomerID,
  OrderID,
  OrderDate
FROM
  yCountry
WHERE
  RowNumberPerCountry = 1
ORDER BY
  ShipCountry
