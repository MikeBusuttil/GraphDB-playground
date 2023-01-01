SELECT OrderID, CustomerID, ShipCountry
FROM orders
WHERE ShipCountry  IN ('Brazil', 'Mexico', 'Argentina', 'Venezuela')
