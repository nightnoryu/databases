USE lab04;


-- 3.1 INSERT

-- 3.1a Без указания списка полей
INSERT INTO passenger
VALUES (1, 'John', 'Doe', '1989-07-15'),
       (2, 'Joanne', 'Di', '1995-03-02');

-- 3.1b С указанием списка полей
INSERT INTO plane (name, capacity, fuel_consumption, adoption_date)
VALUES ('Thunder', 50, 2500, '1999-03-02'),
       ('Margaret', 100, 3000, '2005-06-15');

-- 3.1c С чтением значения из другой таблицы
INSERT INTO flight (id_plane, start_date, end_date)
VALUES ((SELECT id_plane FROM plane ORDER BY id_plane LIMIT 1), '2022-01-14', '2022-01-15');


-- 3.2 DELETE

-- 3.2a Всех записей
-- noinspection SqlWithoutWhere
DELETE
FROM flight;

-- 3.2b По условию
DELETE
FROM plane
WHERE fuel_consumption = 3000;


-- 3.3 UPDATE

-- 3.3a Всех записей
-- noinspection SqlWithoutWhere
UPDATE passenger
SET first_name = 'Jane';

-- 3.3b По условию обновляя один атрибут
UPDATE passenger
SET birthdate = '1996-03-02'
WHERE last_name = 'Di';

-- 3.3c По условию обновляя несколько атрибутов
UPDATE passenger
SET first_name = 'Argenta',
    birthdate  = '1996-03-02'
WHERE id_passenger = 2;


-- 3.4 SELECT

-- 3.4a С набором извлекаемых атрибутов
SELECT first_name, last_name
FROM passenger;

-- 3.4b Со всеми атрибутами
SELECT *
FROM flight;

-- 3.4c С условием по атрибуту
SELECT *
FROM plane
WHERE capacity = 50;


-- 3.5 SELECT ORDER BY + TOP (LIMIT)

-- 3.5a С сортировкой по возрастанию ASC + ограничение вывода количества записей
SELECT *
FROM plane
ORDER BY fuel_consumption
LIMIT 5;

-- 3.5b С сортировкой по убыванию DESC
SELECT *
FROM plane
ORDER BY fuel_consumption DESC
LIMIT 5;

-- 3.5c С сортировкой по двум атрибутам + ограничение вывода количества записей
SELECT *
FROM plane
ORDER BY fuel_consumption, capacity
LIMIT 5;

-- 3.5d С сортировкой по первому атрибуту, из списка извлекаемых
-- TODO


-- 3.6 Работа с датами

-- 3.6a WHERE по дате
SELECT *
FROM flight
WHERE start_date = '2022-01-14';

-- 3.6b WHERE дата в диапазоне
SELECT *
FROM flight
WHERE end_date BETWEEN '2021-01-01' AND '2021-12-31';

-- 3.6c Извлечь из таблицы не всю дату, а только год
SELECT name, YEAR(adoption_date)
FROM plane;


-- 3.7 Функции агрегации

-- 3.7a Посчитать количество записей в таблице
SELECT COUNT(*)
FROM ticket;

-- 3.7b Посчитать количество уникальных записей в таблице
SELECT COUNT(DISTINCT first_name)
FROM passenger;

-- 3.7c Вывести уникальные значения столбца
SELECT DISTINCT first_name
FROM passenger;

-- 3.7d Найти максимальное значение столбца
SELECT name, MAX(capacity)
FROM plane;

-- 3.7e Найти минимальное значение столбца
SELECT name, MIN(fuel_consumption)
FROM plane;

-- 3.7f Написать запрос COUNT() + GROUP BY
SELECT COUNT(*)
FROM passenger
GROUP BY first_name;


-- 3.8 SELECT GROUP BY + HAVING

-- 3.8a Написать 3 разных запроса с использованием GROUP BY + HAVING. Для
-- каждого запроса написать комментарий с пояснением, какую информацию
-- извлекает запрос. Запрос должен быть осмысленным, т.е. находить информацию,
-- которую можно использовать.


-- 3.9 SELECT JOIN

-- 3.9a LEFT JOIN двух таблиц и WHERE по одному из атрибутов

-- 3.9b RIGHT JOIN. Получить такую же выборку, как и в 3.9a

-- 3.9c LEFT JOIN трех таблиц + WHERE по атрибуту из каждой таблицы

-- 3.9d INNER JOIN двух таблиц


-- 3.10 Подзапросы

-- 3.10a Написать запрос с условием WHERE IN (подзапрос)

-- 3.10b Написать запрос SELECT atr1, atr2, (подзапрос) FROM ...

-- 3.10c Написать запрос вида SELECT * FROM (подзапрос)

-- 3.10d Написать запрос вида SELECT * FROM table JOIN (подзапрос) ON ...
