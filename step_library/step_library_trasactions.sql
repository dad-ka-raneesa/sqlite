
BEGIN TRANSACTION;

INSERT INTO
  library_log(
    action,
    date_of_action,
    library_user_id,
    serial_number
  )
VALUES
("issue", datetime('now'), 'USR001', '1');

UPDATE
  book_copies
set
  is_available = false,
  issued_date = datetime('now'),
  available_from = datetime('now', '+15 days'),
  library_user_id = "USR001"
WHERE
  serial_number = "1";

END TRANSACTION;

BEGIN TRANSACTION;

INSERT INTO
  library_log(
    action,
    date_of_action,
    library_user_id,
    serial_number
  )
VALUES
("return", datetime('now'), 'USR001', '1');

UPDATE
  book_copies
set
  is_available = true,
  issued_date = NULL,
  available_from = datetime('now'),
  library_user_id = NULL
WHERE
  serial_number = "1";

END TRANSACTION;

BEGIN TRANSACTION;

INSERT INTO
  library_log(
    action,
    date_of_action,
    library_user_id,
    serial_number
  )
VALUES
  ("issue", datetime('now'), 'USR002', '1');

UPDATE
  book_copies
set
  is_available = false,
  issued_date = datetime('now'),
  available_from = datetime('now', '+15 days'),
  library_user_id = "USR002"
WHERE
  serial_number = "1";

END TRANSACTION;

BEGIN TRANSACTION;

INSERT INTO
  library_log(
    action,
    date_of_action,
    library_user_id,
    serial_number
  )
VALUES
  ("return", datetime('now'), 'USR002', '1');

UPDATE
  book_copies
set
  is_available = true,
  issued_date = NULL,
  available_from = datetime('now'),
  library_user_id = NULL
WHERE
  serial_number = "1";

END TRANSACTION;

BEGIN TRANSACTION;

INSERT INTO
  library_log(
    action,
    date_of_action,
    library_user_id,
    serial_number
  )
VALUES
  ("issue", datetime('now'), 'USR003', '3');

UPDATE
  book_copies
set
  is_available = false,
  issued_date = datetime('now'),
  available_from = datetime('now', '+15 days'),
  library_user_id = "USR003"
WHERE
  serial_number = '3';

END TRANSACTION;

BEGIN TRANSACTION;

INSERT INTO
  library_log(
    action,
    date_of_action,
    library_user_id,
    serial_number
  )
VALUES
  ("return", datetime('now'), 'USR003', '3');

UPDATE
  book_copies
set
  is_available = true,
  issued_date = NULL,
  available_from = datetime('now'),
  library_user_id = NULL
WHERE
  serial_number = "2";

END TRANSACTION;

BEGIN TRANSACTION;

INSERT INTO
  library_log(
    action,
    date_of_action,
    library_user_id,
    serial_number
  )
VALUES
  ("issue", datetime('2019-06-21'), 'USR003', '3');

UPDATE
  book_copies
set
  is_available = false,
  issued_date = datetime('2019-06-21'),
  available_from = datetime('2019-06-21', '+15 days'),
  library_user_id = "USR003"
WHERE
  serial_number = '3';

END TRANSACTION;

BEGIN TRANSACTION;

INSERT INTO
  library_log(
    action,
    date_of_action,
    library_user_id,
    serial_number
  )
VALUES
  ("return", datetime('now'), 'USR003', '3');

UPDATE
  book_copies
set
  is_available = true,
  issued_date = NULL,
  available_from = datetime('now'),
  library_user_id = NULL
WHERE
  serial_number = "2";

END TRANSACTION;

BEGIN TRANSACTION;

INSERT INTO
  library_log(
    action,
    date_of_action,
    library_user_id,
    serial_number
  )
VALUES
  ("issue", datetime('now'), 'USR003', '3');

UPDATE
  book_copies
set
  is_available = false,
  issued_date = datetime('now'),
  available_from = datetime('now', '+15 days'),
  library_user_id = "USR003"
WHERE
  serial_number = '3';

END TRANSACTION;

BEGIN TRANSACTION;

INSERT INTO
  library_log(
    action,
    date_of_action,
    library_user_id,
    serial_number
  )
VALUES
  ("issue", datetime('now'), 'USR002', '3');

UPDATE
  book_copies
set
  is_available = false,
  issued_date = datetime('now'),
  available_from = datetime('now', '+15 days'),
  library_user_id = "USR002"
WHERE
  serial_number = "1";

END TRANSACTION;