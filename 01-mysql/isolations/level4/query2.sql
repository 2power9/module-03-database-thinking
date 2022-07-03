DROP PROCEDURE IF EXISTS queryOfficeWithOfficeCode;

delimiter //

CREATE PROCEDURE queryOfficeWithOfficeCode(IN targetOfficeCode VARCHAR(10))
BEGIN
    -- 1. start a new transaction
    START TRANSACTION;

    -- 2. update new office for employees in the old office (DEFAULT = 1)
    UPDATE employees
    SET officeCode = '1'
    WHERE officeCode = targetOfficeCode;

    -- 3. delete office
    DELETE FROM offices WHERE officeCode = targetOfficeCode;

    COMMIT;

END //


CALL queryOfficeWithOfficeCode('8')
