{{ config(materialized='table') }}
SELECT
    si.SaleItemID,
    s.SaleDate,
    s.SaleYear,
    s.SaleMonth,
    b.Title,
    a.AuthorName,
    si.Quantity,
    si.UnitPrice,
    si.LineTotal
FROM {{ ref('stg_sale_items') }} si
JOIN {{ ref('stg_sales') }} s ON si.SaleID = s.SaleID
JOIN {{ ref('stg_books') }} b ON si.BookID = b.BookID
JOIN {{ ref('stg_authors') }} a ON b.AuthorID = a.AuthorID
