
-- SQL Window Functions - Practical Scenarios
-- Author: Łukasz Kobak
-- Database: PostgreSQL / Oracle SQL Plus compatible

-- =============================================
-- SCENARIO 1: Best performer per region
-- =============================================

-- Find the top salesperson in each region
SELECT * FROM (
    SELECT 
        salesperson,
        region,
        amount,
        ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount DESC) AS row_num
    FROM sales
) subquery
WHERE row_num = 1;

-- =============================================
-- SCENARIO 2: Sales vs regional totals
-- =============================================

-- Show each person with their regional total and % contribution
SELECT salesperson, region, amount,
    SUM(amount) OVER (PARTITION BY region) AS region_total,
    ROUND(amount * 100.0 / SUM(amount) OVER (PARTITION BY region), 2) AS pct_of_region
FROM sales;

-- =============================================
-- SCENARIO 3: Period over period comparison
-- =============================================

-- Show previous amount and difference
SELECT salesperson, region, amount,
    LAG(amount) OVER (ORDER BY amount) AS previous_amount,
    amount - LAG(amount) OVER (ORDER BY amount) AS difference
FROM sales;

-- =============================================
-- SCENARIO 4: Ranking + regional average
-- =============================================

-- Combine DENSE_RANK with AVG in one query
SELECT salesperson, region, amount,
    DENSE_RANK() OVER (PARTITION BY region ORDER BY amount DESC) AS ranking,
    AVG(amount) OVER (PARTITION BY region) AS region_avg
FROM sales;

-- =============================================
-- SCENARIO 5: Above/below regional average
-- =============================================

-- Filter only people above their regional average
SELECT * FROM (
    SELECT salesperson, region, amount,
        AVG(amount) OVER (PARTITION BY region) AS region_avg
    FROM sales
) subquery
WHERE amount > region_avg;

-- =============================================
-- SCENARIO 6: Ranking + Above/Below average (CASE WHEN)
-- =============================================

-- Combine ranking with above/below average label
SELECT *,
    CASE 
        WHEN amount > region_avg THEN 'Above'
        WHEN amount < region_avg THEN 'Below'
        ELSE 'Equal'
    END AS vs_average
FROM (
    SELECT salesperson, region, amount,
        DENSE_RANK() OVER (PARTITION BY region ORDER BY amount DESC) AS ranking,
        AVG(amount) OVER (PARTITION BY region) AS region_avg
    FROM sales
) subquery;
