# {{ config(materialized='table') }}
# SELECT
#     SaleYear,
#     SaleMonth,
#     COUNT(DISTINCT SaleID) as TotalSales,
#     SUM(TotalAmount) as TotalRevenue,
#     AVG(TotalAmount) as AvgSaleAmount
# FROM {{ ref('stg_sales') }}
# GROUP BY SaleYear, SaleMonth

{{ config(materialized='table') }}

SELECT
    {{ get_fiscal_year('SaleDate') }} as FiscalYear,
    SaleMonth,
    COUNT(DISTINCT SaleID) as TotalSales,
    SUM(TotalAmount) as TotalRevenue,
    {{ calc_percentage('SUM(TotalAmount)', 'LAG(SUM(TotalAmount)) OVER (ORDER BY SaleYear, SaleMonth)') }} as Revenue_Growth_Pct
FROM {{ ref('stg_sales') }}
GROUP BY {{ get_fiscal_year('SaleDate') }}, SaleMonth