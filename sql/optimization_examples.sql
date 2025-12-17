-- Query optimization examples for Sales & Revenue SQL Analysis
-- SQL Server (T-SQL)

-- Example: Revenue calculation

-- Before (less optimal)
-- Uses implicit join syntax, which is harder to read and easier to misuse
SELECT 
    SUM(quantity * unit_price) AS total_revenue
FROM order_items, orders
WHERE order_items.order_id = orders.order_id;

-- After (optimized)
-- Uses explicit JOIN syntax, improving readability and reducing the risk of incorrect results
SELECT 
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id;

-- Production note:
-- In a real production environment, creating indexes on foreign key columns
-- such as order_items.order_id would further improve query performance.
