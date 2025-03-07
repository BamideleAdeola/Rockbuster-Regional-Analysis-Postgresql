
-- CREATE A DATABASE FOR TEST
CREATE DATABASE testDb;


-- CREATE A SAMPLE EMPLOYEESKILLS TABLE
CREATE TABLE employeeskills
(
	EmpId VARCHAR(10) NOT NULL,
	skill VARCHAR(50) NOT NULL

);


-- INSERT INTO THE TABLE

INSERT INTO employeeskills (EmpId, skill)
VALUES 
('E101', 'Python'),
('E102', 'Java'),
('E103', 'SQL'),
('E102', 'R'),
('E101', 'Tableau'),
('E101', 'Machine Learning'),
('E102', 'AWS'),
('E101', 'Azure'),
('E102', 'GCP'),
('E102', 'Snowflake'),
('E102', 'Spring Boot'),
('E103', 'Data Analysis'),
('E101', 'Data Science'),
('E102', 'Docker'),
('E103', 'Power BI');

-- Retrieve the data in the table
SELECT * FROM employeeSkills;

--Query 1: 
--Retrieve Skills in a single field with the values comma delimited.

SELECT 
	string_agg (skill, ' , '  ORDER BY skill)
FROM employeeSkills;

/* Query 2
Group each skill and show each employeeid in its 
respective skill separated by comma.
*/
SELECT 
	empid,
	string_agg(skill, ' , ' ORDER BY skill)
FROM employeeskills
GROUP BY empid;

/* Query 3
Display the skills belonging 
to each empid ordered by the empid with the help of STRING_AGG function
separated by a pipe.
 */
SELECT 
	empid,
	string_agg(skill, ' | ' ORDER BY skill) 
FROM employeeskills
GROUP BY empid
ORDER BY empid;






--SELECT 
--    EmpID,
--    LISTAGG(Skill, ', ') WITHIN GROUP (ORDER BY Skill) AS SortedSkills,
--    LISTAGG(Skill, ', ') WITHIN GROUP (ORDER BY NULL) AS UnsortedSkills
--FROM EmployeeSkills
--GROUP BY EmpID;


SELECT 
    EmpID,
    STRING_AGG(Skill, ', ' ORDER BY skill) AS SkillSummary
FROM EmployeeSkills
GROUP BY EmpID;






);

-- Insert sample data into the Orders table
INSERT INTO Orders (OrderID, TotalAmount)
VALUES
    (1, 120.50),
    (2, 85.00),
    (3, 45.75),
    (4, 99.99),
    (5, 200.00),
    (6, 30.00),
    (7, 150.00);


-- Create the Orders table
CREATE TABLE Orders (
    OrderID SERIAL PRIMARY KEY,
    TotalAmount NUMERIC(10, 2)
);

-- Insert sample data into the Orders table
INSERT INTO Orders (TotalAmount)
VALUES
    (120.50),
    (85.00),
    (45.75),
    (99.99),
    (200.00),
    (30.00),
    (150.00);



-- Create the database (run manually if not already created)
-- CREATE DATABASE SalesDB;

-- Connect to SalesDB (manually connect using your client or tool)

-- Create the Orders table
CREATE TABLE IF NOT EXISTS Orders (
    OrderID SERIAL PRIMARY KEY,
    TotalAmount NUMERIC(10, 2)
);

-- Insert initial sample data
INSERT INTO Orders (TotalAmount)
VALUES
    (120.50),
    (85.00),
    (45.75),
    (99.99),
    (200.00),
    (30.00),
    (150.00);

-- Additional data

-- Insert additional sample data into the Orders table
INSERT INTO Orders (TotalAmount)
VALUES
    (10.99),
    (59.99),
    (120.00),
    (250.00),
    (15.00),
    (75.75),
    (99.00),
    (89.99),
    (300.50),
    (45.00),
    (180.00),
    (220.00),
    (60.60),
    (25.99),
    (135.00),
    (80.00),
    (40.40),
    (19.99),
    (500.00),
    (99.99);
































SELECT * 
FROM public.orders;

-- Write a query to group the totalamount field into categories
1. "High Values" >= 100
2. 50 TO 99 "Medium"
3. Less than 50 "Low Value"
































