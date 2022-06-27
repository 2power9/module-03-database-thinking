CREATE INDEX productNameIndex
ON products(productName);

DROP INDEX productNameIndex ON products;


SELECT * FROM products
WHERE productName = "Pont Yacht";