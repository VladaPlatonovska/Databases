{{ config(materialized='view') }}
SELECT
    PublisherID,
    Name as PublisherName,
    FoundedYear,
    Website,
    EXTRACT(YEAR FROM CURRENT_DATE) - FoundedYear as YearsInBusiness
FROM {{ ref('raw_publishers') }}