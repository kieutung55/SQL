/*  Using Joins 
SQL query to list the school names, community names and 
average attendance for communities with a hardship index of 98.
*/

USE chicago_data;
SELECT CPS.NAME_OF_SCHOOL, CPS.AVERAGE_STUDENT_ATTENDANCE, CCD.COMMUNITY_AREA_NAME
FROM CHICAGOPUBLICSCHOOLS CPS
LEFT JOIN CHICAGOCENSUSDATA CCD
ON CPS.COMMUNITY_AREA_NUMBER = CCD.COMMUNITY_AREA_NUMBER
WHERE CCD.HARDSHIP_INDEX = 98;

/* SQL query to list all crimes that took place at a school. 
Include case number, crime type and community name. CCD AS CENSUS DATA, CD AS CRIME DATA*/ 
SELECT CD.CASE_NUMBER, CD.PRIMARY_TYPE, CPS.COMMUNITY_AREA_NAME
FROM CHICAGOCRIMEDATA CD
INNER JOIN CHICAGOPUBLICSCHOOLS CPS
ON CD.COMMUNITY_AREA_NUMBER = CPS.COMMUNITY_AREA_NUMBER
AND CD.LOCATION_DESCRIPTION LIKE '%SCHOOL%';

/* Creating a View
Write and execute a SQL statement to create a view showing the columns listed in the following table, 
with new column names as shown in the second column. */
CREATE VIEW Public_Schools (School_Name, Safety_Rating, Family_Rating, Environment_Rating, 
							Instruction_Rating, Leaders_Rating, Teachers_Rating) AS 
SELECT NAME_OF_SCHOOL, Safety_Icon, Family_Involvement_Icon, Environment_Icon,
Instruction_Icon, Leaders_Icon, Teachers_Icon
FROM CHICAGOPUBLICSCHOOLS;

SELECT * FROM Public_Schools;

/* Creating a Stored Procedure
1. Structure of a query to create or replace a stored procedure 
called UPDATE_LEADERS_SCORE that takes a in_School_ID parameter as an integer 
and a in_Leader_Score parameter as an integer.*/

/* 2. Inside stored procedure, there is  an SQL statement to update the Leaders_Score 
field in the CHICAGO_PUBLIC_SCHOOLS table for the school identified by in_School_ID to 
the value in the in_Leader_Score parameter.*/

/* 3. Inside stored procedure,there is SQL IF statement to update the Leaders_Icon field 
in the CHICAGO_PUBLIC_SCHOOLS table for the school identified by in_School_ID using the following information.*/
DELIMITER @
CREATE PROCEDURE UPDATE_LEADERS_SCORE(
	in_School_ID INT,
    in_Leader_Score INT
)
BEGIN
	START TRANSACTION;
    # 2/
    UPDATE CHICAGOPUBLICSCHOOLS
    SET Leaders_Score = in_Leader_Score
    WHERE School_ID = in_School_ID;
    
    # 3/
    IF in_Leader_Score BETWEEN 80 AND 99 THEN
		UPDATE CHICAGOPUBLICSCHOOLS
        SET Leaders_Icon = 'Very Strong'
        WHERE School_ID = in_School_ID;
	ELSEIF in_Leader_Score BETWEEN 60 AND 79 THEN
		UPDATE CHICAGOPUBLICSCHOOLS
        SET Leaders_Icon = 'Strong'
        WHERE School_ID = in_School_ID;
	ELSEIF in_Leader_Score BETWEEN 40 AND 59 THEN
		UPDATE CHICAGOPUBLICSCHOOLS
        SET Leaders_Icon = 'Average'
        WHERE School_ID = in_School_ID;
	ELSEIF in_Leader_Score BETWEEN 20 AND 39 THEN
		UPDATE CHICAGOPUBLICSCHOOLS
        SET Leaders_Icon = 'Weak'
        WHERE School_ID = in_School_ID;
	ELSEIF in_Leader_Score BETWEEN 0 AND 19 THEN
		UPDATE CHICAGOPUBLICSCHOOLS
        SET Leaders_Icon = 'Very Weak'
        WHERE School_ID = in_School_ID;
    ELSE
		ROLLBACK;
	COMMIT;
	
	END IF;
END @
DELIMITER ;

/* 4. Run your code to create the stored procedure.
Write a query to call the stored procedure, passing a valid school ID and a leader score of 50, 
to check that the procedure works as expected. */
CALL UPDATE_LEADERS_SCORE(610038, 50);
CALL UPDATE_LEADERS_SCORE(610281, 50);

SELECT LEADERS_SCORE, LEADERS_ICON FROM CHICAGOPUBLICSCHOOLS
WHERE SCHOOL_ID = 610038;


