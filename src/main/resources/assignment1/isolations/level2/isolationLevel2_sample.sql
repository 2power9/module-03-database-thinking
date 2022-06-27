DROP PROCEDURE IF EXISTS deleteOfficeWithOfficeCode_IsolationLevel2Test;

delimiter //

CREATE PROCEDURE deleteOfficeWithOfficeCode_IsolationLevel2Test(IN targetOfficeCode VARCHAR(10))
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION ROLLBACK;

    -- 1. start a new transaction
    START TRANSACTION;

        -- 2. update new office for employees in the old office (DEFAULT = 1)
        UPDATE employees
        SET officeCode = '1'
        WHERE officeCode = targetOfficeCode;

        -- 3. delete office
        DELETE FROM offices WHERE officeCode = targetOfficeCode;

    COMMIT;

    SELECT SLEEP(15);

    SELECT * FROM offices WHERE officeCode = '8';
    SELECT * FROM employees WHERE officeCode = '8';
END;

delimiter ;

CALL deleteOfficeWithOfficeCode_IsolationLevel2Test('8');

