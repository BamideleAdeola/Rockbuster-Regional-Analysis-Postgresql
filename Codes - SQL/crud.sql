-- 1. CREATE

CREATE TABLE studentCourse (
	StudentID Integer NOT NULL,
	CourseID VARCHAR (10) NOT NULL ,
	Grade CHAR(2)
);


SELECT * FROM studentCourse;

-- INSERT VALUES INTO A TABLE
INSERT INTO studentCourse (studentid,courseid,grade)
VALUES (101, 'CS101', 'A');

-- INSERTING MORE THAN ONE ROWS
INSERT INTO studentCourse (studentid,courseid,grade)
VALUES 
(102, 'CS101', 'B'),
(101, 'MATH201', 'A+');


-- WHERE CLAUSE 
-- 2. READ QUE: RETRIEVE COURSE WHERE STUDENT ID IS LESS THAN 102
SELECT *
FROM studentCourse
WHERE studentid < 102;


-- 3. UPDATE
SELECT *
FROM studentCourse
WHERE studentid < 102;

/*
UPDATE TABLE 
SET COLUMN_NAME = WHATERVER
WHERE COLUMN = WHATEEVER;
*/

UPDATE public.studentcourse
SET studentid = 103
WHERE grade = 'A+';

-- 4. DELETE
/*
DELETE 
FROM TABLE 
WHERE COLUMN = WHATEVER
*/
DELETE 
FROM public.studentcourse
WHERE grade = 'A+';







