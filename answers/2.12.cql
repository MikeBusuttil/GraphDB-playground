MATCH (o:Order)
WHERE date({year: 1995, month: 5, day: 1}) <= o.orderDate <= date({year: 1995, month: 5, day: 14})
RETURN o
