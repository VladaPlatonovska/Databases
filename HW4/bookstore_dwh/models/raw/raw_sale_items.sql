{{ config(materialized='table') }}
SELECT
    SaleItemID,
    SaleID,
    BookID,
    Quantity,
    UnitPrice
FROM SaleItems
