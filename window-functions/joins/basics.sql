-- SQL JOINs - Basics
-- Author: Łukasz Kobak
-- Database: PostgreSQL / Oracle SQL Plus compatible

-- =============================================
-- TEST DATA
-- =============================================

CREATE TABLE employees (
    employee_id INT,
    name VARCHAR(50),
    department VARCHAR(50),
    salary INT
);

CREATE TABLE departments (
    department_id INT,
    department_name VARCHAR(50),
    location VARCHAR(50)
);

INSERT INTO employees VALUES (1, 'Anna', 'IT', 5000);
INSERT INTO employees VALUES (2, 'Piotr', 'HR', 4000);
INSERT INTO employees VALUES (3, 'Kasia', 'IT', 6000);
INSERT INTO employees VALUES (4, 'Marek', 'Finance', 4500);
INSERT INTO employees VALUES (5, 'Tomek', 'HR', 3500);
INSERT INTO employees VALUES (6, 'Ola', 'IT', 5500);
INSERT INTO employees VALUES (7, 'Bartek', NULL, 4000);

INSERT INTO departments VALUES (1, 'IT', 'Warsaw');
INSERT INTO departments VALUES (2, 'HR', 'Krakow');
INSERT INTO departments VALUES (3, 'Finance', 'Wroclaw');
INSERT INTO departments VALUES (4, 'Marketing', 'Warsaw');

-- =============================================
-- INNER JOIN
-- =============================================

-- Show employees with their department location
-- Excludes employees without a department (Bartek)
SELECT e.employee_id, e.name, d.department_name, d.location
FROM employees e
INNER JOIN departments d ON e.department = d.department_name;

-- =============================================
-- LEFT JOIN
-- =============================================

-- Show ALL employees, including those without a department
-- Bartek appears with NULL values for department columns
SELECT e.employee_id, e.name, d.department_name, d.location
FROM employees e
LEFT JOIN departments d ON e.department = d.department_name;

-- Find employees WITHOUT a department assigned
SELECT e.employee_id, e.name
FROM employees e
LEFT JOIN departments d ON e.department = d.department_name
WHERE d.department_id IS NULL;
