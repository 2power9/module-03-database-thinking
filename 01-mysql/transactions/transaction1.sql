DROP PROCEDURE IF EXISTS changeAddressLineForOffices;

delimiter //
CREATE PROCEDURE changeAddressLineForOffices(IN targetCity VARCHAR(50),
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

	COMMIT;

END //
delimiter ;

CALL changeAddressLineForOffices('Boston', 'Acorn Street', 'Beacon Street');
# CALL changeAddressLineForOffices('Boston', 'Dedham Street', 'Lake Street');

