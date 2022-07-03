DROP PROCEDURE IF EXISTS deleteOfficeWithOfficeCode;

delimiter //

CREATE PROCEDURE deleteOfficeWithOfficeCode(IN targetOfficeCode VARCHAR(10))
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION ROLLBACK;

    -- 1. start a new transaction
    START TRANSACTION;

    -- 3. update new office for employees in the old office (DEFAULT = 1)
    UPDATE employees
    SET officeCode = '1'
    WHERE officeCode = targetOfficeCode;

    -- 2. delete office
    DELETE FROM offices WHERE officeCode = targetOfficeCode;

    COMMIT;
END;

delimiter ;

CALL deleteOfficeWithOfficeCode('8');

SELECT * FROM offices WHERE officeCode = '8';
select * FROM employees WHERE officeCode = '8';