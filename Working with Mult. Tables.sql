USE test_schema;
-- Retrieve only the EMPLOYEES records corresponding to jobs in the JOBS table.
SELECT * FROM EMPLOYEES WHERE JOB_ID IN (SELECT JOB_IDENT FROM JOBS);

--  retrieve the details from the JOBS table, which has common IDs with those available in the EMPLOYEES table,
-- provided the salary in the EMPLOYEES table is greater than $70,000
SELECT JOB_TITLE, MIN_SALARY, MAX_SALARY, JOB_IDENT FROM JOBS
WHERE JOB_IDENT IN (SELECT JOB_ID FROM EMPLOYEES WHERE SALARY > 70000);

-- Retrieve only the EMPLOYEES records corresponding to jobs in the JOBS table.
SELECT * FROM EMPLOYEES E, JOBS J
WHERE E.JOB_ID = J.JOB_IDENT;

-- In the previous query, retrieve only the Employee ID, Name, and Job Title.
SELECT EMP_ID, F_NAME, L_NAME, JOB_TITLE
FROM EMPLOYEES E, JOBS J
WHERE E.JOB_ID = J.JOB_IDENT;

-- We can use aliases in the select statement
-- In the previous query, retrieve only the Employee ID, Name, and Job Title.
SELECT E.EMP_ID, E.F_NAME, E.L_NAME, J.JOB_TITLE
FROM EMPLOYEES E, JOBS J
WHERE E.JOB_ID = J.JOB_IDENT;

-- Practice Problems
-- 1. Retrieve only the list of employees whose JOB_TITLE is Jr. Designer.
-- a. Sub-Queries
SELECT * FROM EMPLOYEES WHERE 
JOB_ID IN(SELECT JOB_IDENT FROM JOBS WHERE JOB_TITLE = "Jr. Designer");
-- b. Implicit Joins
SELECT * FROM EMPLOYEES E, JOBS J
WHERE E.JOB_ID = J.JOB_IDENT AND J.JOB_TITLE = 'Jr. Designer';

-- 2. Retrieve JOB information and a list of employees whose birth year is after 1976.
-- a. Sub-Queries
SELECT * FROM JOBS 
WHERE JOB_IDENT IN (SELECT JOB_ID FROM EMPLOYEES 
					WHERE YEAR(B_DATE) > 1976);
-- b. Implicit Joins
SELECT * FROM JOBS J, EMPLOYEES	E
WHERE J.JOB_IDENT = E.JOB_ID AND YEAR(E.B_DATE) > 1976;
