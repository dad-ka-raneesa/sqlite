-- SQLite
DROP TABLE IF EXISTS book_titles;

CREATE TABLE book_titles (
  ISBN varchar(50) PRIMARY KEY,
  title varchar(50) NOT NULL,
  author_1 varchar(50) NOT NULL,
  author_2 varchar(50),
  author_3 varchar(50),
  publisher_name varchar(50),
  book_category varchar(30),
  number_of_copies_total numeric(4)
);

DROP TABLE IF EXISTS book_copies;

CREATE TABLE book_copies (
  serial_number integer PRIMARY KEY AUTOINCREMENT,
  ISBN varchar(50) NOT NULL,
  is_available boolean NOT NULL CHECK(is_available IN (0, 1)),
  enrolled_date date,
  -- date on which added
  available_from date,
  -- date from it is available to reserve
  issued_date date,
  library_user_id varchar(50)
);

DROP TABLE IF EXISTS library_log;

CREATE TABLE library_log (
  action varchar(10) CHECK(
    action = "issue"
    OR action = "return"
  ),
  -- 'ISSUE', 'RETURN' -- check 
  date_of_action date,
  library_user_id varchar(50),
  serial_number integer
);

INSERT INTO
  book_titles (
    ISBN,
    title,
    author_1,
    author_2,
    author_3,
    publisher_name,
    book_category,
    number_of_copies_total
  )
VALUES
  (
    '0001',
    'C',
    'Raj',
    'Ram',
    NULL,
    'XYZ Publishers',
    'CSE',
    2
  ),
  (
    '0002',
    'C++',
    'Ravi',
    'Varma',
    'sharma',
    'ABC Publishers',
    'CSE',
    3
  ),
  (
    '0003',
    'C',
    'somu',
    'Ramu',
    'shamu',
    'XYZ Publishers',
    'CSE',
    2
  ),
  (
    '0004',
    'C++',
    'Ram',
    NULL,
    NULL,
    'ABC Publishers',
    'CSE',
    2
  );

INSERT INTO
  book_copies (
    ISBN,
    is_available,
    enrolled_date,
    available_from,
    issued_date,
    library_user_id
  )
VALUES
  (
    '0001',
    1,
    datetime('now'),
    datetime('now'),
    NULL,
    NULL
  ),
  (
    '0001',
    1,
    datetime('now'),
    datetime('now'),
    NULL,
    NULL
  ),
  (
    '0002',
    1,
    datetime('now'),
    datetime('now'),
    NULL,
    NULL
  ),
  (
    '0002',
    1,
    datetime('now'),
    datetime('now'),
    NULL,
    NULL
  ),
  (
    '0002',
    1,
    datetime('now'),
    datetime('now'),
    NULL,
    NULL
  ),
  (
    '0003',
    1,
    datetime('now'),
    datetime('now'),
    NULL,
    NULL
  ),
  (
    '0003',
    1,
    datetime('now'),
    datetime('now'),
    NULL,
    NULL
  );

SELECT
  *
FROM
  book_titles;

SELECT
  *
FROM
  book_copies;

SELECT
  *
FROM
  library_log;
