# Company Database Management System

## Developer Information
- **Student ID:** 26442
- **Name:** Ndizeye Alain
- **Concentration:** Software Engineering

## Problem Statement

This database system addresses the challenge of efficiently managing company resources and operational data across multiple departments. Organizations face difficulties tracking employee information, managing departmental budgets through transaction records, monitoring salary progressions, and overseeing project timelines—all while maintaining data integrity and security.

The Company Database Management System provides a comprehensive solution that enables:

- Centralized management of employee records across departments
- Tracking of financial transactions with employee attribution
- Historical salary data management for budget planning and HR operations
- Project tracking with department associations and timeline monitoring
- Role-based access control to sensitive company information

## Database Structure

The database consists of five primary tables:

1. **Department** - Stores information about company departments
2. **Employee** - Maintains employee records with departmental associations
3. **Transaction_Record** - Tracks financial transactions linked to employees
4. **Salary_History** - Records employee salary changes over time
5. **Project** - Manages project information with departmental ownership

## Entity Relationships

The system maintains several important relationships:
- Each department can have multiple employees
- Departments manage multiple projects
- Employees can perform multiple transactions
- Employees maintain a history of salary records

## Features

- **User Management:** Secure user creation with granular permissions
- **Data Integrity:** Foreign key constraints and data validation
- **Transaction Control:** Savepoints and rollback capabilities
- **Advanced Queries:** Complex data analysis through joins, subqueries, and analytic functions
- **Historical Tracking:** Timeline-based records for salaries and projects

## Implementation Details

The system is implemented in Oracle 21c, utilizing:
- PL/SQL for database operations
- Pluggable database architecture
- DDL, DML, TCL, and DCL operations
- Complex query capabilities with JOIN operations, subqueries, and analytic functions

## Security Features

- Role-based access control
- User-specific privileges
- Password protection for database accounts
