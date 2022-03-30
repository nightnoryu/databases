USE lab07;


-- 1. Добавить внешние ключи.
ALTER TABLE lesson
    ADD CONSTRAINT lesson_teacher_id_teacher_fk
        FOREIGN KEY (id_teacher) REFERENCES teacher (id_teacher)
            ON UPDATE CASCADE ON DELETE CASCADE,
    ADD CONSTRAINT lesson_subject_id_subject_fk
        FOREIGN KEY (id_subject) REFERENCES subject (id_subject)
            ON UPDATE CASCADE ON DELETE CASCADE,
    ADD CONSTRAINT lesson_group_id_group_fk
        FOREIGN KEY (id_group) REFERENCES `group` (id_group)
            ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE mark
    ADD CONSTRAINT mark_lesson_id_lesson_fk
        FOREIGN KEY (id_lesson) REFERENCES lesson (id_lesson)
            ON UPDATE CASCADE ON DELETE CASCADE,
    ADD CONSTRAINT mark_student_id_student_fk
        FOREIGN KEY (id_student) REFERENCES student (id_student)
            ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE student
    ADD CONSTRAINT student_group_id_group_fk
        FOREIGN KEY (id_group) REFERENCES `group` (id_group)
            ON UPDATE CASCADE ON DELETE CASCADE;


-- 2. Выдать оценки студентов по информатике если они обучаются данному
-- предмету. Оформить выдачу данных с использованием view.
DROP VIEW IF EXISTS informatics_marks;

CREATE VIEW informatics_marks AS
SELECT st.name AS student_name, m.mark AS mark
FROM student st
         INNER JOIN mark m ON st.id_student = m.id_student
         INNER JOIN lesson l ON m.id_lesson = l.id_lesson
         INNER JOIN subject sj ON l.id_subject = sj.id_subject AND sj.name = 'Информатика'
ORDER BY 1;

SELECT *
FROM informatics_marks;


-- 3. Дать информацию о должниках с указанием фамилии студента и названия
-- предмета. Должниками считаются студенты, не имеющие оценки по предмету,
-- который ведется в группе. Оформить в виде процедуры, на входе
-- идентификатор группы.
DROP PROCEDURE IF EXISTS get_dummy_students;

CREATE PROCEDURE get_dummy_students(IN group_name VARCHAR(10))
BEGIN
    SELECT DISTINCT st.name, sj.name
    FROM student st
             INNER JOIN `group` g ON st.id_group = g.id_group AND g.name = group_name
             INNER JOIN lesson l ON g.id_group = l.id_group
             INNER JOIN subject sj ON l.id_subject = sj.id_subject
             LEFT JOIN mark m ON st.id_student = m.id_student AND l.id_lesson = m.id_lesson
    WHERE m.id_mark IS NULL;
END;

CALL get_dummy_students('ПС');


-- 4. Дать среднюю оценку студентов по каждому предмету для тех предметов, по
-- которым занимается не менее 35 студентов.
WITH required_subject (id_subject, name)
         AS
         (
             SELECT sj.id_subject, sj.name
             FROM subject sj
                      INNER JOIN lesson l ON sj.id_subject = l.id_subject
                      INNER JOIN student st ON l.id_group = st.id_group
             GROUP BY 1
             HAVING COUNT(DISTINCT st.id_student) > 35
         )
SELECT st.name AS student, sj.name AS subject, ROUND(AVG(m.mark), 2) AS average_mark
FROM required_subject sj
         INNER JOIN lesson l ON sj.id_subject = l.id_subject
         INNER JOIN `group` g ON l.id_group = g.id_group
         INNER JOIN student st ON g.id_group = st.id_group
         INNER JOIN mark m ON l.id_lesson = m.id_lesson AND st.id_student = m.id_student
GROUP BY sj.name, st.name
ORDER BY 1;


-- 5. Дать оценки студентов специальности ВМ по всем проводимым предметам с
-- указанием группы, фамилии, предмета, даты. При отсутствии оценки заполнить
-- значениями NULL поля оценки.
SELECT st.name AS student, sj.name AS subject, l.date AS date, m.mark AS mark
FROM student st
         INNER JOIN `group` g ON st.id_group = g.id_group AND g.name = 'ВМ'
         LEFT JOIN mark m ON st.id_student = m.id_student
         LEFT JOIN lesson l ON m.id_lesson = l.id_lesson AND g.id_group = l.id_group
         LEFT JOIN subject sj ON l.id_subject = sj.id_subject
ORDER BY 1;


-- 6. Всем студентам специальности ПС, получившим оценки меньшие 5 по предмету
-- БД до 12.05, повысить эти оценки на 1 балл.
UPDATE mark m
    INNER JOIN lesson l ON m.id_lesson = l.id_lesson AND l.date < '2019-05-12'
    INNER JOIN subject s ON l.id_subject = s.id_subject AND s.name = 'БД'
    INNER JOIN `group` g ON l.id_group = g.id_group AND g.name = 'ПС'
SET m.mark = m.mark - 1;

SELECT st.name, m.mark, l.date
FROM mark m
         INNER JOIN lesson l ON m.id_lesson = l.id_lesson AND l.date < '2019-05-12'
         INNER JOIN subject sj ON l.id_subject = sj.id_subject AND sj.name = 'БД'
         INNER JOIN student st ON m.id_student = st.id_student
         INNER JOIN `group` g ON l.id_group = g.id_group AND g.name = 'ПС'
WHERE m.mark < 5;


-- 7. Добавить необходимые индексы.
-- Запросы: 5, 6
ALTER TABLE `group`
    ADD INDEX group_name_idx (name);

-- Запросы: 6
ALTER TABLE lesson
    ADD INDEX lesson_date_idx (date);

-- Запросы: 2, 6
ALTER TABLE subject
    ADD INDEX subject_name_idx (name);
