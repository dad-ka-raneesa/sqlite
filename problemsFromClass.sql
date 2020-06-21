-- SQLite
-- provide pass and fail count of whole class
WITH students as (
  SELECT
    name,
    CASE
      WHEN mark_1 >= 40
      AND mark_2 >= 40
      AND mark_3 >= 40 THEN 'Pass'
      ELSE 'Fail'
    END as result
  FROM
    student_exercise_2
)
SELECT
  count(name) as count,
  result
FROM
  students
GROUP BY
  result;

--provide pass count per department
WITH students as (
  SELECT
    name,
    dept,
    CASE
      WHEN mark_1 >= 40
      AND mark_2 >= 40
      AND mark_3 >= 40 THEN 'Pass'
      ELSE 'Fail'
    END as result
  FROM
    student_exercise_2
)
SELECT
  dept,
  count(name) as pass
FROM
  students
WHERE
  result == 'Pass'
GROUP BY
  dept;

-- Provide pass and fail count for each department
WITH students as (
  SELECT
    name,
    dept,
    CASE
      WHEN mark_1 >= 40
      AND mark_2 >= 40
      AND mark_3 >= 40 THEN 'Pass'
      ELSE NULL
    END as pass
  FROM
    student_exercise_2
)
SELECT
  dept,
  count(pass) as pass,
  count() - count(pass) as fail
FROM
  students
GROUP BY
  dept;

-- provide the count of students who scored above avg per department.
WITH students as (
  SELECT
    name,
    roll_no,
    mark_1,
    mark_2,
    mark_3,
    (mark_1 + mark_2 + mark_3) as total,
    dept as department
  FROM
    student_exercise_2
),
overall_averages as (
  SELECT
    avg(mark_1) as mark_1_avg,
    avg(mark_2) as mark_2_avg,
    avg(mark_3) as mark_3_avg,
    avg(total) as avg_total
  FROM
    students
)
SELECT
  department,
  count(name)
FROM
  students
WHERE
  total >= (
    SELECT
      avg_total
    FROM
      overall_averages
  )
GROUP BY
  department;