{{ config(materialized = 'table') }}

WITH fct_ratings AS (
    SELECT * FROM {{ ref('fct_ratings') }}
)

SELECT
    user_id,
    COUNT(*)                              AS total_ratings,
    ROUND(AVG(rating), 2)                 AS avg_rating,
    MIN(rating_timestamp)                 AS first_rated_at,
    MAX(rating_timestamp)                 AS last_rated_at,
    DATEDIFF('day', MIN(rating_timestamp),
             MAX(rating_timestamp))       AS active_days_span
FROM fct_ratings
GROUP BY user_id
