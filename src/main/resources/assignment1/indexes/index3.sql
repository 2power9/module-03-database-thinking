CREATE INDEX paymentDateIndex
ON payments(paymentDate DESC) 
LOCK = SHARED;

DROP INDEX paymentDateIndex ON payments;

SELECT * FROM payments
WHERE paymentDate >= '2004-10-19';