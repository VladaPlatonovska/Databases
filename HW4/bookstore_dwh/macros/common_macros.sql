{# Macro to check if a value is null #}
{% macro is_not_null(column_name) %}
    {{ column_name }} is not null
{% endmacro %}

{# Macro to calculate percentage #}
{% macro calc_percentage(numerator, denominator) %}
    CASE
        WHEN {{denominator}} = 0 THEN 0
        ELSE ({{numerator}} * 100.0 / NULLIF({{denominator}}, 0))
    END
{% endmacro %}

{# Macro for date validation #}
{% macro is_valid_date(column_name) %}
    ({{ column_name }} IS NOT NULL AND {{ column_name }} <= CURRENT_DATE)
{% endmacro %}

{# Macro for price validation #}
{% macro is_valid_price(column_name) %}
    ({{ column_name }} IS NOT NULL AND {{ column_name }} >= 0)
{% endmacro %}

{# Macro to get the fiscal year #}
{% macro get_fiscal_year(date_column) %}
    CASE
        WHEN EXTRACT(MONTH FROM {{ date_column }}) >= 10
        THEN EXTRACT(YEAR FROM {{ date_column }}) + 1
        ELSE EXTRACT(YEAR FROM {{ date_column }})
    END
{% endmacro %}