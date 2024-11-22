CREATE DATABASE assignment;
USE assignment;

CREATE TABLE Worker (
    WORKER_ID INT PRIMARY KEY,
    FIRST_NAME VARCHAR(50),
    LAST_NAME VARCHAR(50),
    SALARY INT,
    JOINING_DATE DATE,
    DEPARTMENT VARCHAR(50)
);
CREATE TABLE Bonus (
    WORKER_REF_ID INT,
    BONUS_DATE DATE,
    BONUS_AMOUNT INT,
    FOREIGN KEY (WORKER_REF_ID) REFERENCES Worker(WORKER_ID)
);
CREATE TABLE Title (
    WORKER_REF_ID INT,
    WORKER_TITLE VARCHAR(50),
    AFFECTED_FROM DATE,
    FOREIGN KEY (WORKER_REF_ID) REFERENCES Worker(WORKER_ID)
);
INSERT INTO Worker (WORKER_ID, FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT)
VALUES
(1, 'Rana', 'Hamid', 100000, '2014-02-20', 'HR'),
(2, 'Sanjoy', 'Saha', 80000, '2014-06-11', 'Admin'),
(3, 'Mahmudul', 'Hasan', 300000, '2014-02-20', 'HR'),
(4, 'Asad', 'Zaman', 500000, '2014-02-20', 'Admin'),
(5, 'Sajib', 'Mia', 500000, '2014-06-11', 'Admin'),
(6, 'Alamgir', 'Kabir', 200000, '2014-06-11', 'Account'),
(7, 'Foridul', 'Islam', 75000, '2014-01-20', 'Account'),
(8, 'Keshob', 'Ray', 90000, '2014-04-11', 'Admin');
INSERT INTO Bonus (WORKER_REF_ID, BONUS_DATE, BONUS_AMOUNT)
VALUES
(1, '2019-02-20', 5000),
(2, '2019-06-11', 3000),
(3, '2019-02-20', 4000),
(4, '2019-02-20', 4500),
(5, '2019-06-11', NULL),
(6, '2019-06-12', 3500);
INSERT INTO Title (WORKER_REF_ID, WORKER_TITLE, AFFECTED_FROM)
VALUES
(1, 'Manager', '2019-02-20'),
(2, 'Executive', '2019-06-11'),
(8, 'Executive', '2019-06-11'),
(5, 'Manager', '2019-06-11'),
(4, 'Asst. Manager', '2019-06-11'),
(7, 'Executive', '2019-06-11'),
(6, 'Lead', '2019-06-11'),
(3, 'Lead', '2019-06-11');

--1. Write an sql query to fetch "FIRST_NAME" from Worker table in upper case
SELECT UPPER(FIRST_NAME) AS FIRST_NAME_IN_UPPERCASE
FROM Worker;

--2. Write an SQL query to fetch unique values of DEPERTMENT from Worker table.
SELECT DISTINCT DEPARTMENT
FROM Worker;

--3. Write an SQL query to find the position of the alphabet('a') in the first name column 'Sanjoy' from Worker table.
SELECT CHARINDEX('a', FIRST_NAME) AS POSITION
FROM Worker
WHERE FIRST_NAME = 'Sanjoy';

--4. Write an SQL query to print details of the workers from Workers table whose FIRST_NAME ends with 'b' and contains at least three alphabet.
SELECT *
FROM Worker
WHERE FIRST_NAME LIKE '%b' AND LEN(FIRST_NAME) >= 3;

--5. Write an SQL query to print the FIRST_NAME from Worker table after replacing 'a' with 'A’ .
SELECT REPLACE(FIRST_NAME, 'a', 'A') AS MODIFIED_FIRST_NAME
FROM Worker;

--6. Write an SQL query to print details for Workers with the first name as “Asad” and “Sajib” from Worker table. 
SELECT *
FROM Worker
WHERE FIRST_NAME IN ('Asad', 'Sajib');

--7. Write an SQL query to print details of the Workers who have joined 6 months ago. 
SELECT *
FROM Worker
WHERE JOINING_DATE BETWEEN DATEADD(MONTH, -6, GETDATE()) AND GETDATE();

--8. Write an SQL query to show all departments along with the number of people in there. 
SELECT DEPARTMENT, COUNT(*) AS NUMBER_OF_WORKERS
FROM Worker
GROUP BY DEPARTMENT;

--9. Write an SQL query to fetch the departments that have less than five people in it. 
SELECT DEPARTMENT, COUNT(*) AS NUMBER_OF_WORKERS
FROM Worker
GROUP BY DEPARTMENT
HAVING COUNT(*) < 5;

--10. Write an SQL query to print details of the Workers who are also Managers.
SELECT W.*
FROM Worker W
JOIN Title T
ON W.WORKER_ID = T.WORKER_REF_ID
WHERE T.WORKER_TITLE = 'Manager';

--11. List all the employees except ‘Manager’ & ‘Asst. Manager’. 
SELECT W.*
FROM Worker W
JOIN Title T
ON W.WORKER_ID = T.WORKER_REF_ID
WHERE T.WORKER_TITLE NOT IN ('Manager', 'Asst. Manager');

--12. Write an SQL query to determine the nth (say n=5) highest salary from a table 
SELECT MIN(SALARY) AS Nth_Highest_Salary
FROM (
    SELECT DISTINCT TOP 5 SALARY
    FROM Worker
    ORDER BY SALARY DESC
) AS TopSalaries;

--13. Write an SQL query to fetch the last five records from a table.
SELECT *
FROM Worker
ORDER BY WORKER_ID DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;

--14. Write an SQL query to print the name of employees having the highest salary in each department. 
SELECT FIRST_NAME, LAST_NAME, DEPARTMENT, SALARY
FROM Worker W
WHERE SALARY = (
    SELECT MAX(SALARY)
    FROM Worker
    WHERE DEPARTMENT = W.DEPARTMENT
);

--15. Write an SQL query to fetch three max salaries from table.
SELECT TOP 3 SALARY
FROM Worker
ORDER BY SALARY DESC;

-- Create Table: Account_Detail
CREATE TABLE Account_Detail (
    Account_no INT PRIMARY KEY,
    Acc_holder_name VARCHAR(50),
    Amount INT,
    Branch_Id VARCHAR(10),
    Zone_Id VARCHAR(10)
);

-- Insert Data: Account_Detail
INSERT INTO Account_Detail (Account_no, Acc_holder_name, Amount, Branch_Id, Zone_Id)
VALUES
(1992212, 'Mr. Nazmuzzaman', 200000, 'B-101', 'Z-803'),
(1992213, 'Mr. Jibon', 170000, 'B-102', 'Z-803'),
(1882212, 'Bushra', 180000, 'B-103', 'Z-802'),
(1882213, '%Sajib', 170000, 'B-104', 'Z-801');

-- Create Table: Branch
CREATE TABLE Branch (
    Br_Id VARCHAR(10) PRIMARY KEY,
    Branch_Name VARCHAR(50)
);

-- Insert Data: Branch
INSERT INTO Branch (Br_Id, Branch_Name)
VALUES
('B-101', 'Bonani'),
('B-102', 'Romna'),
('B-103', 'Shaheb bazar'),
('B-104', 'Ullapara');

-- Create Table: Zone
CREATE TABLE Zone (
    Zone_Id VARCHAR(10) PRIMARY KEY,
    Name VARCHAR(50)
);

-- Insert Data: Zone
INSERT INTO Zone (Zone_Id, Name)
VALUES
('Z-801', 'Sirajgonj'),
('Z-802', 'Rajshahi'),
('Z-803', 'Dhaka'),
('Z-804', 'Chittagong');

--1.Create a simple stored procedure “SPdetails” to find Acc_holder_name, Amount, Branch_Name and Zone_Name.
CREATE PROCEDURE SPdetails
AS
BEGIN
    SELECT 
        a.Acc_holder_name,
        a.Amount,
        b.Branch_Name,
        z.Name AS Zone_Name
    FROM 
        Account_Detail a
    INNER JOIN 
        Branch b ON a.Branch_Id = b.Br_Id
    INNER JOIN 
        Zone z ON a.Zone_Id = z.Zone_Id;
END;
EXEC SPdetails;

--2. Create a simple stored procedure “SPaverage” to Branch _name and Amount of Branch.
CREATE PROCEDURE SPaverage
AS
BEGIN
    SELECT 
        b.Branch_Name,
        AVG(a.Amount) AS Average_Amount
    FROM 
        Account_Detail a
    INNER JOIN 
        Branch b ON a.Branch_Id = b.Br_Id
    GROUP BY 
        b.Branch_Name;
END;
EXEC SPaverage;

--3. Create a simple stored procedure “SPbalance” to find Amount of each Account_no.
CREATE PROCEDURE SPbalance
AS
BEGIN
    SELECT 
        Account_no,
        Amount
    FROM 
        Account_Detail;
END;
EXEC SPbalance;

--4. Create a simple stored procedure “SPamount” to Find all account holders name with their branch name and zone name whose name has substring ‘Mr.’ and Amount Less than Maximum Amount.
CREATE PROCEDURE SPamount
AS
BEGIN
    -- Find the maximum amount
    DECLARE @MaxAmount INT;
    SELECT @MaxAmount = MAX(Amount) FROM Account_Detail;

    -- Fetch account holders matching the criteria
    SELECT 
        a.Acc_holder_name,
        b.Branch_Name,
        z.Name AS Zone_Name,
        a.Amount
    FROM 
        Account_Detail a
    INNER JOIN 
        Branch b ON a.Branch_Id = b.Br_Id
    INNER JOIN 
        Zone z ON a.Zone_Id = z.Zone_Id
    WHERE 
        a.Acc_holder_name LIKE '%Mr.%' -- Name contains 'Mr.'
        AND a.Amount < @MaxAmount;    -- Amount is less than the maximum
END;
EXEC SPamount;


-- 5. Create a simple stored procedure “SPdetailsInfo” to find Zone_name, number of customer of each Zone.
CREATE PROCEDURE SPdetailsInfo
AS
BEGIN
    SELECT 
        z.Name AS Zone_Name,
        COUNT(a.Account_no) AS Number_of_Customers
    FROM 
        Account_Detail a
    INNER JOIN 
        Zone z ON a.Zone_Id = z.Zone_Id
    GROUP BY 
        z.Name;
END;
EXEC SPdetailsInfo;
