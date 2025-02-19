SELECT name FROM v$datafile WHERE con_id = 2;
CREATE PLUGGABLE DATABASE mon_26442_pdb_assI
ADMIN USER pdb_admin IDENTIFIED BY Admin123
FILE_NAME_CONVERT = (
    'C:\ORACLE21C\ORADATA\ORCL\PDBSEED\', 
    'C:\ORACLE21C\ORADATA\ORCL\mon_26442_pdb_assI\'
);
ALTER PLUGGABLE DATABASE mon_26442_pdb_assI OPEN;
SHOW PDBS;
ALTER SESSION SET CONTAINER = MON_26442_PDB_ASSI;
SHOW CON_NAME;
-- Creating Department Table
CREATE TABLE Department (
    department_id NUMBER PRIMARY KEY,
    name VARCHAR2(100) NOT NULL
);

-- Creating Employee Table
CREATE TABLE Employee (
    employee_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50) NOT NULL,
    email VARCHAR2(100) UNIQUE,
    department_id NUMBER,
    CONSTRAINT fk_department FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

-- Creating Transaction Table
CREATE TABLE Transaction_Record (
    transaction_id NUMBER PRIMARY KEY,
    employee_id NUMBER,
    amount NUMBER(10,2),
    transaction_date DATE DEFAULT SYSDATE,
    CONSTRAINT fk_employee FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
);
-- Insert into Department Table
INSERT INTO Department (department_id, name) VALUES (1, 'IT');
INSERT INTO Department (department_id, name) VALUES (2, 'HR');
INSERT INTO Department (department_id, name) VALUES (3, 'Finance');

-- Insert into Employee Table
INSERT INTO Employee (employee_id, first_name, last_name, email, department_id)
VALUES (101, 'ndizeye', 'alain', 'alain.ndizeye@example.com', 1);

INSERT INTO Employee (employee_id, first_name, last_name, email, department_id)
VALUES (102, 'mucyo', 'Smith', 'mucyo.smith@example.com', 2);

INSERT INTO Employee (employee_id, first_name, last_name, email, department_id)
VALUES (103, 'nganji', 'Brown', 'nganji.brown@example.com', 1);

-- Insert into Transaction Table
INSERT INTO Transaction_Record (transaction_id, employee_id, amount, transaction_date)
VALUES (1001, 101, 5000, SYSDATE - 2); -- Transaction 2 days ago

INSERT INTO Transaction_Record (transaction_id, employee_id, amount, transaction_date)
VALUES (1002, 101, 7000, SYSDATE - 7); -- Transaction 7 days ago

INSERT INTO Transaction_Record (transaction_id, employee_id, amount, transaction_date)
VALUES (1003, 102, 3000, SYSDATE - 5); -- Transaction 5 days ago

INSERT INTO Transaction_Record (transaction_id, employee_id, amount, transaction_date)
VALUES (1004, 103, 2000, SYSDATE - 10); -- Transaction 10 days ago

-- Update Bob's email
UPDATE Employee 
SET email = 'mucyo.boris@example.com'
WHERE employee_id = 102;

-- Delete a transaction record
DELETE FROM Transaction_Record WHERE transaction_id = 1004;

-- Show employees and their departments
SELECT e.first_name, e.last_name, d.name AS department
FROM Employee e
JOIN Department d ON e.department_id = d.department_id;

-- Show transactions with employee names
SELECT t.transaction_id, e.first_name, e.last_name, t.amount, t.transaction_date
FROM Transaction_Record t
JOIN Employee e ON t.employee_id = e.employee_id;

SELECT * FROM Transaction_Record 
WHERE transaction_date >= SYSDATE - 7;

SELECT * FROM (
    SELECT transaction_id, employee_id, amount,
           RANK() OVER (PARTITION BY employee_id ORDER BY amount DESC) as rnk
    FROM Transaction_Record
) WHERE rnk <= 5;

SELECT employee_id
FROM Transaction_Record
GROUP BY employee_id
HAVING COUNT(transaction_id) > 3;

GRANT SELECT ON Employee TO hr_user;
CREATE USER hr_user IDENTIFIED BY HrUser123;

GRANT SELECT ON Employee TO hr_user;

SELECT username FROM dba_users WHERE username = 'HR_USER';

SAVEPOINT sp1;

INSERT INTO Employee (employee_id, first_name, last_name, email, department_id)
VALUES (104, 'David', 'Williams', 'david.williams@example.com', 2);

ROLLBACK TO sp1;  -- Undoes the insert

SELECT employee_id, COUNT(transaction_id) AS transaction_count
FROM Transaction_Record
GROUP BY employee_id;

INSERT INTO Transaction_Record (transaction_id, employee_id, amount)
VALUES (1003, 101, 5000);

INSERT INTO Transaction_Record (transaction_id, employee_id, amount)
VALUES (1004, 101, 7000);

INSERT INTO Transaction_Record (transaction_id, employee_id, amount)
VALUES (1005, 101, 6000);

COMMIT;

SELECT employee_id
FROM Transaction_Record
GROUP BY employee_id
HAVING COUNT(transaction_id) > 3;

SELECT transaction_id FROM Transaction_Record ORDER BY transaction_id;
