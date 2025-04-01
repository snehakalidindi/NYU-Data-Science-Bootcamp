-- Create table statements

CREATE TABLE SALES (
    Date DATE,
    Order_id INTEGER,
    Item_id INTEGER,
    Customer_id INTEGER,
    Quantity INTEGER,
    Revenue REAL
);

CREATE TABLE ITEMS (
    Item_id INTEGER,
    Item_name TEXT,
    Price REAL,
    Department TEXT
);

CREATE TABLE CUSTOMERS (
    Customer_id INTEGER,
    First_name TEXT,
    Last_name TEXT,
    Address TEXT
);

-- Insert sample data

INSERT INTO SALES VALUES ('2023-03-18', 1001, 1, 101, 2, 40);
INSERT INTO SALES VALUES ('2023-03-18', 1002, 2, 102, 1, 60);
INSERT INTO SALES VALUES ('2023-01-05', 1003, 3, 103, 1, 35);
INSERT INTO SALES VALUES ('2023-01-20', 1004, 4, 104, 3, 90);
INSERT INTO SALES VALUES ('2022-11-15', 1005, 5, 105, 2, 50);
INSERT INTO SALES VALUES ('2022-12-01', 1006, 6, 106, 1, 20);
INSERT INTO SALES VALUES ('2023-03-18', 1007, 1, 107, 2, 40);
INSERT INTO SALES VALUES ('2022-10-25', 1008, 4, 108, 1, 30);

INSERT INTO ITEMS VALUES (1, 'Notebook', 20, 'Stationery');
INSERT INTO ITEMS VALUES (2, 'Backpack', 60, 'Bags');
INSERT INTO ITEMS VALUES (3, 'Mouse', 35, 'Electronics');
INSERT INTO ITEMS VALUES (4, 'Pen', 30, 'Stationery');
INSERT INTO ITEMS VALUES (5, 'Mug', 25, 'Kitchenware');
INSERT INTO ITEMS VALUES (6, 'Calendar', 20, 'Stationery');

INSERT INTO CUSTOMERS VALUES (101, 'John', 'Doe', 'NY');
INSERT INTO CUSTOMERS VALUES (102, 'Alice', 'Smith', 'NJ');
INSERT INTO CUSTOMERS VALUES (103, 'Bob', 'White', 'CA');
INSERT INTO CUSTOMERS VALUES (104, 'Charlie', 'Black', 'TX');
INSERT INTO CUSTOMERS VALUES (105, 'Daisy', 'Green', 'FL');
INSERT INTO CUSTOMERS VALUES (106, 'Eva', 'Adams', 'WA');
INSERT INTO CUSTOMERS VALUES (107, 'John', 'Doe', 'IL');
INSERT INTO CUSTOMERS VALUES (108, 'Lily', 'James', 'AZ');

-- Query 1: Total orders completed on 18th March 2023
SELECT COUNT(DISTINCT Order_id) AS total_orders
FROM SALES
WHERE Date = '2023-03-18';

-- Query 2: Orders completed on 18th March 2023 by John Doe
SELECT COUNT(DISTINCT s.Order_id) AS john_doe_orders
FROM SALES s
JOIN CUSTOMERS c ON s.Customer_id = c.Customer_id
WHERE s.Date = '2023-03-18'
  AND c.First_name = 'John'
  AND c.Last_name = 'Doe';

-- Query 3: Customers purchased in Jan 2023 and avg spend
SELECT 
    COUNT(DISTINCT Customer_id) AS total_customers,
    ROUND(SUM(Revenue) / COUNT(DISTINCT Customer_id), 2) AS avg_spend
FROM SALES
WHERE Date BETWEEN '2023-01-01' AND '2023-01-31';

-- Query 4: Departments with < $600 revenue in 2022
SELECT i.Department, SUM(s.Revenue) AS total_revenue
FROM SALES s
JOIN ITEMS i ON s.Item_id = i.Item_id
WHERE s.Date BETWEEN '2022-01-01' AND '2022-12-31'
GROUP BY i.Department
HAVING SUM(s.Revenue) < 600;

-- Query 5: Most and least revenue by an order
SELECT 
    MAX(Revenue) AS most_revenue,
    MIN(Revenue) AS least_revenue
FROM SALES;

-- Query 6: Orders in most lucrative order
SELECT *
FROM SALES
WHERE Revenue = (SELECT MAX(Revenue) FROM SALES);

