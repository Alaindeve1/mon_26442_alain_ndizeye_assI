-- Connect to container database and create pluggable database
SELECT name FROM v$datafile WHERE con_id = 2;
CREATE PLUGGABLE DATABASE monA_26442_pdb_assI
ADMIN USER pdb_admin IDENTIFIED BY Admin123
FILE_NAME_CONVERT = (
    'C:\ORACLE21C\ORADATA\ORCL\PDBSEED\', 
    'C:\ORACLE21C\ORADATA\ORCL\monA_26442_pdb_assI\'
);
ALTER PLUGGABLE DATABASE monA_26442_pdb_assI OPEN;
SHOW PDBS;
ALTER SESSION SET CONTAINER = MONA_26442_PDB_ASSI;
SHOW CON_NAME;

-- DDL Operations: Creating Tables (implementing conceptual diagram relationships)
-- Creating Department Table
CREATE TABLE Department (
    department_id NUMBER PRIMARY KEY,
    name VARCHAR2(100) NOT NULL
);

-- Creating Employee Table (one-to-many relationship with Department)
CREATE TABLE Employee (
    employee_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50) NOT NULL,
    email VARCHAR2(100) UNIQUE,
    department_id NUMBER,
    CONSTRAINT fk_department FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

-- Creating Transaction Table (one-to-many relationship with Employee)
CREATE TABLE Transaction_Record (
    transaction_id NUMBER PRIMARY KEY,
    employee_id NUMBER,
    amount NUMBER(10,2),
    transaction_date DATE DEFAULT SYSDATE,
    CONSTRAINT fk_employee FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
);

-- Creating Salary History Table (one-to-many relationship with Employee)
CREATE TABLE Salary_History (
    record_id NUMBER PRIMARY KEY,
    employee_id NUMBER,
    salary_amount NUMBER(10,2) NOT NULL,
    effective_date DATE DEFAULT SYSDATE,
    end_date DATE,
    CONSTRAINT fk_employee_salary FOREIGN KEY (employee_id) REFERENCES Employee(employee_id),
    CONSTRAINT check_dates CHECK (end_date IS NULL OR end_date > effective_date)
);

-- Creating Project Table (one-to-many relationship with Department)
CREATE TABLE Project (
    project_id NUMBER PRIMARY KEY,
    project_name VARCHAR2(100) NOT NULL,
    department_id NUMBER,
    start_date DATE DEFAULT SYSDATE,
    end_date DATE,
    CONSTRAINT fk_department_project FOREIGN KEY (department_id) REFERENCES Department(department_id),
    CONSTRAINT check_project_dates CHECK (end_date IS NULL OR end_date > start_date)
);

-- DML Operations: INSERT data into tables
-- Insert into Department Table
INSERT INTO Department (department_id, name) VALUES (1, 'IT');
INSERT INTO Department (department_id, name) VALUES (2, 'HR');
INSERT INTO Department (department_id, name) VALUES (3, 'Finance');
INSERT INTO Department (department_id, name) VALUES (4, 'Marketing');

-- Insert into Employee Table
INSERT INTO Employee (employee_id, first_name, last_name, email, department_id)
VALUES (101, 'Ndizeye', 'Alain', 'alain.ndizeye@example.com', 1);

INSERT INTO Employee (employee_id, first_name, last_name, email, department_id)
VALUES (102, 'Mucyo', 'Smith', 'mucyo.smith@example.com', 2);

INSERT INTO Employee (employee_id, first_name, last_name, email, department_id)
VALUES (103, 'Nganji', 'Brown', 'nganji.brown@example.com', 1);

INSERT INTO Employee (employee_id, first_name, last_name, email, department_id)
VALUES (104, 'David', 'Williams', 'david.williams@example.com', 3);

INSERT INTO Employee (employee_id, first_name, last_name, email, department_id)
VALUES (105, 'Sarah', 'Johnson', 'sarah.johnson@example.com', 4);

-- Insert into Transaction Table (with some transactions in the past 7 days)
INSERT INTO Transaction_Record (transaction_id, employee_id, amount, transaction_date)
VALUES (1001, 101, 5000, SYSDATE - 2); -- Transaction 2 days ago

INSERT INTO Transaction_Record (transaction_id, employee_id, amount, transaction_date)
VALUES (1002, 101, 7000, SYSDATE - 7); -- Transaction 7 days ago

INSERT INTO Transaction_Record (transaction_id, employee_id, amount, transaction_date)
VALUES (1003, 102, 3000, SYSDATE - 5); -- Transaction 5 days ago

INSERT INTO Transaction_Record (transaction_id, employee_id, amount, transaction_date)
VALUES (1004, 103, 2000, SYSDATE - 10); -- Transaction 10 days ago

INSERT INTO Transaction_Record (transaction_id, employee_id, amount, transaction_date)
VALUES (1005, 104, 4500, SYSDATE - 3); -- Transaction 3 days ago

INSERT INTO Transaction_Record (transaction_id, employee_id, amount, transaction_date)
VALUES (1006, 105, 6200, SYSDATE - 1); -- Transaction 1 day ago

-- Insert into Salary History Table
INSERT INTO Salary_History (record_id, employee_id, salary_amount, effective_date, end_date)
VALUES (1, 101, 60000, DATE '2022-01-01', DATE '2022-12-31');

INSERT INTO Salary_History (record_id, employee_id, salary_amount, effective_date, end_date)
VALUES (2, 101, 65000, DATE '2023-01-01', DATE '2023-12-31');

INSERT INTO Salary_History (record_id, employee_id, salary_amount, effective_date, end_date)
VALUES (3, 101, 70000, DATE '2024-01-01', NULL);

INSERT INTO Salary_History (record_id, employee_id, salary_amount, effective_date, end_date)
VALUES (4, 102, 55000, DATE '2022-01-01', DATE '2023-06-30');

INSERT INTO Salary_History (record_id, employee_id, salary_amount, effective_date, end_date)
VALUES (5, 102, 60000, DATE '2023-07-01', NULL);

INSERT INTO Salary_History (record_id, employee_id, salary_amount, effective_date, end_date)
VALUES (6, 103, 62000, DATE '2022-03-15', DATE '2023-03-14');

INSERT INTO Salary_History (record_id, employee_id, salary_amount, effective_date, end_date)
VALUES (7, 103, 67000, DATE '2023-03-15', NULL);

INSERT INTO Salary_History (record_id, employee_id, salary_amount, effective_date, end_date)
VALUES (8, 104, 72000, DATE '2022-05-01', NULL);

INSERT INTO Salary_History (record_id, employee_id, salary_amount, effective_date, end_date)
VALUES (9, 105, 58000, DATE '2022-08-01', DATE '2023-08-01');

INSERT INTO Salary_History (record_id, employee_id, salary_amount, effective_date, end_date)
VALUES (10, 105, 63500, DATE '2023-08-02', NULL);

-- Insert into Project Table
INSERT INTO Project (project_id, project_name, department_id, start_date, end_date)
VALUES (1, 'Website Redesign', 1, DATE '2023-06-01', DATE '2023-12-15');

INSERT INTO Project (project_id, project_name, department_id, start_date, end_date)
VALUES (2, 'Employee Onboarding System', 2, DATE '2023-03-10', DATE '2023-09-30');

INSERT INTO Project (project_id, project_name, department_id, start_date, end_date)
VALUES (3, 'Financial Reporting Tool', 3, DATE '2023-01-15', DATE '2023-11-20');

INSERT INTO Project (project_id, project_name, department_id, start_date, end_date)
VALUES (4, 'Data Security Upgrade', 1, DATE '2023-08-01', NULL);

INSERT INTO Project (project_id, project_name, department_id, start_date, end_date)
VALUES (5, 'Marketing Campaign Manager', 4, DATE '2023-05-12', DATE '2023-12-31');

-- DML Operations: UPDATE data
-- Update employee's email
UPDATE Employee 
SET email = 'mucyo.boris@example.com'
WHERE employee_id = 102;

-- DML Operations: DELETE data
-- Delete a transaction
DELETE FROM Transaction_Record WHERE transaction_id = 1004;

-- TCL Operation: Create a savepoint before further operations
SAVEPOINT before_additional_ops;

-- Basic SQL Commands: SELECT data (with JOINs)
-- Show employees and their departments
SELECT e.employee_id, e.first_name, e.last_name, d.name AS department
FROM Employee e
JOIN Department d ON e.department_id = d.department_id;

-- Show transactions with employee names (JOIN)
SELECT t.transaction_id, e.first_name, e.last_name, t.amount, t.transaction_date
FROM Transaction_Record t
JOIN Employee e ON t.employee_id = e.employee_id;

-- Identify records created in the past week (last 7 days)
SELECT t.transaction_id, e.first_name, e.last_name, t.amount, t.transaction_date,
       ROUND(SYSDATE - t.transaction_date) AS days_ago
FROM Transaction_Record t
JOIN Employee e ON t.employee_id = e.employee_id
WHERE t.transaction_date >= SYSDATE - 7
ORDER BY t.transaction_date DESC;

-- Retrieve the top 5 highest transactions by amount (using subquery and ranking)
SELECT * FROM (
    SELECT t.transaction_id, e.first_name, e.last_name, t.amount, t.transaction_date,
           RANK() OVER (ORDER BY t.amount DESC) as amount_rank
    FROM Transaction_Record t
    JOIN Employee e ON t.employee_id = e.employee_id
) WHERE amount_rank <= 5;

-- Add more transactions for employee 101 to demonstrate having more than 3 transactions
INSERT INTO Transaction_Record (transaction_id, employee_id, amount, transaction_date)
VALUES (1007, 101, 5500, SYSDATE - 1);

INSERT INTO Transaction_Record (transaction_id, employee_id, amount, transaction_date)
VALUES (1008, 101, 7200, SYSDATE - 3);

INSERT INTO Transaction_Record (transaction_id, employee_id, amount, transaction_date)
VALUES (1009, 101, 8100, SYSDATE - 4);

-- Retrieve employees with more than 3 transactions (using GROUP BY and HAVING)
SELECT e.employee_id, e.first_name, e.last_name, COUNT(t.transaction_id) as transaction_count
FROM Employee e
JOIN Transaction_Record t ON e.employee_id = t.employee_id
GROUP BY e.employee_id, e.first_name, e.last_name
HAVING COUNT(t.transaction_id) > 3;

-- Top 5 highest salaries for each department (using subquery and partitioning)
SELECT * FROM (
    SELECT d.name AS department, e.first_name, e.last_name, sh.salary_amount,
           RANK() OVER (PARTITION BY d.department_id ORDER BY sh.salary_amount DESC) as salary_rank
    FROM Department d
    JOIN Employee e ON d.department_id = e.department_id
    JOIN Salary_History sh ON e.employee_id = sh.employee_id
    WHERE sh.end_date IS NULL -- current salary
) WHERE salary_rank <= 5;

-- Top 5 projects by duration (using subquery)
SELECT * FROM (
    SELECT p.project_id, p.project_name, d.name AS department,
           p.start_date, p.end_date,
           CASE 
               WHEN p.end_date IS NULL THEN ROUND(SYSDATE - p.start_date)
               ELSE ROUND(p.end_date - p.start_date)
           END AS duration_days,
           RANK() OVER (ORDER BY 
               CASE 
                   WHEN p.end_date IS NULL THEN ROUND(SYSDATE - p.start_date)
                   ELSE ROUND(p.end_date - p.start_date)
               END DESC) as duration_rank
    FROM Project p
    JOIN Department d ON p.department_id = d.department_id
) WHERE duration_rank <= 5;

-- More complex query with subquery: Find employees with salary above department average
SELECT e.employee_id, e.first_name, e.last_name, d.name AS department, sh.salary_amount,
       (SELECT AVG(sh_inner.salary_amount)
        FROM Employee e_inner
        JOIN Salary_History sh_inner ON e_inner.employee_id = sh_inner.employee_id
        WHERE e_inner.department_id = e.department_id
        AND sh_inner.end_date IS NULL) AS dept_avg_salary
FROM Employee e
JOIN Department d ON e.department_id = d.department_id
JOIN Salary_History sh ON e.employee_id = sh.employee_id
WHERE sh.end_date IS NULL
AND sh.salary_amount > (
    SELECT AVG(sh_inner.salary_amount)
    FROM Employee e_inner
    JOIN Salary_History sh_inner ON e_inner.employee_id = sh_inner.employee_id
    WHERE e_inner.department_id = e.department_id
    AND sh_inner.end_date IS NULL
)
ORDER BY d.name, sh.salary_amount DESC;

-- Find departments with the most transactions
SELECT d.department_id, d.name, COUNT(t.transaction_id) as transaction_count
FROM Department d
JOIN Employee e ON d.department_id = e.department_id
JOIN Transaction_Record t ON e.employee_id = t.employee_id
GROUP BY d.department_id, d.name
ORDER BY transaction_count DESC;

-- TCL Operations: ROLLBACK to demonstrate transaction control
ROLLBACK TO before_additional_ops;

-- Verify rollback worked by checking if transactions 1007-1009 exist
SELECT transaction_id, employee_id, amount FROM Transaction_Record WHERE transaction_id >= 1007;

-- Re-insert the transactions after rollback
INSERT INTO Transaction_Record (transaction_id, employee_id, amount, transaction_date)
VALUES (1007, 101, 5500, SYSDATE - 1);

INSERT INTO Transaction_Record (transaction_id, employee_id, amount, transaction_date)
VALUES (1008, 101, 7200, SYSDATE - 3);

INSERT INTO Transaction_Record (transaction_id, employee_id, amount, transaction_date)
VALUES (1009, 101, 8100, SYSDATE - 4);

-- TCL Operation: COMMIT changes
COMMIT;

-- DCL Operations: Create user and grant permissions
CREATE USER hr_user IDENTIFIED BY HrUser123;

-- Grant permissions
GRANT SELECT ON Employee TO hr_user;
GRANT SELECT ON Department TO hr_user;
GRANT SELECT ON Salary_History TO hr_user;

-- Check user creation
SELECT username FROM dba_users WHERE username = 'HR_USER';

-- Show all transactions in ascending order
SELECT transaction_id, employee_id, amount, transaction_date 
FROM Transaction_Record 
ORDER BY transaction_id;

-- Show average transaction amount by department using JOIN and GROUP BY
SELECT d.name as department, AVG(t.amount) as avg_transaction_amount
FROM Department d
JOIN Employee e ON d.department_id = e.department_id
JOIN Transaction_Record t ON e.employee_id = t.employee_id
GROUP BY d.name
ORDER BY avg_transaction_amount DESC;

-- Show transaction count and total amount by employee
SELECT e.employee_id, e.first_name, e.last_name, 
       COUNT(t.transaction_id) as transaction_count,
       SUM(t.amount) as total_amount
FROM Employee e
JOIN Transaction_Record t ON e.employee_id = t.employee_id
GROUP BY e.employee_id, e.first_name, e.last_name
ORDER BY total_amount DESC;

-- Show employees with their department and latest transaction date
SELECT e.employee_id, e.first_name, e.last_name, d.name as department,
       MAX(t.transaction_date) as latest_transaction_date
FROM Employee e
JOIN Department d ON e.department_id = d.department_id
LEFT JOIN Transaction_Record t ON e.employee_id = t.employee_id
GROUP BY e.employee_id, e.first_name, e.last_name, d.name
ORDER BY latest_transaction_date DESC NULLS LAST;

-- Show employees that have transactions but no salary history (OUTER JOIN)
SELECT e.employee_id, e.first_name, e.last_name
FROM Employee e
JOIN Transaction_Record t ON e.employee_id = t.employee_id
LEFT JOIN Salary_History sh ON e.employee_id = sh.employee_id
WHERE sh.record_id IS NULL
GROUP BY e.employee_id, e.first_name, e.last_name;

-- Find current highest paid employee in each department (using analytic functions)
SELECT department, first_name, last_name, salary_amount
FROM (
    SELECT d.name as department, e.first_name, e.last_name, sh.salary_amount,
           RANK() OVER (PARTITION BY d.department_id ORDER BY sh.salary_amount DESC) as salary_rank
    FROM Department d
    JOIN Employee e ON d.department_id = e.department_id
    JOIN Salary_History sh ON e.employee_id = sh.employee_id
    WHERE sh.end_date IS NULL
)
WHERE salary_rank = 1;
