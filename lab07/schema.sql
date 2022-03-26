CREATE DATABASE IF NOT EXISTS lab07;
USE lab07;

CREATE TABLE IF NOT EXISTS `group`
(
    id_group INT UNSIGNED AUTO_INCREMENT
        PRIMARY KEY,
    name     VARCHAR(10) NOT NULL
);

CREATE TABLE IF NOT EXISTS student
(
    id_student INT UNSIGNED AUTO_INCREMENT
        PRIMARY KEY,
    name       VARCHAR(255) NOT NULL,
    phone      VARCHAR(50)  NOT NULL,
    id_group   INT UNSIGNED NOT NULL,
    CONSTRAINT student_group_id_group_fk
        FOREIGN KEY (id_group) REFERENCES `group` (id_group)
            ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS subject
(
    id_subject INT UNSIGNED AUTO_INCREMENT
        PRIMARY KEY,
    name       VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS teacher
(
    id_teacher INT UNSIGNED AUTO_INCREMENT
        PRIMARY KEY,
    name       VARCHAR(255) NOT NULL,
    phone      VARCHAR(50)  NOT NULL
);

CREATE TABLE IF NOT EXISTS lesson
(
    id_lesson  INT UNSIGNED AUTO_INCREMENT
        PRIMARY KEY,
    id_teacher INT UNSIGNED NOT NULL,
    id_subject INT UNSIGNED NOT NULL,
    id_group   INT UNSIGNED NOT NULL,
    date       DATE         NOT NULL,
    CONSTRAINT lesson_group_id_group_fk
        FOREIGN KEY (id_group) REFERENCES `group` (id_group)
            ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT lesson_subject_id_subject_fk
        FOREIGN KEY (id_subject) REFERENCES subject (id_subject)
            ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT lesson_teacher_id_teacher_fk
        FOREIGN KEY (id_teacher) REFERENCES teacher (id_teacher)
            ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS mark
(
    id_mark    INT UNSIGNED AUTO_INCREMENT
        PRIMARY KEY,
    id_lesson  INT UNSIGNED NOT NULL,
    id_student INT UNSIGNED NOT NULL,
    mark       TINYINT      NOT NULL,
    CONSTRAINT mark_lesson_id_lesson_fk
        FOREIGN KEY (id_lesson) REFERENCES lesson (id_lesson)
            ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT mark_student_id_student_fk
        FOREIGN KEY (id_student) REFERENCES student (id_student)
            ON UPDATE CASCADE ON DELETE CASCADE
);
