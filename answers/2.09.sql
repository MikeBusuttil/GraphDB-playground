SELECT FirstName, LastName, Title, BirthDate, TIMESTAMPDIFF(YEAR, BirthDate, CURDATE()) AS Age
FROM employees
ORDER BY Birthdate
