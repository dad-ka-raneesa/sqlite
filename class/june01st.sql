-- SQLite
/* WORKBOOK
 * Classroom 4
*/


DROP TABLE IF EXISTS student_exercise_2; 
CREATE TABLE  student_exercise_2 (

roll_no  NUMERIC(5)  NOT NULL UNIQUE,
dept     VARCHAR(5),
name     VARCHAR(30) NOT NULL DEFAULT 'No Name Defined',
mark_1   NUMERIC(3),
mark_2   NUMERIC(3),
mark_3   NUMERIC(3)
);

-- populate values
INSERT INTO student_exercise_2 (roll_no, dept, name, mark_1, mark_2, mark_3) VALUES
( 1, 'CSE',   'AB', 49,   67,     90),
( 2, 'CSE',   'AB', 95,   70,     100),
( 3, 'CSE',   'BB', 55,   100,    91),
( 4, 'CSE',   'CA', 100,  100,    100),
( 5, 'CSE',   'DD', 100,  89,     83),
( 6, 'EEE',   'AD', 87,   67,     97),
( 7, 'EEE',   'AE', 35,   87,     86),
( 8, 'EEE',   'AF', 67,   74,     93),
( 9, 'EEE',   'AG', 58,   71,     59),
( 10,'EEE',   'AH', 49,   71,     76),
( 11, 'IT',  'AI', 100,   86,    91),
( 12, 'IT',  'AJ', 66,   57,     100),
( 13, 'IT',  'AK', 87,   63,     80),
( 14, 'IT',  'B2', 74,   69,     84),
( 15, 'MECH',  'B4', 40,  100,     87),
( 16, 'MECH',  'B6', 93,   85,     73),
( 17, 'MECH',  'C8', 100,  91,     35),
( 18, 'MECH',  'A6', 38,   59,     90),
( 19, 'CSE',  'AB', 57,   74,     90),
( 20, 'CSE',  'A*', 71,   81,     90),
( 21, 'CSE',  'YY', 0,     0,     NULL)
;

select * from student_exercise_2;

--aggregate fucntions

SELECT count(*)
  FROM student_exercise_2;


SELECT min(mark_1) min_marks,
       max(mark_1) max_marks
  FROM student_exercise_2;

-- AVG without GROUP BY
SELECT avg(mark_1)
  FROM student_exercise_2;

-- AVG with GROUP BY

SELECT dept, ROUND(avg(mark_1), 2) as mark_1_avg
  FROM student_exercise_2
 GROUP by dept;

--assuming pass score is 40

--show avg of each subject - where someone has scored a pass mark. Also show number of students passed

SELECT dept,
   count(mark_1) as mark_1_count,
   round(avg(mark_1),2) as mark_1_avg
  FROM student_exercise_2
 WHERE mark_1 >= 40
 GROUP BY dept;

--show avg total for each department - for students who scored pass in all three subjects

WITH students as 
(
    SELECT name, roll_no, mark_1, mark_2, mark_3, 
    (mark_1 + mark_2 + mark_3) as total,
    dept as department
       FROM student_exercise_2
)

SELECT department, avg(total)
  FROM students
  WHERE(mark_1 >= 40 AND mark_2 >= 40 AND mark_3 >= 40)
 GROUP BY department
 ORDER BY department DESC
;

--find name of students who scored more than the class average mark_1

SELECT name
  FROM student_exercise_2
 WHERE mark_1 > 
   (
    SELECT avg(mark_1)
    FROM student_exercise_2);
-- SUb query

WITH students as
(
   SELECT name, roll_no, mark_1, mark_2, mark_3,
   (mark_1 + mark_2 + mark_3)  as total,
   dept as department
      FROM student_exercise_2
),
overall_averages as (
    SELECT avg(mark_1) as mark_1_avg,
    avg(mark_2) as mark_2_avg,
    avg(mark_3) as mark_3_avg,
    avg(total) as avg_total
      FROM students
)
SELECT name
  FROM students
 WHERE total >= (SELECT avg_total FROM overall_averages);

--find name, department, roll_no, total of students who scored more than the department avg for mark_1


SELECT name, dept, roll_no,
       (mark_1 + mark_2 + mark_3)  as total
  FROM student_exercise_2
 WHERE mark_1 > (SELECT avg(mark_1) FROM student_exercise_2 GROUP BY dept);

--window fucntions (analytical functions)

SELECT roll_no, name, dept, mark_1,
       avg(mark_1) OVER () as overall,
       avg(mark_1) OVER (PARTITION BY dept) as dept_avg,
       RANK() OVER(ORDER BY mark_1 DESC) as rank_overall,
       DENSE_RANK() OVER(ORDER BY mark_1 DESC) as rank_overall_2
  FROM student_exercise_2;

-- Provide details of all students and their rank in their departments


SELECT name, roll_no, dept,
       (mark_1 + mark_2 + mark_3) as total,
       DENSE_RANK() OVER(PARTITION BY dept ORDER BY (mark_1 + mark_2 + mark_3) DESC) as rank
  FROM student_exercise_2;