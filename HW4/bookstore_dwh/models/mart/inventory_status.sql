{{ config(materialized='table') }}
SELECT
    StockStatus,
    COUNT(*) as BookCount,
    AVG(Price) as AvgPrice,
    SUM(StockQuantity) as TotalStock
FROM {{ ref('stg_books') }}
GROUP BY StockStatus
