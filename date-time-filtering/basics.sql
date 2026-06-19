-- SQL Date/Time Filtering - Basics
-- Author: Łukasz Kobak
-- Database: Oracle SQL Plus / PostgreSQL compatible

-- =============================================
-- TEST DATA
-- =============================================

CREATE TABLE support_tickets (
    ticket_id INT,
    status VARCHAR(50),
    priority VARCHAR(50),
    created_at TIMESTAMP
);

INSERT INTO support_tickets VALUES (1, 'Open', 'High', NOW() - INTERVAL '10 minutes');
INSERT INTO support_tickets VALUES (2, 'Resolved', 'Low', NOW() - INTERVAL '2 hours');
INSERT INTO support_tickets VALUES (3, 'Open', 'High', NOW() - INTERVAL '45 minutes');
INSERT INTO support_tickets VALUES (4, 'In Progress', 'Medium', NOW() - INTERVAL '20 minutes');
INSERT INTO support_tickets VALUES (5, 'Open', 'High', NOW() - INTERVAL '3 days');
INSERT INTO support_tickets VALUES (6, 'Resolved', 'Medium', NOW() - INTERVAL '6 hours');

-- =============================================
-- FILTERING BY TIME WINDOW
-- =============================================

-- Tickets created in the last hour
-- Oracle:     created_at > SYSDATE - INTERVAL '1' HOUR
-- PostgreSQL: created_at > NOW() - INTERVAL '1 hour'
SELECT *
FROM support_tickets
WHERE created_at > NOW() - INTERVAL '1 hour'
ORDER BY created_at DESC;

-- Tickets created in the last 24 hours
SELECT *
FROM support_tickets
WHERE created_at > NOW() - INTERVAL '24 hours'
ORDER BY created_at DESC;

-- Tickets created in the last 7 days
SELECT *
FROM support_tickets
WHERE created_at > NOW() - INTERVAL '7 days'
ORDER BY created_at DESC;

-- =============================================
-- INTERVAL REFERENCE (Oracle vs PostgreSQL)
-- =============================================

-- Last 30 minutes:
-- Oracle:     created_at > SYSDATE - INTERVAL '30' MINUTE
-- PostgreSQL: created_at > NOW() - INTERVAL '30 minutes'

-- Last hour:
-- Oracle:     created_at > SYSDATE - INTERVAL '1' HOUR
-- PostgreSQL: created_at > NOW() - INTERVAL '1 hour'

-- Last 24 hours:
-- Oracle:     created_at > SYSDATE - INTERVAL '24' HOUR
-- PostgreSQL: created_at > NOW() - INTERVAL '24 hours'

-- Last 7 days:
-- Oracle:     created_at > SYSDATE - INTERVAL '7' DAY
-- PostgreSQL: created_at > NOW() - INTERVAL '7 days'

-- =============================================
-- WHY THIS MATTERS
-- =============================================

-- Using SYSDATE/NOW() with INTERVAL instead of a hardcoded date
-- means the query always reflects "now" - no manual date updates needed.
-- This is essential for monitoring dashboards, SLA checks, and incident triage.
