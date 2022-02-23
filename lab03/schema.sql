/* 12. Издательства, магазины, книги */

CREATE DATABASE IF NOT EXISTS lab03_1;
USE lab03_1;

CREATE TABLE IF NOT EXISTS author
(
    id_author   INT UNSIGNED AUTO_INCREMENT
        PRIMARY KEY,
    first_name  VARCHAR(255) NOT NULL,
    second_name VARCHAR(255) NOT NULL,
    birth_date  DATE         NOT NULL
);

CREATE TABLE IF NOT EXISTS book
(
    id_book  INT UNSIGNED AUTO_INCREMENT
        PRIMARY KEY,
    title    VARCHAR(255) NOT NULL,
    subtitle VARCHAR(255) NOT NULL,
    year     YEAR         NOT NULL
);

CREATE TABLE IF NOT EXISTS book_has_author
(
    id_book   INT UNSIGNED NOT NULL,
    id_author INT UNSIGNED NOT NULL,
    PRIMARY KEY (id_book, id_author),
    CONSTRAINT book_has_author_author_id_author_fk
        FOREIGN KEY (id_author) REFERENCES author (id_author)
            ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT book_has_author_book_id_book_fk
        FOREIGN KEY (id_book) REFERENCES book (id_book)
            ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS publisher
(
    id_publisher   INT UNSIGNED AUTO_INCREMENT
        PRIMARY KEY,
    name           VARCHAR(255) NOT NULL,
    city           VARCHAR(511) NOT NULL,
    license_number INT UNSIGNED NOT NULL
);

CREATE TABLE IF NOT EXISTS edition
(
    id_edition   INT UNSIGNED AUTO_INCREMENT
        PRIMARY KEY,
    id_book      INT UNSIGNED NOT NULL,
    id_publisher INT UNSIGNED NOT NULL,
    year         YEAR         NOT NULL,
    isbn         VARCHAR(13)  NOT NULL,
    CONSTRAINT edition_book_id_book_fk
        FOREIGN KEY (id_book) REFERENCES book (id_book)
            ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT edition_publisher_id_publisher_fk
        FOREIGN KEY (id_publisher) REFERENCES publisher (id_publisher)
            ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS store
(
    id_store       INT UNSIGNED AUTO_INCREMENT
        PRIMARY KEY,
    name           VARCHAR(255) NOT NULL,
    address        VARCHAR(511) NOT NULL,
    license_number INT UNSIGNED NOT NULL
);

CREATE TABLE IF NOT EXISTS store_has_edition
(
    id_store   INT UNSIGNED NOT NULL,
    id_edition INT UNSIGNED NOT NULL,
    PRIMARY KEY (id_store, id_edition),
    CONSTRAINT store_has_edition_edition_id_edition_fk
        FOREIGN KEY (id_edition) REFERENCES edition (id_edition)
            ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT store_has_edition_store_id_store_fk
        FOREIGN KEY (id_store) REFERENCES store (id_store)
            ON UPDATE CASCADE ON DELETE CASCADE
);

/* 13. Прививки, дети, сделанные прививки */

CREATE DATABASE IF NOT EXISTS lab03_2;
USE lab03_2;

