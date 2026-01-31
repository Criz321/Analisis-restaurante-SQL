# 🍕 Análisis de Pedidos de Restaurante con SQL

## 📌 Contexto del Proyecto
Este proyecto simula un escenario real de análisis de datos para un restaurante. El objetivo es analizar el catálogo del menú y los datos transaccionales de pedidos para entender las preferencias de los clientes, el rendimiento de las categorías de comida y los patrones de gasto.

Utilicé **SQL Server** para limpiar, explorar y analizar dos datasets principales: `menu_items` y `order_details`.

## 📂 Estructura de Datos
El proyecto utiliza dos tablas relacionales:
1.  **menu_items**: Contiene el ID, nombre, precio y categoría de cada plato (Italiana, Americana, Asiática, Mexicana).
2.  **order_details**: Registro histórico de pedidos, incluyendo fecha, hora y el ID del artículo vendido.

## 🛠️ Tecnologías y Técnicas
-   **SQL Server (T-SQL)**
-   **Data Cleaning**: Ajuste de tipos de datos (`TIME(0)`) y manejo de formatos.
-   **Agregaciones**: `GROUP BY`, `COUNT`, `SUM`, `AVG`.
-   **Joins**: `LEFT JOIN` para cruzar dimensiones y hechos.
-   **Window Functions / Ranking**: Uso de `TOP` y `ORDER BY` para rankings.

## 🔍 Hallazgos Clave (Insights)

### 1. Dinámica del Menú
A través de la exploración inicial, se identificó que el menú está distribuido en 4 categorías principales.
* **Distribución:** Se calculó el conteo de platos por categoría para entender la variedad ofrecida.
* **Precios:** Se analizaron los precios promedio, identificando que la comida Italiana y Americana suelen tener precios promedio distintos a las opciones Asiáticas o Mexicanas.

### 2. Comportamiento de Pedidos
* **Volumen:** Se analizó el rango de fechas disponible para determinar la estacionalidad y el volumen total de órdenes.
* **Tamaño del Pedido:** Se descubrió que existen pedidos atípicos con más de 12 artículos, lo que sugiere cenas grupales o eventos, distintos al comportamiento promedio.

### 3. Análisis de "Clientes VIP" (Top Spenders)
Cruzando la información de pedidos con los precios del menú, se identificaron los pedidos de mayor valor monetario.

**Top 5 Pedidos por Gasto Total:**
| Ranking | Order ID | Gasto Total ($) |
| :--- | :--- | :--- |
| 1 | **440** | $192.15 |
| 2 | **2075** | $191.05 |
| 3 | **1957** | $190.10 |
| 4 | **330** | $189.70 |
| 5 | **2675** | $185.10 |

*Insight:* Al analizar el detalle del pedido #440 (el más alto), se puede observar una preferencia marcada por ciertas categorías, lo que ayuda a definir el perfil de un cliente de alto valor.

## 💾 Código SQL
El análisis completo se encuentra en la carpeta `scripts/`. A continuación, un ejemplo de cómo identifiqué el gasto por pedido:

```sql
SELECT TOP 5
    o.order_id,
    SUM(m.price) AS total_gasto
FROM order_details AS o
LEFT JOIN menu_items AS m
    ON o.item_id = m.menu_item_id
GROUP BY o.order_id
ORDER BY total_gasto DESC;
