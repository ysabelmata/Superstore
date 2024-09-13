-------Identificar y manejar datos discrepantes en variables categóricas----------
----------Query para valores únicos por cada variable categórica--------------
SELECT DISTINCT category FROM `Dataset.superstore`
UNION ALL
SELECT DISTINCT city FROM `Dataset.superstore`
UNION ALL
SELECT DISTINCT country FROM `Dataset.superstore`
UNION ALL
SELECT DISTINCT market FROM `Dataset.superstore`
UNION ALL
SELECT DISTINCT region FROM `Dataset.superstore`
UNION ALL
SELECT DISTINCT segment FROM `Dataset.superstore`
UNION ALL
SELECT DISTINCT ship_mode FROM `Dataset.superstore`
UNION ALL
SELECT DISTINCT state FROM `Dataset.superstore`
UNION ALL
SELECT DISTINCT sub_category FROM `Dataset.superstore`
UNION ALL
SELECT DISTINCT market2 FROM `Dataset.superstore`;


----------Query para detectar valores atípicos----------
SELECT
 customer_id,
 category,
 city,
 country,
 market,
 region,
 segment,
 ship_mode,
 state,
 sub_category,
 market2
FROM
 `Dataset.superstore`
WHERE
 category IS NULL OR category = 'unknown'
 OR city IS NULL OR city = 'unknown'
 OR country IS NULL OR country = 'unknown'
 OR market IS NULL OR market = 'unknown'
 OR region IS NULL OR region = 'unknown'
 OR segment IS NULL OR segment = 'unknown'
 OR ship_mode IS NULL OR ship_mode = 'unknown'
 OR state IS NULL OR state = 'unknown'
 OR sub_category IS NULL OR sub_category = 'unknown'
 OR market2 IS NULL OR market2 = 'unknown';


------------Query valores atipicos categoria----------
SELECT
 category,
 COUNT(*) AS count
FROM
 `Dataset.superstore`
GROUP BY
 category
HAVING
 category IS NULL OR category = 'unknown'
ORDER BY
 count DESC;


---------------DUPLICADOS_______________
SELECT
CATEGORY,
city ,
country,
customer_ID ,
customer_name ,
discount,
market,
unknown,
order_date,
order_id,
order_priority,
product_id,
product_name,
profit,
quantity,
region,
row_id,
sales,
segment,
ship_date,
ship_mode,
shipping_cost,
state,
sub_category,
year,
market2,
weeknum,
COUNT(*) AS count_duplicates
FROM
 `Dataset.superstore`
GROUP BY
  CATEGORY,
city ,
country,
customer_ID ,
customer_name ,
discount,
market,
unknown,
order_date,
order_id,
order_priority,
product_id,
product_name,
profit,
quantity,
region,
row_id,
sales,
segment,
ship_date,
ship_mode,
shipping_cost,
state,
sub_category,
year,
market2,
weeknum
HAVING
 COUNT(*) > 1
ORDER BY
 count_duplicates DESC;
------------duplicados para product_id-----------------
select product_id,
COUNT(*) AS count_duplicates
from `Dataset.superstore`
group by product_id
HAVING
 COUNT(*) > 1


ORDER BY
 count_duplicates DESC;
------------duplicados para product_id. 8872 duplicados-----------------
select product_id,
COUNT(*) AS count_duplicates
from `Dataset.superstore`
group by product_id
HAVING
 COUNT(*) > 1


ORDER BY
 count_duplicates DESC;
------------10292 productos---------------
select distinct product_id
from `Dataset.superstore`


----------duplicados por cliente----------
SELECT customer_id, COUNT(*)
FROM `Dataset.clientes`
GROUP BY customer_id
HAVING COUNT(*) > 1;


------duplicados por ordenes-----------


SELECT order_id, COUNT(*)
FROM `Dataset.ordenes`
GROUP BY order_id
HAVING COUNT(*) > 1;


----------------NULOS-----------------
SELECT
COUNTIF(CATEGORY IS NULL) AS NULL_CATEGORY,
COUNTIF(city IS NULL) AS NULL_city,
COUNTIF(country IS NULL) AS NULL_country,
COUNTIF(customer_ID IS NULL) AS NULL_customer_ID,
COUNTIF(customer_name IS NULL) AS NULL_customer_name,
COUNTIF(discount IS NULL) AS NULL_discount,
COUNTIF(market IS NULL) AS NULL_market,
COUNTIF(unknown IS NULL) AS NULL_unknown,
COUNTIF(order_date IS NULL) AS NULL_order_date,
COUNTIF(order_id IS NULL) AS NULL_order_id,
COUNTIF(order_priority IS NULL) AS NULL_order_priority,
COUNTIF(product_id IS NULL) AS NULL_product_id,
COUNTIF(product_name IS NULL) AS NULL_product_name,
COUNTIF(profit IS NULL) AS NULL_profit,
COUNTIF(quantity IS NULL) AS NULL_quantity,
COUNTIF(region IS NULL) AS NULL_region,
COUNTIF(row_id IS NULL) AS NULL_row_id,
COUNTIF(sales IS NULL) AS NULL_sales,
COUNTIF(segment IS NULL) AS NULL_segment,
COUNTIF(ship_date IS NULL) AS NULL_ship_date,
COUNTIF(ship_mode IS NULL) AS NULL_ship_mode,
COUNTIF(shipping_cost IS NULL) AS NULL_shipping_cost,
COUNTIF(state IS NULL) AS NULL_state,
COUNTIF(sub_category IS NULL) AS NULL_sub_category,
COUNTIF(year IS NULL) AS NULL_year,
COUNTIF(market2 IS NULL) AS NULL_market2,
COUNTIF(weeknum IS NULL) AS NULL_weeknum
FROM `Dataset.superstore`


---------------query para crear tabla categorias--------------------------
CREATE OR REPLACE TABLE `Dataset.categorias` AS
WITH categorias_distinct AS (
    SELECT DISTINCT
        category AS categoria,
    FROM `Dataset.superstore`
)
SELECT 
    ROW_NUMBER() OVER() AS id_categoria,  -- Autoincremental basado en ROW_NUMBER
    categoria,
FROM categorias_distinct;


---------------query para crear tabla subcategorias--------------------------
CREATE OR REPLACE TABLE `Dataset.subcategorias` AS
WITH subcategorias_distinct AS (
    SELECT DISTINCT
        sub_category AS subcategoria,
    FROM `Dataset.superstore`
)
SELECT 
    ROW_NUMBER() OVER() AS id_subcategoria,  -- Autoincremental basado en ROW_NUMBER
    subcategoria,
FROM subcategorias_distinct;

-----------------query para crear tabla clientes--------------------
CREATE OR REPLACE TABLE `Dataset.clientes` AS
SELECT DISTINCT
    customer_id,
    customer_name,
    segment
FROM `Dataset.superstore`;

-----------------------query para crear tablas productos-----------------10292
CREATE OR REPLACE TABLE `Dataset.productos` AS
WITH productos_unicos AS (
    SELECT 
        product_id,
        MIN(product_name) AS product_name,  -- Obtenemos solo uno de los nombres de producto (puede ser MIN o MAX)
        MIN(c.id_categoria) AS id_categoria,  -- Escogemos una categoría para cada product_id
        MIN(sc.id_subcategoria) AS id_subcategoria,  -- Escogemos una subcategoría para cada product_id  
    FROM `Dataset.superstore` s
    JOIN `Dataset.categorias` c
    ON category = c.categoria
    JOIN `Dataset.subcategorias` sc
    ON sub_category = sc.subcategoria
    GROUP BY product_id  -- Agrupamos por product_id para obtener uno único
)
SELECT
    product_id,
    product_name,
    id_categoria ,
    id_subcategoria
FROM productos_unicos
ORDER BY id_categoria;


-----51290--------
select order_id
from `Dataset.superstore`


-- Crear la tabla `ordenes` 
CREATE TABLE `Dataset.ordenes` AS
    SELECT 
        order_id,
        DATE(order_date) AS order_date,
        order_priority,
        product_id,
        quantity,
        sales,
        profit,
        discount,
        city,
        region,
        DATE(ship_date) AS ship_date,
        ship_mode,
        shipping_cost
    FROM `Dataset.superstore` ;
    

--------------query para crear tabla ventas_superstore. 25754----------------------
CREATE OR REPLACE TABLE `Dataset.ventas_superstore` AS
WITH order_product_agg AS (
    SELECT 
        CONCAT(s.order_id, '-', c.customer_id) AS id_venta,
        s.order_id,
        MAX(o.order_date) AS order_date,
        c.customer_id,
        ARRAY_TO_STRING(ARRAY_AGG(DISTINCT CAST(p.product_id AS STRING)), ', ') AS product_ids,
        SUM(s.sales) AS total_sales,
        SUM(s.profit) AS total_profit,
        SUM(s.quantity) AS total_quantity,
        AVG(s.discount) AS avg_discount,
        s.country,
        s.state,
        INITCAP(LOWER(s.market)) AS market,
        s.year,
        s.weeknum
    FROM `Dataset.superstore` s
    JOIN `Dataset.clientes` c ON s.customer_id = c.customer_id
    JOIN `Dataset.productos` p ON s.product_id = p.product_id
    JOIN `Dataset.ordenes` o ON s.order_id = o.order_id
    WHERE c.customer_id IS NOT NULL
    AND p.product_id IS NOT NULL
    AND o.order_id IS NOT NULL
    GROUP BY s.order_id, c.customer_id, s.country, s.state, s.market, s.year, s.weeknum
)
SELECT DISTINCT * FROM order_product_agg;


--------Medidas de tendencia central-------
SELECT
 MIN(sales) AS min_sales,
 MAX(sales) AS max_sales,
 AVG(sales) AS avg_sales,
 STDDEV(sales) AS stddev_sales
FROM
 `Dataset.superstore`;


-------------------outliers-----------------------
WITH quartiles AS (
SELECT
  APPROX_QUANTILES(SALES, 4)[OFFSET(1)] AS Q1_SALES,
  APPROX_QUANTILES(SALES, 4)[OFFSET(3)] AS Q3_SALES
FROM
  `Dataset.superstore`
),
iqr AS (
SELECT
  Q1_SALES,
  Q3_SALES,
  (Q3_SALES - Q1_SALES) AS IQR_SALES
FROM
  quartiles
),
bounds AS (
SELECT
  Q1_SALES,
  Q3_SALES,
  IQR_SALES,
  Q1_SALES - 1.5 * IQR_SALES AS lower_bound,
  Q3_SALES + 1.5 * IQR_SALES AS upper_bound
FROM
  iqr
)
SELECT
*,
'Above Upper Bound' AS SALES_outlier_status
FROM
`Dataset.superstore` AS superstore,
bounds
WHERE
SALES > bounds.upper_bound
ORDER BY
SALES DESC;


------------------Identificar valores negativos -------------


SELECT
 customer_id,
 sales,
 profit,
 quantity,
 shipping_cost
FROM
 `Dataset.superstore`
WHERE
 sales < 0 OR
 profit < 0 OR
 quantity < 0 OR
 shipping_cost < 0


--------------quartiles--------------------
WITH quantiles AS (
 SELECT
   APPROX_QUANTILES(sales, 4) AS quartiles
 FROM
  `Dataset.superstore`
)
SELECT
 quartiles[OFFSET(1)] AS q1_sales,   -- Primer cuartil (25%)
 quartiles[OFFSET(2)] AS median_sales, -- Segundo cuartil (50%) o mediana
 quartiles[OFFSET(3)] AS q3_sales    -- Tercer cuartil (75%)
FROM
 quantiles;