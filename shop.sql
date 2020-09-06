DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название раздела',
  UNIQUE unique_name(name(10))
) COMMENT = 'Разделы интернет-магазина';

INSERT INTO catalogs VALUES
  (NULL, 'Процессоры'),
  (NULL, 'Материнские платы'),
  (NULL, 'Видеокарты'),
  (NULL, 'Жесткие диски'),
  (NULL, 'Оперативная память');

DROP TABLE IF EXISTS rubrics;
CREATE TABLE rubrics (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название раздела'
) COMMENT = 'Разделы интернет-магазина';

INSERT INTO rubrics VALUES
  (NULL, 'Видеокарты'),
  (NULL, 'Память');

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

INSERT INTO users (name, birthday_at) VALUES
  ('Геннадий', '1990-10-05'),
  ('Наталья', '1984-11-12'),
  ('Александр', '1985-05-20'),
  ('Сергей', '1988-02-14'),
  ('Иван', '1998-01-12'),
  ('Мария', '1992-08-29');

DROP TABLE IF EXISTS products;
CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название',
  description TEXT COMMENT 'Описание',
  price DECIMAL (11,2) COMMENT 'Цена',
  catalog_id INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_catalog_id (catalog_id)
) COMMENT = 'Товарные позиции';

INSERT INTO products
  (name, description, price, catalog_id)
VALUES
  ('Intel Core i3-8100', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 7890.00, 1),
  ('Intel Core i5-7400', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 12700.00, 1),
  ('AMD FX-8320E', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 4780.00, 1),
  ('AMD FX-8320', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 7120.00, 1),
  ('ASUS ROG MAXIMUS X HERO', 'Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX', 19310.00, 2),
  ('Gigabyte H310M S2H', 'Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX', 4790.00, 2),
  ('MSI B250M GAMING PRO', 'Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX', 5060.00, 2);

DROP TABLE IF EXISTS `discounts`;

CREATE TABLE `discounts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT NULL,
  `product_id` int(10) unsigned DEFAULT NULL,
  `discount` float unsigned DEFAULT NULL COMMENT 'Величина скидки от 0.0 до 1.0',
  `started_at` datetime DEFAULT NULL,
  `finished_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_of_user_id` (`user_id`),
  KEY `index_of_product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Скидки';

#
# TABLE STRUCTURE FOR: orders
#

DROP TABLE IF EXISTS `orders`;

CREATE TABLE `orders` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_of_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Заказы';

INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('1', 5, '1982-07-20 02:37:42', '1998-12-28 19:10:29');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('2', 6, '1996-10-13 00:50:02', '1983-04-10 06:47:22');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('3', 4, '1981-05-13 22:08:19', '1994-10-19 11:09:54');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('4', 5, '2009-02-24 07:24:52', '2001-04-03 09:41:43');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('5', 2, '1970-05-30 08:08:32', '1973-11-27 22:02:14');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('6', 4, '2004-07-05 03:25:38', '2001-01-21 18:40:16');


#
# TABLE STRUCTURE FOR: orders_products
#

DROP TABLE IF EXISTS `orders_products`;

CREATE TABLE `orders_products` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned DEFAULT NULL,
  `product_id` int(10) unsigned DEFAULT NULL,
  `total` int(10) unsigned DEFAULT 1 COMMENT 'Количество заказанных товарных позиций',
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Состав заказа';

INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('1', 4, 7, 5, '2020-09-06 19:00:03', '2020-09-06 19:00:03');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('2', 1, 1, 4, '2020-09-06 19:00:03', '2020-09-06 19:00:03');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('3', 1, 5, 3, '2020-09-06 19:00:03', '2020-09-06 19:00:03');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('4', 3, 4, 4, '2020-09-06 19:00:03', '2020-09-06 19:00:03');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('5', 4, 7, 3, '2020-09-06 19:00:03', '2020-09-06 19:00:03');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('6', 3, 1, 4, '2020-09-06 19:00:03', '2020-09-06 19:00:03');


#
# TABLE STRUCTURE FOR: storehouses
#

DROP TABLE IF EXISTS `storehouses`;

CREATE TABLE `storehouses` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Название',
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Склады';

INSERT INTO `storehouses` (`id`, `name`, `created_at`, `updated_at`) VALUES ('1', 'quidem', '2020-09-06 19:01:07', '2020-09-06 19:01:07');
INSERT INTO `storehouses` (`id`, `name`, `created_at`, `updated_at`) VALUES ('2', 'fuga', '2020-09-06 19:01:07', '2020-09-06 19:01:07');
INSERT INTO `storehouses` (`id`, `name`, `created_at`, `updated_at`) VALUES ('3', 'et', '2020-09-06 19:01:07', '2020-09-06 19:01:07');


#
# TABLE STRUCTURE FOR: storehouses_products
#

DROP TABLE IF EXISTS `storehouses_products`;

CREATE TABLE `storehouses_products` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `storehouse_id` int(10) unsigned DEFAULT NULL,
  `product_id` int(10) unsigned DEFAULT NULL,
  `value` int(10) unsigned DEFAULT NULL COMMENT 'Запас товарной позиции на складе',
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Запасы на складе';
