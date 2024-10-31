{{ config(materialized='table') }}
SELECT
    BookID,
    Title,
    AuthorID,
    PublicationYear,
    Price,
    StockQuantity
FROM Books