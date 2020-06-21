-- SQLite

-- Provide roll_no, city, score, bonus("N/A" if not available) and total(count bonus as 0 if not available)

SELECT tab1.roll_no, tab1.city as city, tab1.score,
       IFNULL(tab2.bonus_score, 'N/A') as bonus_score, 
       (tab1.score + IFNULL(tab2.bonus_score, 0)) as total
  FROM entrance_exam_results tab1
  LEFT JOIN city_bonus_points tab2
  ON tab1.city = tab2.city;

-- Provide roll_no, city, bonus of students whose city's bonus point is more than or equal to 10 (consider null as 0)

SELECT tab1.roll_no, tab1.city, tab2.bonus_score
  FROM entrance_exam_results tab1
  LEFT JOIN city_bonus_points tab2
  ON tab1.city = tab2.city
     WHERE tab2.bonus_score >= 10;

-- Provide name of cities which doesn't have any candidate ('= NULL' will not work, use 'IS NULL')

SELECT tab1.city
    FROM city_bonus_points tab1
  LEFT JOIN entrance_exam_results tab2
  ON tab1.city = tab2.city
  WHERE tab2.city IS NULL;

-- Sort cities(present in tbl2) with candidate count based on their candidate count in descending order

SELECT tab1.city,
       count(tab2.city) as candidate_count
  FROM city_bonus_points tab1
  LEFT JOIN entrance_exam_results tab2
  ON tab1.city == tab2.city
  GROUP BY tab1.city
  ORDER BY candidate_count;

-- Show total score of each city(which has minimum 1 candidate)(sort them on descending order by total)(if city name is not present for a student it will be considered as 'OTHER CITIES')

WITH students as (
    SELECT IFNULL(tab2.city, "Other Cities") as city,
    IFNULL(tab1.score, 0) + IFNULL(tab2.bonus_score, 0) as total
  FROM entrance_exam_results tab1
  LEFT JOIN city_bonus_points tab2
  ON tab1.city == tab2.city
)

  SELECT city,
         sum(total) as city_total
      FROM students
    GROUP BY city
    ORDER BY city_total DESC;

-- Rank cities based on their city total(same clauses as the last one)

WITH students as (
    SELECT IFNULL(tab2.city, "Other Cities") as city,
    IFNULL(tab1.score, 0) + IFNULL(tab2.bonus_score, 0) as total
  FROM entrance_exam_results tab1
  LEFT JOIN city_bonus_points tab2
  ON tab1.city == tab2.city
)

  SELECT city,
         sum(total) as city_total,
         dense_rank() over (ORDER BY sum(total) DESC) as city_rank
      FROM students
    GROUP BY city
    ORDER BY city_total DESC;