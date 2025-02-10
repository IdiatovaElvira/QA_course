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

--Задание 5
SELECT author.name_author, book.title, COUNT(buy_book.amount) AS 'Количество'
FROM book
INNER JOIN author ON book.author_id = author.author_id
LEFT JOIN buy_book ON book.book_id = buy_book.book_id
GROUP BY author.name_author, book.title
ORDER BY author.name_author, book.title

--Задание 6
SELECT name_genre, SUM(buy_book.amount) AS Количество
FROM genre
INNER JOIN book USING(genre_id)
INNER JOIN buy_book USING(book_id)
GROUP BY name_genre
HAVING SUM(buy_book.amount) = ((SELECT MAX(sum_amount) AS max_sum_amount 
            FROM (SELECT SUM(buy_book.amount) AS sum_amount 
            FROM buy_book 
            INNER JOIN book ON buy_book.book_id=book.book_id
            INNER JOIN genre ON book.genre_id=genre.genre_id
            GROUP BY genre.genre_id) g))

--Задание 7
SELECT buy_step.buy_id, (DATEDIFF(date_step_end, date_step_beg)) AS Количество_дней,
               IF(((DATEDIFF(date_step_end, date_step_beg)) - days_delivery) <0, 0, ((DATEDIFF(date_step_end, date_step_beg)) - days_delivery)) AS Опоздание
FROM buy_step
INNER JOIN step ON buy_step.step_id = step.step_id
INNER JOIN buy ON buy_step.buy_id = buy.buy_id
INNER JOIN client ON buy.client_id = client.client_id
INNER JOIN city ON client.city_id = city.city_id
WHERE date_step_end IS NOT NULL AND name_step = 'Транспортировка'
ORDER BY buy_step.buy_id