-- SQL Aggregates - Basics
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

INSERT INTO employees VALUES (1, 'Anna', 'IT', 5000);
INSERT INTO employees VALUES (2, 'Piotr', 'HR', 4000);
INSERT INTO employees VALUES (3, 'Kasia', 'IT', 6000);
INSERT INTO employees VALUES (4, 'Marek', 'Finance', 4500);
INSERT INTO employees VALUES (5, 'Tomek', 'HR', 3500);
INSERT INTO employees VALUES (6, 'Ola', 'IT', 5500);
INSERT INTO employees VALUES (7, 'Bartek', NULL, 4000);

-- =============================================
-- COUNT, SUM, AVG, MIN, MAX
-- =============================================

-- Basic aggregates per department
SELECT department, 
    COUNT(*) AS employee_count,
    SUM(salary) AS total_salary,
    AVG(salary) AS average_salary,
    MIN(salary) AS min_salary,
    MAX(salary) AS max_salary
FROM employees
WHERE department IS NOT NULL
GROUP BY department
ORDER BY average_salary DESC;

-- =============================================
-- HAVING
-- =============================================

-- Departments with more than 1 employee
SELECT department, COUNT(*) AS employee_count
FROM employees
WHERE department IS NOT NULL
GROUP BY department
HAVING COUNT(*) > 1;

-- Departments with average salary above 4500
SELECT department, 
    COUNT(*) AS employee_count,
    AVG(salary) AS average_salary
FROM employees
WHERE department IS NOT NULL
GROUP BY department
HAVING AVG(salary) > 4500
ORDER BY average_salary DESC;

-- =============================================
-- CASE WHEN with GROUP BY
-- =============================================

-- Group employees by salary range
SELECT 
    CASE 
        WHEN salary >= 5000 THEN 'High'
        WHEN salary >= 4000 THEN 'Medium'
        ELSE 'Low'
    END AS salary_range,
    COUNT(*) AS employee_count
FROM employees
GROUP BY 
    CASE 
        WHEN salary >= 5000 THEN 'High'
        WHEN salary >= 4000 THEN 'Medium'
        ELSE 'Low'
    END;
