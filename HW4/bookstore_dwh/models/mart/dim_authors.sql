{{ config(materialized='table') }}
SELECT
    a.*,
    COUNT(DISTINCT b.BookID) as TotalBooksWritten,
    AVG(b.Price) as AvgBookPrice
FROM {{ ref('stg_authors') }} a
LEFT JOIN {{ ref('stg_books') }} b ON a.AuthorID = b.AuthorID
GROUP BY a.AuthorID, a.AuthorName, a.BirthDate, a.AuthorAge