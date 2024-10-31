{{ config(materialized='view') }}
SELECT
    SaleID,
    SaleDate,
    TotalAmount,
    EXTRACT(YEAR FROM SaleDate) as SaleYear,
    EXTRACT(MONTH FROM SaleDate) as SaleMonth
FROM {{ ref('raw_sales') }}
