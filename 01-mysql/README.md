# 01-MySQL 

## Transaction

### Definition

- A unit of work performed within a database management system (or similar system) 
- Treated in a coherent and reliable way independent of other transactions. 
- Represents any change in a database. 

### Purposes

1. To provide reliable units of work that allow correct recovery from failures and keep 
a database consistent even in cases of system failure. 

2. To provide isolation between programs accessing a database concurrently. If this isolation 
is not provided, the programs' outcomes are possibly erroneous.

### Example

```=MySQL
START TRANSACTION;

-- 2. update the addressLine of office in targetCity
UPDATE offices
SET
    addressLine1 = @newAddressLine1,
    addressLine2 = @newAddressLine2
WHERE 
    city = @targetCity;

COMMIT;
```

## Isolation

Isolation determines how transaction integrity is visible to other users and systems.

### 1. Read Uncommitted

Query 1:
```=MySQL
START TRANSACTION;

    UPDATE offices
    SET
        addressLine1 = newAddressLine1,
        addressLine2 = newAddressLine2
    WHERE
            city = targetCity;

    SELECT SLEEP(15);

ROLLBACK;
```

Query 2:
```=MySQL
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
START TRANSACTION;

    SELECT * FROM offices
    WHERE offices.city = 'Boston';

COMMIT;
```

Transaction of query 2 get data from transaction of query 1 while this transaction hasn't committed yet. ⇒ `Dirty Read`

### 2. Read Committed

Query 1:
```=MySQL
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
```

Query 2:
```=MySQL
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
START TRANSACTION;

    INSERT INTO offices (officeCode, city, phone, addressLine1, addressLine2, state, country, postalCode, territory)
    VALUES ('8', 'Ho Chi Minh', '012.345.678', 'Duong so 13, Tan Thuan Dong', null, '7', 'Vietnam', '12345', 'VNG');

    UPDATE employees
    SET officeCode = '8'
    WHERE employeeNumber = 1704;

COMMIT;
```

This is a default level of a transaction.

In this level, a transaction can not read data from another transaction is processing.

The query 2 gonna read data which isn't updated yet (because transaction of query 1 doesn't finish) ⇒ `Phantom Row`

### 3. Repeatable read

Query 1:
```=MySQL
START TRANSACTION;

    SELECT SLEEP(15);

    UPDATE offices
    SET
        addressLine1 = newAddressLine1,
        addressLine2 = newAddressLine2
    WHERE
            city = targetCity;

    SELECT * FROM offices
    WHERE offices.city = 'Boston';

COMMIT;
```

Query 2:
```=MySQL
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
START TRANSACTION;

    SELECT * FROM offices
    WHERE offices.city = 'Boston';

COMMIT;
```

In this level, transaction can not read/overwrite on a table if another transaction is updating on this table.

If in query 2, we use `UPDATE` or `DELETE` instead of reading ⇒ `Phantom Row`

### 4. Serializable

Query 1:
```=MySQL
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
START TRANSACTION;

    SELECT * FROM offices WHERE officeCode = targetOfficeCode;
    SELECT * FROM employees WHERE officeCode = targetOfficeCode;

    SELECT SLEEP(15);

    SELECT * FROM offices WHERE officeCode = targetOfficeCode;
    SELECT * FROM employees WHERE officeCode = targetOfficeCode;

COMMIT;
```

Query 2:
```=MySQL
START TRANSACTION;

    -- 1. update new office for employees in the old office (DEFAULT = 1)
    UPDATE employees
    SET officeCode = '1'
    WHERE officeCode = targetOfficeCode;

    -- 2. delete office
    DELETE FROM offices WHERE officeCode = targetOfficeCode;

COMMIT;
```

This is the highest level of Isolation, when the transaction executes, it will lock
the related records and will unlock until rollback or commit data.

### Conclusion

| Transaction isolation level | Dirty reads | Nonrepeatable reads | Phantoms |
|-----------------------------|:-----------:|:-------------------:|:--------:|
| Read uncommitted	          |      ❌       |          ❌          |    ❌     |
| Read committed	          |      -      |          ❌           |    ❌     |
| Repeatable read		      |      -      |          -          |     ❌     |
| Serializable    	          |      -      |          -          |    -     |


## Indexes

### Definition

A database index is a data structure that improves the speed of data retrieval operations on a database 
table at the cost of additional writes and storage space to maintain the index data structure.

### Example

```=MySQL
CREATE INDEX productNameIndex
ON products(productName);
```

##### References

<https://en.wikipedia.org/wiki/Database_transaction>

<https://en.wikipedia.org/wiki/Database_index>

<https://en.wikipedia.org/wiki/Isolation_(database_systems)>

<https://viblo.asia/p/isolation-level-of-mysql-63vKjRmAK2R>