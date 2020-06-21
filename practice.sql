-- SQLite

DROP TABLE IF EXISTS students;

CREATE TABLE students(
  roll_no NUMERIC(5) NOT NULL UNIQUE,
  name VARCHAR(30) NOT NULL DEFAULT 'no name specified',
  mark_1 NUMERIC(3),
  mark_2 NUMERIC(3),
  mark_3 NUMERIC(3),
  total NUMERIC(3)
);

INSERT INTO students (roll_no,name,mark_1,mark_2,mark_3)
  VALUES(1,'deepika',56,67,84);
INSERT INTO students (roll_no,name,mark_1,mark_2,mark_3)
  VALUES(2,'deepu',65,76,48),(3,'something',46,57,34);

INSERT INTO students (roll_no,mark_1,mark_2,mark_3)
  VALUES(4,56,56,94);

UPDATE students
  SET total = mark_1 + mark_2 + mark_3;

SELECT * FROM students;

SELECT * FROM students
  WHERE total >= 200;

SELECT * FROM students
  WHERE total > 0
  ORDER BY total DESC;

CREATE VIEW students_view as
 SELECT name,roll_no
  FROM students;

SELECT * FROM students_view;