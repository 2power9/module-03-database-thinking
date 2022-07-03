-- 1. start a new transaction
START TRANSACTION;

-- 2. update the officeCode of office in Boston

UPDATE offices
SET 
	addressLine2 = "Ho Chi Minh"
WHERE 
	city = "Boston";

-- 3. commit changes  
COMMIT;

-- SELECT * FROM offices
-- WHERE offices.city = "Boston";