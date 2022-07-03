DROP PROCEDURE IF EXISTS insertNewCustomer;

delimiter //
CREATE PROCEDURE insertNewCustomer(IN customerName VARCHAR(50),
                                   IN contactLastName VARCHAR(50),
                                   IN contactFirstName VARCHAR(50),
                                   IN phone VARCHAR(50),
                                   IN addressLine1 VARCHAR(50),
                                   IN addressLine2 VARCHAR(50),
                                   IN city VARCHAR(50),
                                   IN state VARCHAR(50),
                                   IN postalCode VARCHAR(50),
                                   IN country VARCHAR(50),
                                   IN salesRepEmployeeNumber INT(11),
                                   IN creditLimit DECIMAL(10, 2))
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION ROLLBACK;

	-- 1. start a  transaction
	START TRANSACTION;

	    -- 2. get new customer number
	    SELECT @newCustomerNumber := customerNumber + 1 FROM customers ORDER BY customerNumber DESC LIMIT 1;

	    -- 3. insert new customer into table
	    INSERT INTO  customers -- (`customerNumber`, `customerName`, `contactLastName`, `contactFirstName`, `phone`, `addressLine1`, `addressLine2`, `city`, `state`, `postalCode`, `country`, `salesRepEmployeeNumber`, `creditLimit`)
        VALUES (@newCustomerNumber, customerName, contactLastName, contactFirstName, phone, addressLine1, addressLine2,
                city, state, postalCode, country, salesRepEmployeeNumber, creditLimit);

	COMMIT;

END //
delimiter ;

CALL insertNewCustomer('ZaloPay', 'Andrena','Tran', '0123.456',
    'Duong so 13, Tan Thuan Dong', null,
    'Ho Chi Minh', '7', null, 'Vietnam',
    1102, 300000);

SELECT * FROM customers ORDER BY customerNumber DESC LIMIT 1;

# SELECT @maxNumber := MAX(customerNumber) FROM customers;
# DELETE FROM customers WHERE customerNumber = @maxNumber;