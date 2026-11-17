
-- ============================================
-- PROJECT: RetailPulse
-- SECTION: Data Quality Checks
-- DATABASE: Oracle SQL
-- ============================================

-- 1. Check total records in all tables

SELECT 'CUSTOMERS' AS TABLE_NAME, COUNT(*) AS TOTAL_RECORDS
FROM CUSTOMERS
UNION ALL
SELECT 'CATEGORIES', COUNT(*) FROM CATEGORIES
UNION ALL
SELECT 'PRODUCTS', COUNT(*) FROM PRODUCTS
UNION ALL
SELECT 'ORDERS', COUNT(*) FROM ORDERS
UNION ALL
SELECT 'ORDER_DETAILS', COUNT(*) FROM ORDER_DETAILS;


-- 2. Check NULL customer IDs

SELECT *
FROM CUSTOMERS
WHERE CUSTOMER_ID IS NULL;


-- 3. Check duplicate customer IDs

SELECT CUSTOMER_ID, COUNT(*)
FROM CUSTOMERS
GROUP BY CUSTOMER_ID
HAVING COUNT(*) > 1;


-- 4. Check products with invalid prices

SELECT *
FROM PRODUCTS
WHERE UNIT_PRICE <= 0
   OR COST_PRICE <= 0;


-- 5. Check negative stock quantities

SELECT *
FROM PRODUCTS
WHERE STOCK_QUANTITY < 0;


-- 6. Check invalid order statuses

SELECT *
FROM ORDERS
WHERE ORDER_STATUS NOT IN
('Delivered', 'Pending', 'Cancelled');


-- 7. Check invalid payment methods

SELECT *
FROM ORDERS
WHERE PAYMENT_METHOD NOT IN
('Cash', 'Credit Card', 'Debit Card', 'UPI');


-- 8. Check invalid order quantities

SELECT *
FROM ORDER_DETAILS
WHERE QUANTITY <= 0;


-- 9. Check negative discounts

SELECT *
FROM ORDER_DETAILS
WHERE DISCOUNT_AMOUNT < 0;


-- 10. Check orders outside 2025

SELECT *
FROM ORDERS
WHERE ORDER_DATE < DATE '2025-01-01'
   OR ORDER_DATE >= DATE '2026-01-01';


-- 11. Check orders without matching customers

SELECT O.*
FROM ORDERS O
LEFT JOIN CUSTOMERS C
ON O.CUSTOMER_ID = C.CUSTOMER_ID
WHERE C.CUSTOMER_ID IS NULL;


-- 12. Check order details without matching orders

SELECT OD.*
FROM ORDER_DETAILS OD
LEFT JOIN ORDERS O
ON OD.ORDER_ID = O.ORDER_ID
WHERE O.ORDER_ID IS NULL;


-- 13. Check order details without matching products

SELECT OD.*
FROM ORDER_DETAILS OD
LEFT JOIN PRODUCTS P
ON OD.PRODUCT_ID = P.PRODUCT_ID
WHERE P.PRODUCT_ID IS NULL;


-- END OF DATA QUALITY CHECKS
