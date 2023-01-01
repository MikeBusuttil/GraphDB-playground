SELECT Country FROM customers
UNION
SELECT Country FROM suppliers
ORDER BY Country
