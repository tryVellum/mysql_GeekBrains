
-- 1) Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.

SELECT id, name FROM users
WHERE
	id IN (SELECT user_id FROM orders);

-- 2) Выведите список товаров products и разделов catalogs, который соответствует товару.

SELECT
  products.id,
  products.name,
  (SELECT
 	catalogs.name
   FROM
 	catalogs
   WHERE
 	catalogs.id = products.catalog_id) AS 'catalog'
FROM
  products;
 
 -- 3) (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name).
 --    Поля from, to и label содержат английские названия городов, поле name — русское. Выведите список рейсов flights с русскими названиями городов.
 
DROP TABLE IF EXISTS flights;
CREATE TABLE flights (
	id SERIAL PRIMARY KEY,
	from_ VARCHAR(255) COMMENT 'Город вылета',
	to_ VARCHAR(255) COMMENT 'Город прилёта'
) COMMENT = 'Рейсы';

INSERT INTO flights(from_, to_) VALUES
	('moskow', 'omsk'),
	('novgorod', 'kazan'),
	('irkutk', 'moskow'),
	('omsk', 'irkutk'),
	('moskow', 'kazan');

DROP TABLE IF EXISTS cities;
CREATE TABLE cities (
	label VARCHAR(255) COMMENT 'Город en',
	name VARCHAR(255) COMMENT 'Город rus'
) COMMENT = 'Название городов';

INSERT INTO cities(label, name) VALUES
	('moskow', 'Москва'),
	('novgorod', 'Новогород'),
	('irkutk', 'Иркутск'),
	('omsk', 'Омск'),
	('kazan', 'Казань');
	
SELECT
	id,
	(SELECT name FROM cities
	 WHERE flights.from_ = label) AS 'from',
	(SELECT name FROM cities
	 WHERE flights.to_ = label) AS 'to'	
FROM flights;
