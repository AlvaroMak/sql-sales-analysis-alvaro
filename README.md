# Sales & Revenue SQL Analysis
## SQL Project by Álvaro Martínez

> All queries are written using Microsoft SQL Server (T-SQL) syntax.

This project demonstrates my ability to work with SQL to analyze sales performance, identify revenue trends, and extract actionable insights through data exploration, aggregations, and query optimization.

It includes:

- Creation of a relational database schema
- Data exploration using SQL
- Business KPIs (revenue, top products, customer value, etc.)
- Complex queries with joins, window functions, and CTEs
- Query optimization examples
- Insights that can support decision-making

### 📊 Dataset

A synthetic dataset modeled after a typical retail/e-commerce environment, including:

- customers
- products
- orders
- order_items

This dataset simulates real business scenarios such as recurring customers, product performance, seasonal variation, and order breakdowns.

### 🧱 Database Schema

```text
customers(customer_id, customer_name, region)
products(product_id, product_name, category, price)
orders(order_id, customer_id, order_date)
order_items(order_item_id, order_id, product_id, quantity, unit_price)
```

### ▶️ How to Reproduce the Analysis

1. Create the database schema using the `schema.sql` script.
2. Load the CSV files located in the `/data` folder into the corresponding tables.
3. Execute the queries in `analysis_queries.sql` to reproduce the analysis.


### 🔍 SQL Queries & Analysis

1. Total Revenue

```sql
SELECT SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM order_items oi
```

2. Top 5 Best-Selling Products
```sql   
SELECT p.product_name,
       SUM(oi.quantity) AS units_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY units_sold DESC
LIMIT 5;
```
3. Revenue by Product Category
```sql   
SELECT p.category,
       SUM(oi.quantity * oi.unit_price) AS revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY revenue DESC;
```
4. Monthly Revenue Trend
```sql   
WITH revenue_by_month AS (
    SELECT 
        DATEFROMPARTS(YEAR(o.order_date), MONTH(o.order_date), 1) AS month,
        SUM(oi.quantity * oi.unit_price) AS revenue
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY 
        YEAR(o.order_date), 
        MONTH(o.order_date)
)
SELECT *
FROM revenue_by_month
ORDER BY month;
```
5. Customer Lifetime Value (CLV)
```sql   
SELECT c.customer_name,
       SUM(oi.quantity * oi.unit_price) AS lifetime_value
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_name
ORDER BY lifetime_value DESC;
```
🛠 Query Optimization Example (Query Simplification)

Before (less optimal)
```sql
SELECT SUM(quantity * unit_price)
FROM order_items;
```
After (optimized)
```sql
SELECT SUM(oi.quantity * oi.unit_price)
FROM order_items oi;
```
> In a production environment, additional optimizations could be applied, such as creating indexes on foreign key columns (e.g., `order_items.order_id`) to further improve query performance and reduce execution time.

Improvement:

- Uses explicit JOIN → better clarity
- Allows the query planner to optimize execution
- Reduces risk of accidental cartesian products

### 🧠 Insights & Business Impact

From this analysis, we can identify:

- Top revenue-generating products
- Seasonal sales patterns
- High-value customer segments
- Low-performing categories
- Opportunities for promotions or inventory optimization

### 📂 Repository Structure
```text
/data
  customers.csv
  orders.csv
  products.csv
  order_items.csv

/sql
  schema.sql
  analysis_queries.sql
  optimization_examples.sql

README.md
```
### 👤 About Me

I am an Application Support Specialist and SQL Analyst with 13+ years of experience in enterprise environments, currently transitioning into data-focused roles with a strong emphasis on SQL, reporting, and analytics. 
You can connect with me on LinkedIn:  
https://linkedin.com/in/alvaro-martinez-k
