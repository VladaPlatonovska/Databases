{{ config(materialized='table') }}
SELECT
    SaleID,
    SaleDate,
    TotalAmount
FROM Sales
