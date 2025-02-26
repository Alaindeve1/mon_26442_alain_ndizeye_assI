# 🏢 Company Database Management System

<div align="center">
  
 
  
  [![SQL](https://img.shields.io/badge/Oracle-21c-F80000?style=for-the-badge&logo=oracle&logoColor=white)](https://www.oracle.com/database/)
  [![PL/SQL](https://img.shields.io/badge/PL%2FSQL-Procedures-red?style=for-the-badge)](https://www.oracle.com/database/technologies/appdev/plsql.html)
  [![Status](https://img.shields.io/badge/Status-Active-success?style=for-the-badge)](https://github.com/)
  
</div>

## 👨‍💻 Developer Information

<div align="center">
  <table>
    <tr>
      <td><b>Student ID:</b></td>
      <td>26442</td>
    </tr>
    <tr>
      <td><b>Name:</b></td>
      <td>Ndizeye Alain</td>
    </tr>
    <tr>
      <td><b>Concentration:</b></td>
      <td>Software Engineering</td>
    </tr>
  </table>
</div>

## 🎯 Problem Statement


Modern enterprises struggle with disparate data systems and siloed information across departments. This fragmentation leads to inefficiencies, redundancies, and challenges in decision-making processes.

The **Company Database Management System** addresses these challenges by providing a unified platform that seamlessly integrates:

- 👥 **Employee management** across organizational structures
- 💰 **Financial transaction tracking** with complete audit trails  
- 📊 **Salary progression monitoring** for budget planning
- 📋 **Project timeline oversight** with departmental accountability
- 🔐 **Role-based access** to maintain data security and privacy

This integration enables real-time insights, promotes data-driven decision making, and enhances overall operational efficiency.

## 🗄️ Database Architecture

<div align="center">
  
  ```mermaid
  graph TD
    A[Department] -->|1:N| B[Employee]
    A -->|1:N| E[Project]
    B -->|1:N| C[Transaction_Record]
    B -->|1:N| D[Salary_History]
    
    style A fill:#f9f,stroke:#333,stroke-width:2px
    style B fill:#bbf,stroke:#333,stroke-width:2px
    style C fill:#bfb,stroke:#333,stroke-width:2px
    style D fill:#fbf,stroke:#333,stroke-width:2px
    style E fill:#fbb,stroke:#333,stroke-width:2px
  ```
  
</div>

### Table Structure

| Entity | Description | Key Fields |
|--------|-------------|------------|
| **Department** | Core organizational units | department_id, name |
| **Employee** | Personnel records with department association | employee_id, first_name, last_name, email, department_id |
| **Transaction_Record** | Financial activities linked to employees | transaction_id, employee_id, amount, transaction_date |
| **Salary_History** | Historical compensation data | record_id, employee_id, salary_amount, effective_date, end_date |
| **Project** | Initiative tracking with timeline management | project_id, project_name, department_id, start_date, end_date |

## ✨ Key Features

<div align="center">
  <table>
    <tr>
      <td align="center"><h3>📊</h3><b>Advanced Analytics</b></td>
      <td align="center"><h3>🔄</h3><b>Transaction Control</b></td>
      <td align="center"><h3>🔐</h3><b>Security Framework</b></td>
    </tr>
    <tr>
      <td>Complex queries with JOINs, subqueries, and analytic functions</td>
      <td>Savepoint creation, rollback capabilities, and commitment control</td>
      <td>User-specific privileges and role-based access management</td>
    </tr>
    <tr>
      <td align="center"><h3>📈</h3><b>Historical Tracking</b></td>
      <td align="center"><h3>🛡️</h3><b>Data Integrity</b></td>
      <td align="center"><h3>🔍</h3><b>Audit Capabilities</b></td>
    </tr>
    <tr>
      <td>Timeline-based records for salaries and projects</td>
      <td>Foreign key constraints and comprehensive validation</td>
      <td>Transaction logging and change management</td>
    </tr>
  </table>
</div>

## 💻 Implementation Highlights

```sql
-- Example: Finding employees with salary above department average
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
```

## 🚀 Getting Started

1. **Setup Oracle 21c** on your system
2. **Run the initialization script** to create the pluggable database
3. **Execute the DDL commands** to establish table structures
4. **Populate sample data** with the provided DML statements
5. **Create users and permissions** using the DCL commands
6. **Start exploring** with the sample queries

## 📚 Documentation

Complete technical documentation includes:
- Entity-Relationship Diagrams
- SQL Schema Definitions
- Sample Query Collection
- User Permission Guidelines

## 🔒 Security Features

- Password-protected database accounts
- Schema-level access control
- Query-level permissions
- Data encryption capabilities

---

<div align="center">
  <p><i>Developed with  for Database Management Systems Course</i></p>
  <p>© 2025 Ndizeye Alain | All Rights Reserved</p>
</div>
