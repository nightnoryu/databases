USE lab05;


-- 1. Добавить внешние ключи.
ALTER TABLE booking
    ADD CONSTRAINT booking_client_id_client_fk
        FOREIGN KEY (id_client) REFERENCES client (id_client)
            ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE room
    ADD CONSTRAINT room_hotel_id_hotel_fk
        FOREIGN KEY (id_hotel) REFERENCES hotel (id_hotel)
            ON UPDATE CASCADE ON DELETE CASCADE,
    ADD CONSTRAINT room_room_category_id_room_category_fk
        FOREIGN KEY (id_room_category) REFERENCES room_category (id_room_category)
            ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE room_in_booking
    ADD CONSTRAINT room_in_booking_booking_id_booking_fk
        FOREIGN KEY (id_booking) REFERENCES booking (id_booking)
            ON UPDATE CASCADE ON DELETE CASCADE,
    ADD CONSTRAINT room_in_booking_room_id_room_fk
        FOREIGN KEY (id_room) REFERENCES room (id_room)
            ON UPDATE CASCADE ON DELETE CASCADE;


-- 2. Выдать информацию о клиентах гостиницы “Космос”, проживающих в номерах категории “Люкс” на 1 апреля 2019г.
SELECT c.name, c.phone
FROM client c
         INNER JOIN booking b ON c.id_client = b.id_client
         INNER JOIN room_in_booking rib
                    ON b.id_booking = rib.id_booking AND '2019-04-01' BETWEEN rib.checkin_date AND rib.checkout_date
         INNER JOIN room r ON rib.id_room = r.id_room
         INNER JOIN hotel h ON r.id_hotel = h.id_hotel AND h.name = 'Космос'
         INNER JOIN room_category rc ON r.id_room_category = rc.id_room_category AND rc.name = 'Люкс';


-- 3. Дать список свободных номеров всех гостиниц на 22 апреля.
-- TODO: duplicated rows
SELECT h.name, r.number, r.price, rc.name
FROM room r
         INNER JOIN room_in_booking rib
                    ON r.id_room = rib.id_room AND NOT ('2019-04-22' BETWEEN rib.checkin_date AND rib.checkout_date)
         INNER JOIN hotel h ON r.id_hotel = h.id_hotel
         INNER JOIN room_category rc ON r.id_room_category = rc.id_room_category;


-- 4. Дать количество проживающих в гостинице “Космос” на 23 марта по каждой категории номеров
SELECT rc.name, COUNT(c.id_client) AS residents_amount
FROM client c
         INNER JOIN booking b ON c.id_client = b.id_client
         INNER JOIN room_in_booking rib
                    ON b.id_booking = rib.id_booking AND '2019-03-23' BETWEEN rib.checkin_date AND rib.checkout_date
         INNER JOIN room r ON rib.id_room = r.id_room
         INNER JOIN room_category rc ON r.id_room_category = rc.id_room_category
         INNER JOIN hotel h ON r.id_hotel = h.id_hotel AND h.name = 'Космос'
GROUP BY rc.name;


-- 5. Дать список последних проживавших клиентов по всем комнатам гостиницы “Космос”,
-- выехавшим в апреле с указанием даты выезда.
-- TODO


-- 6. Продлить на 2 дня дату проживания в гостинице “Космос” всем клиентам комнат
-- категории “Бизнес”, которые заселились 10 мая.
UPDATE client c
    INNER JOIN booking b ON c.id_client = b.id_client
    INNER JOIN room_in_booking rib ON b.id_booking = rib.id_booking AND rib.checkin_date = '2019-05-10'
    INNER JOIN room r ON rib.id_room = r.id_room
    INNER JOIN hotel h ON r.id_hotel = h.id_hotel AND h.name = 'Космос'
    INNER JOIN room_category rc ON r.id_room_category = rc.id_room_category AND rc.name = 'Бизнес'
SET rib.checkout_date = DATE_ADD(rib.checkout_date, INTERVAL 2 DAY);

SELECT c.name, rib.checkout_date
FROM client c
         INNER JOIN booking b ON c.id_client = b.id_client
         INNER JOIN room_in_booking rib ON b.id_booking = rib.id_booking AND rib.checkin_date = '2019-05-10'
         INNER JOIN room r ON rib.id_room = r.id_room
         INNER JOIN hotel h ON r.id_hotel = h.id_hotel AND h.name = 'Космос'
         INNER JOIN room_category rc ON r.id_room_category = rc.id_room_category AND rc.name = 'Бизнес';


-- 7. Найти все "пересекающиеся" варианты проживания. Правильное состояние: не
-- может быть забронирован один номер на одну дату несколько раз, т.к. нельзя
-- заселиться нескольким клиентам в один номер. Записи в таблице
-- room_in_booking с id_room_in_booking = 5 и 2154 являются примером
-- неправильного состояния, которые необходимо найти. Результирующий кортеж
-- выборки должен содержать информацию о двух конфликтующих номерах.
-- TODO


-- 8. Создать бронирование в транзакции.
-- TODO


-- 9. Добавить необходимые индексы для всех таблиц.
ALTER TABLE booking
    ADD INDEX booking_id_client_idx (id_client);

ALTER TABLE room_in_booking
    ADD INDEX room_in_booking_id_booking_id_room_idx (id_booking, id_room);

ALTER TABLE room
    ADD INDEX room_id_hotel_id_room_category_idx (id_hotel, id_room_category);
