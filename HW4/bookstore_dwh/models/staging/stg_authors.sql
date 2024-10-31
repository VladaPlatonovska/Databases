{{ config(materialized='view') }}
SELECT
    AuthorID,
    FirstName || ' ' || LastName as AuthorName,
    BirthDate,
    EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM BirthDate) as AuthorAge
FROM {{ ref('raw_authors') }}