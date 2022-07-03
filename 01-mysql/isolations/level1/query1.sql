DROP PROCEDURE IF EXISTS changeAddressLineForOffices_IsolationLevel1Test;

delimiter //
CREATE PROCEDURE changeAddressLineForOffices_IsolationLevel1Test(IN targetCity VARCHAR(50),
                                             IN newAddressLine1 VARCHAR(50),
                                             IN newAddressLine2 VARCHAR(50))
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION ROLLBACK;

    -- 1. start a new transaction
    START TRANSACTION;

    -- 2. update the addressLine of office in targetCity, this query is for demo only (;-;)
    UPDATE offices
    SET
        addressLine1 = newAddressLine1,
        addressLine2 = newAddressLine2
    WHERE
            city = targetCity;

    SELECT SLEEP(15);
    ROLLBACK;
END //
delimiter ;

CALL changeAddressLineForOffices_IsolationLevel1Test('Boston', 'Acorn Street', 'Beacon Street');
# CALL changeAddressLineForOffices_IsolationLevel1Test('Boston', 'Dedham Street', 'Lake Street');

