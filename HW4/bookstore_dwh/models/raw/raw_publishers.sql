{{ config(materialized='table') }}
SELECT
    PublisherID,
    Name,
    FoundedYear,
    Website
FROM Publishers