-- phantom
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
START TRANSACTION;

INSERT INTO offices (officeCode, city, phone, addressLine1, addressLine2, state, country, postalCode, territory)
VALUES ('8', 'Ho Chi Minh', '012.345.678', 'Duong so 13, Tan Thuan Dong', null, '7', 'Vietnam', '12345', 'VNG');

UPDATE employees
SET officeCode = '8'
WHERE employeeNumber = 1704;

COMMIT;

