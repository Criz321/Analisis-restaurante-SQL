-- OBJETIVO 1: EXPLORAR LOS ARTÍCULOS DEL MENÚ
-- ---------------------------------------------------

-- 1. Ver todos los artículos del menú
-- (Para familiarizarse con los datos)
SELECT *
FROM menu_items;

-- 2. Encontrar el número total de artículos en el menú
SELECT COUNT(*)
FROM menu_items;


-- 3. ¿Cuáles son los artículos menos y más caros del menú?
SELECT	
	*
FROM menu_items
ORDER BY price DESC;

-- 4. ¿Cuántos platos italianos hay en el menú? 
SELECT 
	category,
	COUNT(*)
FROM menu_items
WHERE category = 'Italian'
GROUP BY category;

-- 5. ¿Cuáles son los platos italianos menos y más caros?
SELECT *
FROM menu_items
WHERE category = 'Italian'
ORDER BY price;

SELECT *
FROM menu_items
WHERE category = 'Italian'
ORDER BY price DESC;


-- 6. ¿Cuántos platos hay en cada categoría? (Italiana, Asiática, Mexicana, Americana)
SELECT 
	category,
	COUNT(menu_item_id)
FROM menu_items
GROUP BY category;


-- 7. ¿Cuál es el precio promedio de los platos dentro de cada categoría? 
SELECT 
	category,
	CAST(AVG(price) AS DECIMAL(10,2)) AS promedio_precio
FROM menu_items
GROUP BY category
ORDER BY 2 ASC;


-- ---------------------------------------------------
-- OBJETIVO 2: EXPLORAR LA TABLA DE PEDIDOS (ORDER_DETAILS)
-- ---------------------------------------------------
ALTER TABLE dbo.order_details
ALTER COLUMN order_time TIME(0); --11:57:40.0000000 a 11:57:40

-- 1. Ver la tabla de detalles del pedido
-- (Revisar columnas como order_details_id, order_id, order_date, item_id)
SELECT *
FROM order_details;


-- 2. ¿Cuál es el rango de fechas de la tabla? 
-- (Fecha mínima y fecha máxima)
SELECT
	MIN(order_date) AS fecha_min,
	MAX(order_date) AS fecha_max
FROM order_details;

-- 3. ¿Cuántos pedidos se realizaron en este periodo?
-- (Ojo: contar los order_id distintos)
SELECT 
	COUNT(DISTINCT order_id) AS total_pedidos
FROM order_details;

-- 4. ¿Cuántos artículos se pidieron en este periodo?
SELECT 
	COUNT(*) AS total_articulos
FROM order_details;

-- 5. ¿Qué pedidos tuvieron la mayor cantidad de artículos?
SELECT 
	order_id,
	COUNT(item_id) AS total_articulos
FROM order_details
GROUP BY order_id
ORDER BY 2 DESC;

-- 6. ¿Cuántos pedidos tuvieron más de 12 artículos?
SELECT 
	order_id,
	COUNT(item_id) AS total_articulos
FROM order_details
GROUP BY order_id
HAVING COUNT(item_id) > 12
ORDER BY 2 DESC;