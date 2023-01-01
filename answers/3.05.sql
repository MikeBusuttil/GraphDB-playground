SELECT
  CustomerID,
  CompanyName,
  Region
FROM
  customers
ORDER BY
  CASE
    WHEN Region IS NULL then 1
    ELSE 0
  END,
  Region,
  CustomerID
