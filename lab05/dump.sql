CREATE DATABASE IF NOT EXISTS lab05;
USE lab05;

CREATE TABLE IF NOT EXISTS client
(
    id_client INT UNSIGNED AUTO_INCREMENT
        PRIMARY KEY,
    name      VARCHAR(511) NOT NULL,
    phone     VARCHAR(30)  NOT NULL
);

CREATE TABLE IF NOT EXISTS booking
(
    id_booking   INT UNSIGNED AUTO_INCREMENT
        PRIMARY KEY,
    id_client    INT UNSIGNED NOT NULL,
    booking_date DATE         NOT NULL,
    CONSTRAINT booking_client_id_client_fk
        FOREIGN KEY (id_client) REFERENCES client (id_client)
            ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS hotel
(
    id_hotel INT UNSIGNED AUTO_INCREMENT
        PRIMARY KEY,
    name     VARCHAR(255) NOT NULL,
    stars    TINYINT(1)   NOT NULL
);

CREATE TABLE IF NOT EXISTS room_category
(
    id_room_category INT UNSIGNED AUTO_INCREMENT
        PRIMARY KEY,
    name             VARCHAR(255) NOT NULL,
    square           INT UNSIGNED NOT NULL
);

CREATE TABLE IF NOT EXISTS room
(
    id_room          INT UNSIGNED AUTO_INCREMENT
        PRIMARY KEY,
    id_hotel         INT UNSIGNED   NOT NULL,
    id_room_category INT UNSIGNED   NOT NULL,
    number           INT UNSIGNED   NOT NULL,
    price            DECIMAL(15, 2) NOT NULL,
    CONSTRAINT room_hotel_id_hotel_fk
        FOREIGN KEY (id_hotel) REFERENCES hotel (id_hotel)
            ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT room_room_category_id_room_category_fk
        FOREIGN KEY (id_room_category) REFERENCES room_category (id_room_category)
            ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS room_in_booking
(
    id_room_in_booking INT UNSIGNED AUTO_INCREMENT
        PRIMARY KEY,
    id_booking         INT UNSIGNED NOT NULL,
    id_room            INT UNSIGNED NOT NULL,
    checkin_date       DATE         NOT NULL,
    checkout_date      DATE         NOT NULL,
    CONSTRAINT room_in_booking_booking_id_booking_fk
        FOREIGN KEY (id_booking) REFERENCES booking (id_booking)
            ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT room_in_booking_room_id_room_fk
        FOREIGN KEY (id_room) REFERENCES room (id_room)
            ON UPDATE CASCADE ON DELETE CASCADE
);
