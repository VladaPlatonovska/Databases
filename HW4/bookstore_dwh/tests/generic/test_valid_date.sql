{% test valid_date(model, column_name) %}
    SELECT *
    FROM {{ model }}
    WHERE NOT {{ is_valid_date(column_name) }}
{% endtest %}