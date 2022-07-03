CREATE INDEX lastNameEmployeesIndex
ON employees(lastName)
USING HASH;

DROP INDEX lastNameEmployeesIndex ON employees;

SELECT * FROM employees
WHERE lastName = 'King';