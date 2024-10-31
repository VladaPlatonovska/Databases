{{ config(materialized='table') }}
SELECT
    b.*,
    a.AuthorName,
    p.PublisherName
FROM {{ ref('stg_books') }} b
JOIN {{ ref('stg_authors') }} a ON b.AuthorID = a.AuthorID
JOIN {{ ref('stg_publishers') }} p ON b.BookID = p.PublisherID