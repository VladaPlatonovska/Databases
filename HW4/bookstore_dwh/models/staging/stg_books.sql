{{ config(materialized='view') }}
SELECT
    BookID,
    Title,
    AuthorID,
    PublicationYear,
    Price,
    StockQuantity,
    CASE
        WHEN StockQuantity = 0 THEN 'Out of Stock'
        WHEN StockQuantity < 10 THEN 'Low Stock'
        ELSE 'In Stock'
    END as StockStatus
FROM {{ ref('raw_books') }}