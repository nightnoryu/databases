USE lab06;


-- 1. Добавить внешние ключи.
ALTER TABLE dealer
    ADD CONSTRAINT dealer_company_id_company_fk
        FOREIGN KEY (id_company) REFERENCES company (id_company)
            ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE `order`
    ADD CONSTRAINT order_production_id_production_fk
        FOREIGN KEY (id_production) REFERENCES production (id_production)
            ON UPDATE CASCADE ON DELETE CASCADE,
    ADD CONSTRAINT order_dealer_id_dealer_fk
        FOREIGN KEY (id_dealer) REFERENCES dealer (id_dealer)
            ON UPDATE CASCADE ON DELETE CASCADE,
    ADD CONSTRAINT order_pharmacy_id_pharmacy_fk
        FOREIGN KEY (id_pharmacy) REFERENCES pharmacy (id_pharmacy)
            ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE production
    ADD CONSTRAINT production_company_id_company_fk
        FOREIGN KEY (id_company) REFERENCES company (id_company)
            ON UPDATE CASCADE ON DELETE CASCADE,
    ADD CONSTRAINT production_medicine_id_medicine_fk
        FOREIGN KEY (id_medicine) REFERENCES medicine (id_medicine)
            ON UPDATE CASCADE ON DELETE CASCADE;


-- 2. Выдать информацию по всем заказам лекарства “Кордерон” компании “Аргус” с указанием названий аптек, дат, объема заказов.
SELECT ph.name AS pharmacy_name, o.date AS order_date, o.quantity AS order_quantity
FROM `order` o
         INNER JOIN pharmacy ph ON o.id_pharmacy = ph.id_pharmacy
         INNER JOIN production p ON o.id_production = p.id_production
         INNER JOIN company c ON p.id_company = c.id_company AND c.name = 'Аргус'
         INNER JOIN medicine m ON p.id_medicine = m.id_medicine AND m.name = 'Кордеон';


-- 3. Дать список лекарств компании “Фарма”, на которые не были сделаны заказы до 25 января
SELECT m.name
FROM medicine m
         INNER JOIN production p2 ON m.id_medicine = p2.id_medicine
         INNER JOIN company c2 ON p2.id_company = c2.id_company AND c2.name = 'Фарма'
WHERE m.id_medicine NOT IN
      (SELECT m.id_medicine
       FROM medicine m
                INNER JOIN production p ON m.id_medicine = p.id_medicine
                INNER JOIN company c ON p.id_company = c.id_company AND c.name = 'Фарма'
                INNER JOIN `order` o ON p.id_production = o.id_production AND o.date < '2019-01-25');


-- 4. Дать минимальный и максимальный баллы лекарств каждой фирмы, которая оформила не менее 120 заказов.
SELECT c.name AS company_name, MIN(p2.rating) AS min_rating, MAX(p2.rating) AS max_rating
FROM company c
         INNER JOIN production p2 ON c.id_company = p2.id_company
WHERE c.id_company IN
      (SELECT c.id_company
       FROM company c
                INNER JOIN production p ON c.id_company = p.id_company
                INNER JOIN `order` o ON p.id_production = o.id_production
       GROUP BY c.id_company
       HAVING COUNT(o.id_order) >= 120)
GROUP BY c.name;


-- 5. Дать списки сделавших заказы аптек по всем дилерам компании “AstraZeneca”. Если у дилера нет заказов, в названии аптеки проставить NULL.
SELECT d.name AS dealer_name, ph.name AS pharmacy_name
FROM dealer d
         INNER JOIN company c ON d.id_company = c.id_company AND c.name = 'AstraZeneca'
         LEFT JOIN `order` o ON d.id_dealer = o.id_dealer
         LEFT JOIN pharmacy ph ON o.id_pharmacy = ph.id_pharmacy;


-- 6. Уменьшить на 20% стоимость всех лекарств, если она превышает 3000, а длительность лечения не более 7 дней.
UPDATE medicine m
    INNER JOIN production p ON m.id_medicine = p.id_medicine
SET p.price = 0.8 * p.price
WHERE p.price > 3000
  AND m.cure_duration <= 7;

SELECT m.name, c.name
FROM medicine m
         INNER JOIN production p ON m.id_medicine = p.id_medicine
         INNER JOIN company c ON p.id_company = c.id_company
WHERE p.price > 3000
  AND m.cure_duration <= 7;


-- 7. Добавить необходимые индексы.
-- Для запросов: 2, 3, 5
ALTER TABLE company
    ADD INDEX company_name_idx (name);

-- Для запросов: 2, 6
ALTER TABLE medicine
    ADD INDEX medicine_cure_duration_idx (cure_duration),
    ADD INDEX medicine_name_idx (name);

-- Для запроса 6
ALTER TABLE production
    ADD INDEX production_price_idx (price);

-- Для запроса 3
ALTER TABLE `order`
    ADD INDEX order_date_idx (date);
