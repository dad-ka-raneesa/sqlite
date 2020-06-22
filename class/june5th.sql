-- SQLite


drop table if exists entrance_exam_results;
create table entrance_exam_results
(
    roll_no NUMBER(5) PRIMARY KEY,
    city  VARCHAR(10) ,
    score  NUMBER(3) NOT NULL
);

insert into entrance_exam_results  VALUES
(1, 'BENGALURU', 90),
(2, 'DELHI', 67),
(3, 'DELHI', 87),
(4, 'BENGALURU', 76),
(5, 'PUNE', 89),
(6, NULL, 91 ),
(7, 'CHENNAI', 77),
(8, 'HYDERABAD', 80)
;

drop table if exists city_bonus_points;

create table city_bonus_points
(
    city VARCHAR(10),
    bonus_score  NUMBER(2)

);

insert into city_bonus_points VALUES
( 'BENGALURU', 10 ),
( 'DELHI', 9),
( 'PUNE', 11),
( 'CHENNAI', 10 ),
( 'COIMBATORE', 12 ),
( 'NAGPUR', 13 ),
( 'Nagpur', 13 )
;

SELECT * FROM city_bonus_points;

SELECT * FROM entrance_exam_results;

--cartesian product aka CROSS JOIN
SELECT * 
  FROM entrance_exam_results, city_bonus_points;

SELECT a.roll_no, a.city, b.city,
    CASE WHEN a.city == b.city THEN 'MATCH' ELSE '-' END as match
  FROM entrance_exam_results a, city_bonus_points b;

SELECT * 
  FROM entrance_exam_results
  CROSS JOIN city_bonus_points;

-- INNER JOIN

SELECT tab1.roll_no, tab1.city as tab1_city, tab1.score,
       tab2.bonus_score, (tab1.score + tab2.bonus_score) as total
  FROM entrance_exam_results tab1
  JOIN city_bonus_points tab2
  ON tab1.city = tab2.city;

-- INNER JOIN (EQUI JOIN) with condition

SELECT tab1.roll_no, tab1.city as tab1_city, tab1.score,
       tab2.city as tab2_city, tab2.bonus_score, (tab1.score + tab2.bonus_score) as total
  FROM entrance_exam_results tab1
  JOIN city_bonus_points tab2
  ON tab1.city = tab2.city
 WHERE tab1.roll_no = 1;

-- LEFT OUTER JOIN with a condition

SELECT tab1.roll_no, tab1.city as tab1_city, tab1.score,
       tab2.city as tab2_city, tab2.bonus_score, (tab1.score + tab2.bonus_score) as total
  FROM entrance_exam_results tab1
  LEFT JOIN city_bonus_points tab2
  ON tab1.city = tab2.city;

-- LEFT OUTER JOIN with city on left

SELECT tab1.roll_no, tab1.city as tab1_city, tab1.score,
       tab2.city as tab2_city, tab2.bonus_score, (tab1.score + tab2.bonus_score) as total
  FROM city_bonus_points tab2
  LEFT JOIN entrance_exam_results tab1
  ON tab1.city = tab2.city;


-- SELF JOIN

CREATE TABLE EXP(
id NUMBER(10) );

INSERT INTO exp VALUES (1), (2), (3);

SELECT * FROM exp;

SELECT t1.id, t2.id  FROM exp t1, exp t2;