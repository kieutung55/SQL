USE test_schema;

CREATE TABLE EMPLOYEES(
	EMP_ID CHAR(9) NOT NULL PRIMARY KEY,
    F_NAME VARCHAR(15) NOT NULL,
    L_NAME VARCHAR(15) NOT NULL,
    SSN CHAR(9),
    B_DATE DATE,
    SEX CHAR,
    ADDRESS VARCHAR(30),
    JOB_ID CHAR(9),
    SALARY DECIMAL (10,2),
    MANAGER_ID CHAR(9),
    DEP_ID CHAR(9)
);

CREATE TABLE JOB_HISTORY (
	EMPL_ID CHAR(9) NOT NULL,
    START_DATE DATE,
    JOBS_ID CHAR(9) NOT NULL,
    DEPT_ID CHAR(9),
    PRIMARY KEY (EMPL_ID,JOBS_ID)
);

CREATE TABLE JOBS (
	JOB_IDENT CHAR(9) NOT NULL, 
    JOB_TITLE VARCHAR(30),
    MIN_SALARY DECIMAL(10,2),
    MAX_SALARY DECIMAL(10,2),
    PRIMARY KEY (JOB_IDENT));

CREATE TABLE DEPARTMENTS (
	DEPT_ID_DEP CHAR(9) NOT NULL, 
    DEP_NAME VARCHAR(15) ,
    MANAGER_ID CHAR(9),
    LOC_ID CHAR(9),
    PRIMARY KEY (DEPT_ID_DEP));

CREATE TABLE LOCATIONS (
	LOCT_ID CHAR(9) NOT NULL,
    DEP_ID_LOC CHAR(9) NOT NULL,
    PRIMARY KEY (LOCT_ID,DEP_ID_LOC));

-- retrieve the first names and last names of all employees who live in Elgin, IL
SELECT F_NAME, L_NAME FROM EMPLOYEES 
WHERE ADDRESS LIKE '%ELGIN,IL%';

-- identify the employees who were born during the 70s
SELECT F_NAME, L_NAME FROM EMPLOYEES 
WHERE B_DATE LIKE '197%';

-- retrieve all employee records in department 5 where salary is 
-- between 60000 and 70000
SELECT * FROM EMPLOYEES
WHERE SALARY BETWEEN 60000 AND 70000 AND DEP_ID = 5;

-- Sorting
SELECT F_NAME, L_NAME, DEP_ID 
FROM EMPLOYEES
ORDER BY DEP_ID;

-- descending order of department ID, and within each deaprtment, 
-- the records should be ordered in descending alphabetical order by last name.
SELECT F_NAME, L_NAME, DEP_ID 
FROM EMPLOYEES
ORDER BY DEP_ID DESC, L_NAME DESC;

-- retrieve the number of employees in the department.
SELECT DEP_ID, COUNT(*)
FROM EMPLOYEES
GROUP BY DEP_ID;

-- retrieve the number of employees in the department 
-- and the average employee salary in the department
SELECT DEP_ID, COUNT(*), AVG(SALARY)
FROM EMPLOYEES
GROUP BY DEP_ID;

-- Label the computed columns in the result set of the last problem 
-- as NUM_EMPLOYEES and AVG_SALARY.
-- and sort the salary 
-- limit the result to departments with fewer than 4 employees
-- NOTE: No space in between count and (*)
SELECT DEP_ID, COUNT(*) AS 'NUM_EMPLOYEES', AVG(SALARY) AS 'AVG_SALARY'
FROM EMPLOYEES
GROUP BY DEP_ID
HAVING COUNT(*) < 4
ORDER BY AVG_SALARY;
-- Practice Questions
-- 1. Retrieve the list of all employees, first and last names,
-- whose first names start with ‘S’.
SELECT F_NAME, L_NAME FROM EMPLOYEES 
WHERE F_NAME LIKE 'S%';

-- 2. Arrange all the records of the EMPLOYEES table in ascending order 
-- of the date of birth.
SELECT * FROM EMPLOYEES
ORDER BY B_DATE ASC;

-- 3. Group the records in terms of the department IDs and 
-- filter them of ones that have average salary more than or equal to 60000. 
-- Display the department ID and the average salary.
SELECT DEP_ID, AVG(SALARY) FROM EMPLOYEES
GROUP BY DEP_ID
HAVING AVG(SALARY) >= 60000;

-- 4. For the problem above, sort the results for each group in 
-- descending order of average salary.
SELECT DEP_ID, AVG(SALARY) FROM EMPLOYEES
GROUP BY DEP_ID
HAVING AVG(SALARY) >= 60000
ORDER BY AVG(SALARY) DESC;