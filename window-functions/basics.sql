-- SQL Window Functions - Basics
-- Author: Łukasz Kobak
-- Database: PostgreSQL / Oracle SQL Plus compatible

-- =============================================
-- TEST DATA
-- =============================================

CREATE TABLE sales (
    id INT,
    salesperson VARCHAR(50),
    region VARCHAR(50),
    amount INT
);

INSERT INTO sales VALUES (1, 'Anna', 'North', 1000);
INSERT INTO sales VALUES (2, 'Piotr', 'North', 1500);
INSERT INTO sales VALUES (3, 'Kasia', 'South', 1200);
INSERT INTO sales VALUES (4, 'Marek', 'South', 900);
INSERT INTO sales VALUES (5, 'Anna', 'South', 1100);
INSERT INTO sales VALUES (6, 'Piotr', 'North', 1800);
INSERT INTO sales VALUES (7, 'Kasia', 'North', 1300);
INSERT INTO sales VALUES (8, 'Marek', 'South', 1600);
INSERT INTO sales VALUES (9, 'Tomek', 'North', 1500);

-- =============================================
-- ROW_NUMBER
-- =============================================

-- Basic ROW_NUMBER - rank all rows by amount
SELECT 
    salesperson,
    region,
    amount,
    ROW_NUMBER() OVER (ORDER BY amount DESC) AS row_num
FROM sales;

-- ROW_NUMBER with PARTITION BY - rank within each region
SELECT 
    salesperson,
    region,
    amount,
    ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount DESC) AS row_num
FROM sales;

-- =============================================
-- RANK vs DENSE_RANK vs ROW_NUMBER
-- =============================================

-- Difference visible when there are ties (same amount)
SELECT 
    salesperson,
    region,
    amount,
    ROW_NUMBER() OVER (ORDER BY amount DESC) AS row_num,
    RANK() OVER (ORDER BY amount DESC) AS rank,
    DENSE_RANK() OVER (ORDER BY amount DESC) AS dense_rank
FROM sales;

-- ROW_NUMBER: always unique (3, 4)
-- RANK: gap after tie (3, 3, 5)
-- DENSE_RANK: no gap (3, 3, 4)

-- =============================================
-- LAG & LEAD
-- =============================================

-- Previous and next amount
SELECT 
    salesperson,
    region,
    amount,
    LAG(amount) OVER (ORDER BY amount) AS previous_amount,
    LEAD(amount) OVER (ORDER BY amount) AS next_amount
FROM sales;

-- Difference between current and previous amount
SELECT 
    salesperson,
    region,
    amount,
    LAG(amount) OVER (ORDER BY amount) AS previous_amount,
    amount - LAG(amount) OVER (ORDER BY amount) AS difference
FROM sales;

-- =============================================
-- SUM & AVG AS WINDOW FUNCTIONS
-- =============================================

-- Regional total and percentage
SELECT 
    salesperson,
    region,
    amount,
    SUM(amount) OVER (PARTITION BY region) AS region_total,
    ROUND(amount * 100.0 / SUM(amount) OVER (PARTITION BY region), 2) AS pct_of_region
FROM sales;

-- Regional average
SELECT 
    salesperson,
    region,
    amount,
    AVG(amount) OVER (PARTITION BY region) AS region_avg
FROM sales;

-- Running total
SELECT 
    salesperson,
    region,
    amount,
    SUM(amount) OVER (ORDER BY amount 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total
FROM sales;
