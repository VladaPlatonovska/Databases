{{ config(materialized='table') }}

select
    AuthorID,
    FirstName,
    LastName,
    BirthDate
from Authors