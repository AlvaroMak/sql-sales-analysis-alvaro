-- Analysis queries for Sales & Revenue SQL Analysis
-- SQL Server (T-SQL)

-- 1. Total Revenue
SELECT 
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM order_items oi;

-- 2. Top 5 Best-Selling Products (by units sold)
SELECT 
    p.product_name,
    SUM(oi.quantity) AS units_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY units_sold DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;

-- 3. Revenue by Product Category
SELECT 
    p.category,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY revenue DESC;

-- 4. Monthly Revenue Trend
SELECT 
    DATEFROMPARTS(YEAR(o.order_date), MONTH(o.order_date), 1) AS month,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY 
    YEAR(o.order_date), 
    MONTH(o.order_date)
ORDER BY month;

-- 5. Customer Lifetime Value (CLV)
SELECT 
    c.customer_name,
    SUM(oi.quantity * oi.unit_price) AS lifetime_value
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_name
ORDER BY lifetime_value DESC;
