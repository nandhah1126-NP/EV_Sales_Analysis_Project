USE ev_project;

SHOW TABLES;
DESCRIBE ev_data;

SELECT *
FROM ev_data
LIMIT 10;

SELECT COUNT(*) AS total_records
FROM ev_data;

SELECT COUNT(DISTINCT brand) AS total_brands
FROM ev_data;

SELECT
    MIN(year) AS earliest_year,
    MAX(year) AS latest_year
FROM ev_data;

SELECT DISTINCT brand
FROM ev_data
ORDER BY brand;

SELECT DISTINCT market_segment
FROM ev_data
ORDER BY market_segment;

SELECT DISTINCT drive_type
FROM ev_data
ORDER BY drive_type;

SELECT
    SUM(brand IS NULL) AS missing_brand,
    SUM(model IS NULL) AS missing_model,
    SUM(price_usd IS NULL) AS missing_price,
    SUM(battery_capacity_kwh IS NULL) AS missing_battery,
    SUM(annual_sales_units IS NULL) AS missing_sales,
    SUM(customer_rating IS NULL) AS missing_rating
FROM ev_data;

SELECT
    brand,
    model,
    year,
    variant,
    COUNT(*) AS duplicate_count
FROM ev_data
GROUP BY brand, model, year, variant
HAVING COUNT(*) > 1;

SELECT
    brand,
    model,
    year,
    variant,
    price_usd,
    battery_capacity_kwh,
    range_miles,
    annual_sales_units,
    COUNT(*) AS duplicate_count
FROM ev_data
GROUP BY
    brand,
    model,
    year,
    variant,
    price_usd,
    battery_capacity_kwh,
    range_miles,
    annual_sales_units
HAVING COUNT(*) > 1;

SELECT
    COALESCE(SUM(duplicate_count - 1), 0) AS extra_duplicate_rows
FROM (
    SELECT
        brand,
        model,
        year,
        variant,
        price_usd,
        battery_capacity_kwh,
        range_miles,
        annual_sales_units,
        COUNT(*) AS duplicate_count
    FROM ev_data
    GROUP BY
        brand,
        model,
        year,
        variant,
        price_usd,
        battery_capacity_kwh,
        range_miles,
        annual_sales_units
    HAVING COUNT(*) > 1
) AS duplicates;

DROP TABLE IF EXISTS ev_data_backup;

CREATE TABLE ev_data_backup AS
SELECT *
FROM ev_data;

DROP TABLE IF EXISTS ev_data_clean;

CREATE TABLE ev_data_clean AS
SELECT DISTINCT *
FROM ev_data;

SELECT COUNT(*) AS clean_total_records
FROM ev_data_clean;

SELECT
    brand,
    SUM(annual_sales_units) AS total_sales
FROM ev_data_clean
GROUP BY brand
ORDER BY total_sales DESC;

SELECT
    brand,
    model,
    SUM(annual_sales_units) AS total_sales
FROM ev_data_clean
GROUP BY brand, model
ORDER BY total_sales DESC
LIMIT 10;

SELECT
    country_of_origin,
    SUM(annual_sales_units) AS total_sales
FROM ev_data_clean
GROUP BY country_of_origin
ORDER BY total_sales DESC;

SELECT
    brand,
    AVG(price_usd) AS avg_price
FROM ev_data_clean
GROUP BY brand
ORDER BY avg_price DESC;

SELECT
    market_segment,
    SUM(annual_sales_units) AS total_sales
FROM ev_data_clean
GROUP BY market_segment
ORDER BY total_sales DESC;

SELECT
    brand,
    AVG(customer_rating) AS avg_rating
FROM ev_data_clean
GROUP BY brand
ORDER BY avg_rating DESC;

SELECT
    brand,
    model,
    range_miles
FROM ev_data_clean
ORDER BY range_miles DESC
LIMIT 10;

SELECT
    brand,
    model,
    price_usd
FROM ev_data_clean
ORDER BY price_usd DESC
LIMIT 10;

SELECT
    brand,
    AVG(battery_capacity_kwh) AS avg_battery_capacity
FROM ev_data_clean
GROUP BY brand
ORDER BY avg_battery_capacity DESC;

SELECT
    brand,
    AVG(charging_speed_kw) AS avg_charging_speed
FROM ev_data_clean
GROUP BY brand
ORDER BY avg_charging_speed DESC;

SELECT
    drive_type,
    COUNT(*) AS total_cars
FROM ev_data_clean
GROUP BY drive_type
ORDER BY total_cars DESC;

SELECT
    market_segment,
    AVG(range_miles) AS avg_range
FROM ev_data_clean
GROUP BY market_segment
ORDER BY avg_range DESC;

SELECT
    market_segment,
    AVG(customer_rating) AS avg_rating
FROM ev_data_clean
GROUP BY market_segment
ORDER BY avg_rating DESC;

SELECT
    brand,
    AVG(horsepower) AS avg_horsepower
FROM ev_data_clean
GROUP BY brand
ORDER BY avg_horsepower DESC;

SELECT
    body_type,
    AVG(price_usd) AS avg_price
FROM ev_data_clean
GROUP BY body_type
ORDER BY avg_price DESC;

SELECT *
FROM ev_data_clean
WHERE brand = 'Tesla';

SELECT COUNT(*) AS tesla_cars
FROM ev_data_clean
WHERE brand = 'Tesla';

SELECT *
FROM ev_data_clean
WHERE year = 2025;

SELECT COUNT(*) AS cars_2025
FROM ev_data_clean
WHERE year = 2025;

SELECT brand, model, price_usd
FROM ev_data_clean
WHERE price_usd > 100000;

SELECT brand, model, price_usd
FROM ev_data_clean
WHERE price_usd < 50000;

SELECT brand, model, range_miles
FROM ev_data_clean
WHERE range_miles > 350;

SELECT brand, model, battery_capacity_kwh
FROM ev_data_clean
WHERE battery_capacity_kwh > 100;

SELECT brand, model, drive_type
FROM ev_data_clean
WHERE drive_type = 'AWD';

SELECT brand, model, customer_rating
FROM ev_data_clean
WHERE customer_rating > 4.5;

SELECT brand, model, year
FROM ev_data_clean
WHERE brand = 'Tesla'
  AND year > 2023;

SELECT brand, model, price_usd, range_miles
FROM ev_data_clean
WHERE price_usd > 80000
  AND range_miles > 350;

SELECT brand, model
FROM ev_data_clean
WHERE brand = 'Tesla'
   OR brand = 'BMW';

SELECT brand, model, drive_type
FROM ev_data_clean
WHERE NOT drive_type = 'AWD';


SELECT brand, model, year, price_usd
FROM ev_data_clean
WHERE brand IN ('Tesla', 'BMW', 'Audi');

SELECT brand, COUNT(*) AS total_models
FROM ev_data_clean
WHERE brand IN ('Tesla', 'BMW', 'Audi')
GROUP BY brand;

SELECT brand, SUM(annual_sales_units) AS total_sales
FROM ev_data_clean
WHERE brand IN ('Tesla', 'BMW', 'Audi')
GROUP BY brand
ORDER BY total_sales DESC;

SELECT brand, AVG(price_usd) AS avg_price
FROM ev_data_clean
WHERE brand IN ('Tesla', 'BMW', 'Audi')
GROUP BY brand
ORDER BY avg_price DESC;


SELECT brand, model, price_usd
FROM ev_data_clean
WHERE price_usd BETWEEN 50000 AND 100000
ORDER BY price_usd;

SELECT COUNT(*) AS total_cars
FROM ev_data_clean
WHERE price_usd BETWEEN 50000 AND 100000;

SELECT brand, model, battery_capacity_kwh
FROM ev_data_clean
WHERE battery_capacity_kwh BETWEEN 80 AND 120;

SELECT COUNT(*) AS total_cars
FROM ev_data_clean
WHERE battery_capacity_kwh BETWEEN 80 AND 120;

SELECT brand, model, customer_rating
FROM ev_data_clean
WHERE customer_rating BETWEEN 4.5 AND 5.0
ORDER BY customer_rating DESC;

SELECT brand, model, year
FROM ev_data_clean
WHERE year BETWEEN 2023 AND 2025
ORDER BY year;


SELECT DISTINCT brand
FROM ev_data_clean
WHERE brand LIKE 'T%';

SELECT DISTINCT brand
FROM ev_data_clean
WHERE brand LIKE '%a';

SELECT brand, model
FROM ev_data_clean
WHERE model LIKE '%Model%';

SELECT brand, model
FROM ev_data_clean
WHERE brand LIKE 'B%';

SELECT brand, model
FROM ev_data_clean
WHERE model LIKE '%3';

SELECT COUNT(*) AS tesla_models
FROM ev_data_clean
WHERE brand LIKE 'Tesla';

SELECT DISTINCT brand
FROM ev_data_clean
WHERE brand LIKE '_e%';


SELECT brand, SUM(annual_sales_units) AS total_sales
FROM ev_data_clean
GROUP BY brand
HAVING SUM(annual_sales_units) > 10000000
ORDER BY total_sales DESC;

SELECT brand, COUNT(*) AS total_models
FROM ev_data_clean
GROUP BY brand
HAVING COUNT(*) > 50
ORDER BY total_models DESC;

SELECT brand, AVG(price_usd) AS avg_price
FROM ev_data_clean
GROUP BY brand
HAVING AVG(price_usd) > 80000
ORDER BY avg_price DESC;

SELECT brand, COUNT(*) AS total_cars
FROM ev_data_clean
WHERE year >= 2024
GROUP BY brand
HAVING COUNT(*) > 20
ORDER BY total_cars DESC;


SELECT
    brand,
    model,
    price_usd,
    CASE
        WHEN price_usd < 50000 THEN 'Budget'
        WHEN price_usd BETWEEN 50000 AND 100000 THEN 'Mid Range'
        ELSE 'Luxury'
    END AS price_category
FROM ev_data_clean;

SELECT
    brand,
    model,
    customer_rating,
    CASE
        WHEN customer_rating >= 4.5 THEN 'Excellent'
        WHEN customer_rating >= 4.0 THEN 'Good'
        ELSE 'Average'
    END AS rating_category
FROM ev_data_clean;

SELECT
    CASE
        WHEN price_usd < 50000 THEN 'Budget'
        WHEN price_usd BETWEEN 50000 AND 100000 THEN 'Mid Range'
        ELSE 'Luxury'
    END AS price_category,
    COUNT(*) AS total_cars
FROM ev_data_clean
GROUP BY price_category
ORDER BY total_cars DESC;


SELECT brand, model, price_usd
FROM ev_data_clean
WHERE price_usd > (
    SELECT AVG(price_usd)
    FROM ev_data_clean
);

SELECT brand, model, price_usd
FROM ev_data_clean
WHERE price_usd = (
    SELECT MAX(price_usd)
    FROM ev_data_clean
);

SELECT brand, model, customer_rating
FROM ev_data_clean
WHERE customer_rating = (
    SELECT MAX(customer_rating)
    FROM ev_data_clean
);

SELECT brand, model, battery_capacity_kwh
FROM ev_data_clean
WHERE battery_capacity_kwh = (
    SELECT MAX(battery_capacity_kwh)
    FROM ev_data_clean
);


SELECT
    brand,
    model,
    annual_sales_units,
    ROW_NUMBER() OVER (
        ORDER BY annual_sales_units DESC
    ) AS row_num
FROM ev_data_clean;

SELECT
    brand,
    model,
    annual_sales_units,
    RANK() OVER (
        ORDER BY annual_sales_units DESC
    ) AS sales_rank
FROM ev_data_clean;

SELECT
    brand,
    model,
    annual_sales_units,
    dense_rank() OVER (
        ORDER BY annual_sales_units DESC
    ) AS dense__rank
FROM ev_data_clean;


SELECT *
FROM (
    SELECT
        brand,
        model,
        annual_sales_units,
        DENSE_RANK() OVER (
            ORDER BY annual_sales_units DESC
        ) AS rnk
    FROM ev_data_clean
) AS ranked_cars
WHERE rnk <= 5;


WITH BrandPrice AS (
    SELECT
        brand,
        AVG(price_usd) AS avg_price
    FROM ev_data_clean
    GROUP BY brand
)
SELECT *
FROM BrandPrice
WHERE avg_price > 80000
ORDER BY avg_price DESC;

WITH BrandSales AS (
    SELECT
        brand,
        SUM(annual_sales_units) AS total_sales
    FROM ev_data_clean
    GROUP BY brand
)
SELECT *
FROM BrandSales
WHERE total_sales > 10000000
ORDER BY total_sales DESC;
