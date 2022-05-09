CREATE DATABASE IF NOT EXISTS lab06;
USE lab06;

CREATE TABLE IF NOT EXISTS company
(
    id_company  INT UNSIGNED AUTO_INCREMENT
        PRIMARY KEY,
    name        VARCHAR(255) NOT NULL,
    established YEAR         NOT NULL
);

CREATE TABLE IF NOT EXISTS dealer
(
    id_dealer  INT UNSIGNED AUTO_INCREMENT
        PRIMARY KEY,
    id_company INT UNSIGNED NOT NULL,
    name       VARCHAR(511) NOT NULL,
    phone      VARCHAR(30)  NOT NULL,
    CONSTRAINT dealer_company_id_company_fk
        FOREIGN KEY (id_company) REFERENCES company (id_company)
            ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS medicine
(
    id_medicine   INT UNSIGNED AUTO_INCREMENT
        PRIMARY KEY,
    name          VARCHAR(255) NOT NULL,
    cure_duration INT UNSIGNED NOT NULL
);

CREATE TABLE IF NOT EXISTS pharmacy
(
    id_pharmacy INT UNSIGNED AUTO_INCREMENT
        PRIMARY KEY,
    name        VARCHAR(255)     NOT NULL,
    rating      TINYINT UNSIGNED NOT NULL
);

CREATE TABLE IF NOT EXISTS production
(
    id_production INT UNSIGNED AUTO_INCREMENT
        PRIMARY KEY,
    id_company    INT UNSIGNED     NOT NULL,
    id_medicine   INT UNSIGNED     NOT NULL,
    price         DECIMAL(15, 2)   NOT NULL,
    rating        TINYINT UNSIGNED NOT NULL,
    CONSTRAINT production_company_id_company_fk
        FOREIGN KEY (id_company) REFERENCES company (id_company)
            ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT production_medicine_id_medicine_fk
        FOREIGN KEY (id_medicine) REFERENCES medicine (id_medicine)
            ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS `order`
(
    id_order      INT UNSIGNED AUTO_INCREMENT
        PRIMARY KEY,
    id_production INT UNSIGNED NOT NULL,
    id_dealer     INT UNSIGNED NOT NULL,
    id_pharmacy   INT UNSIGNED NOT NULL,
    date          DATE         NULL,
    quantity      INT UNSIGNED NOT NULL,
    CONSTRAINT order_dealer_id_dealer_fk
        FOREIGN KEY (id_dealer) REFERENCES dealer (id_dealer)
            ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT order_pharmacy_id_pharmacy_fk
        FOREIGN KEY (id_pharmacy) REFERENCES pharmacy (id_pharmacy)
            ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT order_production_id_production_fk
        FOREIGN KEY (id_production) REFERENCES production (id_production)
            ON UPDATE CASCADE ON DELETE CASCADE
);
