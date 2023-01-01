SELECT
  CONCAT(TitleOfCourtesy, ' ', FirstName, ' ', LastName) AS name,
  Title,
  TIMESTAMPDIFF(YEAR, BirthDate, CURDATE()) AS Age
FROM
  employees
ORDER BY
  Birthdate
