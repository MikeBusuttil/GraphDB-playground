MATCH (o:Order)
WHERE 1996 = o.orderDate.year
RETURN o.shipCountry, AVG(o.freight) AS AverageFrieght
ORDER BY AverageFrieght DESC
LIMIT 3
