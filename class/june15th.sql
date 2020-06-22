-- SQLite
drop table if exists exam_enrollments;
create table exam_enrollments
(
    roll_no NUMBER(5) PRIMARY KEY,
    exam_center  VARCHAR(10) ,
    score  NUMBER(3) NOT NULL,
    address VARCHAR(200)
);

insert into exam_enrollments  VALUES
(1, 'BENGALURU', 90, '73/4, Swamiji villa, Near Delhi sarees store, Koramagala 1st block, Bengaluru - 560035' ),
(2, 'DELHI', 67, 'Apartment 4G, Tower apt Complex, New Delhi'),
(3, 'DELHI', 87, 'Karnataka Bhavan, Govt of India complex, New Delhi'),
(4, 'BENGALURU', 76, ' Jayanth code & music school, Near Chennai silks, Bengaluru, Karnataka'),
(5, 'PUNE', 89, '#34, ABC Street, Pune Highway, Satara, Maharashtra - 415001'),
(6, NULL, 91, ' some address at Chennai on Bengaluru highway'),
(7, 'CHENNAI', 77, ''),
(8, 'HYDERABAD', 80, 'House 4, Near Bank of Maharashtra, Secunderabad, Telangana')
;

select *
  from exam_enrollments;

-- find the people from delhi based on address 

SELECT *
   FROM exam_enrollments
  WHERE score > 70;

SELECT *
   FROM exam_enrollments
  WHERE exam_center like 'D%';

SELECT *
   FROM exam_enrollments
  WHERE address like '%Delhi';