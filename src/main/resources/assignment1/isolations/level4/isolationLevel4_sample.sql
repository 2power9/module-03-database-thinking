DROP PROCEDURE IF EXISTS deleteOfficeWithOfficeCode_IsolationLevel4Test;

delimiter //

CREATE PROCEDURE deleteOfficeWithOfficeCode_IsolationLevel4Test(IN targetOfficeCode VARCHAR(10))
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION ROLLBACK;

    -- 1. start a new transaction
    SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
    START TRANSACTION;

    SELECT * FROM offices WHERE officeCode = targetOfficeCode;
    SELECT * FROM employees WHERE officeCode = targetOfficeCode;

    SELECT SLEEP(15);

    SELECT * FROM offices WHERE officeCode = targetOfficeCode;
    SELECT * FROM employees WHERE officeCode = targetOfficeCode;

    COMMIT;


END;

delimiter ;

CALL deleteOfficeWithOfficeCode_IsolationLevel4Test('8');

