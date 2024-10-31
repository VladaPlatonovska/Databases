{{ config(materialized='view') }}
SELECT
    SaleItemID,
    SaleID,
    BookID,
    Quantity,
    UnitPrice,
    Quantity * UnitPrice as LineTotal
FROM {{ ref('raw_sale_items') }}