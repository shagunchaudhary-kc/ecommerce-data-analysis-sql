/* 
===========================================
E-COMMERCE PRODUCT ANALYSIS (SQL PROJECT)
Dataset: Smartwatch / Fitness Tracker Products
Database: ecommerce
Author: Shagun Chaudhary
===========================================
*/

-- Use the database
USE ecommerce;

-- -----------------------------------------
-- 1. DATA OVERVIEW
-- -----------------------------------------

-- Total number of products
SELECT COUNT(*) AS total_products
FROM ecommerce;

-- Table structure
DESCRIBE ecommerce;

-- -----------------------------------------
-- 2. DATA CLEANING (Using transformations)
-- Prices are stored as TEXT, so we clean them
-- -----------------------------------------

-- Preview cleaned prices
SELECT
  `Brand Name`,
  `Model Name`,
  REPLACE(`Original Price`, ',', '') + 0 AS original_price,
  REPLACE(`Selling Price`, ',', '') + 0 AS selling_price
FROM ecommerce
LIMIT 10;

-- -----------------------------------------
-- 3. BRAND ANALYSIS
-- -----------------------------------------

-- Number of products by brand
SELECT
  `Brand Name`,
  COUNT(*) AS product_count
FROM ecommerce
GROUP BY `Brand Name`
ORDER BY product_count DESC;

-- Average selling price by brand
SELECT
  `Brand Name`,
  AVG(REPLACE(`Selling Price`, ',', '') + 0) AS avg_selling_price
FROM ecommerce
GROUP BY `Brand Name`
ORDER BY avg_selling_price DESC;

-- -----------------------------------------
-- 4. PRICING & DISCOUNT ANALYSIS
-- -----------------------------------------

-- Top discounted products (absolute discount)
SELECT
  `Brand Name`,
  `Model Name`,
  (REPLACE(`Original Price`, ',', '') + 0 -
   REPLACE(`Selling Price`, ',', '') + 0) AS discount_amount
FROM ecommerce
ORDER BY discount_amount DESC
LIMIT 10;

-- Discount percentage
SELECT
  `Brand Name`,
  `Model Name`,
  ROUND(
    (
      (REPLACE(`Original Price`, ',', '') + 0 -
       REPLACE(`Selling Price`, ',', '') + 0)
      /
      (REPLACE(`Original Price`, ',', '') + 0)
    ) * 100, 2
  ) AS discount_percentage
FROM ecommerce
ORDER BY discount_percentage DESC
LIMIT 10;

-- -----------------------------------------
-- 5. RATING ANALYSIS
-- -----------------------------------------

-- Average rating by brand
SELECT
  `Brand Name`,
  AVG(`Rating (Out of 5)`) AS avg_rating
FROM ecommerce
GROUP BY `Brand Name`
ORDER BY avg_rating DESC;

-- Top rated products
SELECT
  `Brand Name`,
  `Model Name`,
  `Rating (Out of 5)`
FROM ecommerce
ORDER BY `Rating (Out of 5)` DESC
LIMIT 10;

-- -----------------------------------------
-- 6. BATTERY LIFE ANALYSIS
-- -----------------------------------------

-- Average battery life by brand
SELECT
  `Brand Name`,
  AVG(`Average Battery Life (in days)`) AS avg_battery_life
FROM ecommerce
GROUP BY `Brand Name`
ORDER BY avg_battery_life DESC;

-- -----------------------------------------
-- 7. FEATURE ANALYSIS
-- -----------------------------------------

-- Display type distribution
SELECT
  Display,
  COUNT(*) AS product_count
FROM ecommerce
GROUP BY Display
ORDER BY product_count DESC;

-- Strap material popularity
SELECT
  `Strap Material`,
  COUNT(*) AS product_count
FROM ecommerce
GROUP BY `Strap Material`
ORDER BY product_count DESC;

-- -----------------------------------------
-- 8. ADVANCED ANALYSIS (SUBQUERY)
-- -----------------------------------------

-- Products priced above average selling price
SELECT *
FROM ecommerce
WHERE (REPLACE(`Selling Price`, ',', '') + 0) >
(
  SELECT AVG(REPLACE(`Selling Price`, ',', '') + 0)
  FROM ecommerce
);

-- -----------------------------------------
-- 9. CREATE VIEW FOR CLEAN ANALYSIS
-- -----------------------------------------

CREATE VIEW ecommerce_clean AS
SELECT
  `Brand Name`,
  `Device Type`,
  `Model Name`,
  Color,
  REPLACE(`Original Price`, ',', '') + 0 AS original_price,
  REPLACE(`Selling Price`, ',', '') + 0 AS selling_price,
  Display,
  `Rating (Out of 5)` AS rating,
  `Strap Material`,
  `Average Battery Life (in days)` AS battery_life
FROM ecommerce;

-- Use the view
SELECT * FROM ecommerce_clean LIMIT 10;
