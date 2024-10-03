--Задание 1
SELECT code, price
FROM printer
WHERE price >= 270
GROUP BY code;

--Задание2
SELECT pc.code, pc.hd, product.department_id FROM pc
JOIN product ON product.model = pc.model 
ORDER BY hd DESC LIMIT 1

--Задание 3
SELECT COUNT(speed) as count FROM pc
WHERE speed = 450


-- Задание 1
SELECT name, value FROM goods 
JOIN prices ON prices.goods_id = goods.id
ORDER BY value DESC LIMIT 1

--Задание 2
SELECT name, value AS price FROM goods 
JOIN prices ON prices.goods_id = goods.id
WHERE goods.id IN (
	SELECT goods_id FROM quantity
	WHERE quantity.value = 0 );

-- Задание 3
SELECT manufacturer.name, AVG(value) AS average_price 
FROM manufacturer
JOIN suppliers ON manufacturer.id = suppliers.manufacturer_id
JOIN goods ON suppliers.id = goods.supplier_id
JOIN prices ON goods.id = prices.goods_id
GROUP BY manufacturer.id
ORDER BY AVG(value) DESC LIMIT 1

-- Задание 4
SELECT goods.name, prices.value, manufacturer.name FROM manufacturer 
JOIN suppliers ON suppliers.manufacturer_id = manufacturer.id 
JOIN goods ON goods.supplier_id = suppliers.id
JOIN prices ON prices.goods_id = goods.id
WHERE manufacturer.location = 'Moscow'