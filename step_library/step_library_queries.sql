SELECT * FROM book_titles;
SELECT * FROM book_copies;
SELECT * FROM library_log;

-- List all the book's title, author name and necessary details which is in the library.

SELECT * FROM book_titles;

-- Find all books who has only one writer.

SELECT * 
    FROM book_titles
  WHERE author_2 ISNULL AND author_3 ISNULL;

-- show all available books.

SELECT * FROM book_copies
    WHERE
  datetime('now') > available_from
  AND is_available = true;

-- tell if a given book in a table is available or not.

SELECT * FROM book_copies
    WHERE ISBN = '0001' AND is_available = 1;

-- Find the most demanding books in the year.

WITH a as
( 
SELECT *, COUNT(*) as count FROM library_log
    WHERE action = "issue" AND date_of_action LIKE '2020%'
  GROUP BY serial_number
),
serial_numbers as
(
SELECT serial_number FROM a
    WHERE count = (SELECT MAX(count) FROM a)
),
ISBNs as 
(
SELECT t2.ISBN FROM serial_numbers t1 
left join book_copies t2 on t1.serial_number = t2.serial_number
)
SELECT * FROM ISBNs t1 left join book_titles t2 on t1.ISBN=t2.ISBN;

-- Find the person who borrowed the most no of the books in the year.

WITH counts AS (
 SELECT *, COUNT(*) as count FROM library_log
    WHERE action = "issue" AND date_of_action LIKE '2020%'
  GROUP BY library_user_id
),
maxCounts AS (
  SELECT * FROM counts
  WHERE count = (SELECT MAX(count) FROM counts)
)
SELECT library_user_id, count
    FROM maxCounts;

-- Find the most popular writer in the year.

WITH counts AS (
  SELECT *, COUNT(*) as count FROM library_log
    WHERE action = "issue" AND date_of_action LIKE '2020%'
  GROUP BY serial_number
),
serial_numbers AS (
  SELECT serial_number FROM counts
  WHERE count = (SELECT MAX(count) FROM counts)
),
ISBNs AS (
  SELECT DISTINCT t2.ISBN
  FROM serial_numbers t1 
  LEFT JOIN book_copies t2 ON t1.serial_number = t2.serial_number
)
SELECT t1.ISBN, t2.author_1, t2.author_2, t2.author_3
FROM ISBNs t1
  LEFT JOIN book_titles t2 ON t1.ISBN = t2.ISBN;

-- Find given book will be available in next 2 days or not.

SELECT * FROM book_copies
WHERE serial_number = 1
  AND available_from <= datetime('now', '+2 days');

-- Find the defaulters who didn't return book with in last 15 days.

WITH defaulters AS
(
SELECT library_user_id as user_id FROM book_copies
WHERE date('now') > date(issued_date, '+15 days')
)

SELECT * FROM library_log
WHERE library_user_id = (SELECT user_id FROM defaulters);

-- Find the last and current owner of a particular book.

WITH users_with_row_number AS (
  SELECT
    row_number() over() AS row_num,
    library_user_id
  FROM
    book_copies
  WHERE
    serial_number = 2
)
SELECT
  library_user_id
FROM
  users_with_row_number
WHERE
  row_num = (
    SELECT
      min(row_num)
    FROM
      users_with_row_number
  )
  OR row_num = (
    SELECT
      max(row_num)
    FROM
      users_with_row_number
  );

-- Find all the owners of any given book.

SELECT
  library_user_id
FROM
  book_copies
WHERE
  ISBN = '0002' AND library_user_id IS NOT NULL;

-- Find all the books of any particular category like fiction, scientific.

SELECT * FROM book_titles
WHERE book_category = 'CSE';

-- Find all the books issued by specific user.

WITH serial_numbers AS
(
SELECT serial_number FROM library_log
  WHERE action = "issue" AND library_user_id = 'USR002'
),
ISBNs AS (
  SELECT DISTINCT t2.ISBN
  FROM serial_numbers t1 
  LEFT JOIN book_copies t2 ON t1.serial_number = t2.serial_number
)
SELECT t1.ISBN, t2.author_1, t2.author_2, t2.author_3, t2.publisher_name, t2.book_category
FROM ISBNs t1
  LEFT JOIN book_titles t2 ON t1.ISBN = t2.ISBN;
