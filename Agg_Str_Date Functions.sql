USE test_schema;
CREATE TABLE PETRESCUE(
	ID INTEGER NOT NULL,
    ANIMAL VARCHAR(20),
    QUANTITY INTEGER,
    COST DECIMAL(6,2),
    RESCUEDATE DATE,
    PRIMARY KEY(ID)
);

INSERT INTO petrescue VALUES 
	(1,'Cat',9,450.09,'2018-05-29'),
	(2,'Dog',3,666.66,'2018-06-01'),
	(3,'Dog',1,100.00,'2018-06-04'),
	(4,'Parrot',2,50.00,'2018-06-04'),
	(5,'Dog',1,75.75,'2018-06-10'),
	(6,'Hamster',6,60.60,'2018-06-11'),
	(7,'Cat',1,44.44,'2018-06-11'),
	(8,'Goldfish',24,48.48,'2018-06-14'),
	(9,'Dog',2,222.22,'2018-06-15')
;

-- AGGREGATE FUNCTIONS
SELECT SUM(COST) AS SUM_OF_COST FROM PETRESCUE;
SELECT MAX(QUANTITY) FROM PETRESCUE;
SELECT MIN(QUANTITY) FROM PETRESCUE;
SELECT AVG(COST) FROM PETRESCUE;

-- Scalar Functions and String Functions
SELECT ROUND(COST) FROM PETRESCUE;
SELECT ROUND(COST, 2) FROM PETRESCUE;
SELECT LENGTH(ANIMAL) FROM PETRESCUE;
SELECT UCASE(ANIMAL) FROM PETRESCUE;
SELECT LCASE(ANIMAL) FROM PETRESCUE;

-- DATE Functions
-- Write a query that displays the third day of each rescue.
SELECT DAY(RESCUEDATE) FROM PETRESCUE;
SELECT MONTH(RESCUEDATE) FROM PETRESCUE;
SELECT YEAR(RESCUEDATE) FROM PETRESCUE;
SELECT DATE_ADD(RESCUEDATE, INTERVAL 3 DAY) FROM PETRESCUE;
SELECT DATE_ADD(RESCUEDATE, INTERVAL 2 MONTH) FROM PETRESCUE;

--  calculates the difference between the two given dates and gives the output in number of days
SELECT DATEDIFF(CURRENT_DATE, RESCUEDATE) FROM PETRESCUE;

-- Present the output in a YYYY-MM-DD format for date difference
SELECT FROM_DAYS(DATEDIFF(CURRENT_DATE,RESCUEDATE)) FROM PETRESCUE;

-- Practice Problems
-- The average cost of rescuing a single dog
SELECT AVG(COST/QUANTITY) FROM PETRESCUE WHERE ANIMAL = 'DOG';

-- displays the animal name in each rescue in uppercase without duplications.
SELECT DISTINCT(UCASE(ANIMAL)) FROM PETRESCUE;

-- displays all the columns from the PETRESCUE table where the animal(s) rescued are cats. 
-- Use cat in lowercase in the query.
SELECT * FROM PETRESCUE WHERE ANIMAL = LCASE('CAT');

-- Write a query that displays the number of rescues in the 5th month.
SELECT SUM(QUANTITY) FROM PETRESCUE WHERE MONTH(RESCUEDATE)= "05";

-- Write a query that displays the ID and the target date WITHIN 1 YEAR
SELECT ID, DATE_ADD(RESCUEDATE, INTERVAL 1 YEAR) FROM PETRESCUE;

