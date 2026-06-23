{{ config(materialized = 'table') }}

WITH fct_ratings AS (
    SELECT * FROM {{ ref('fct_ratings') }}
),
dim_movies AS (
    SELECT * FROM {{ ref('dim_movies') }}
),
exploded AS (
    SELECT
        r.rating,
        g.value::STRING AS genre
    FROM fct_ratings r
    JOIN dim_movies m ON r.movie_id = m.movie_id,
    LATERAL FLATTEN(input => m.genre_array) g
)

SELECT
    genre,
    COUNT(*)                AS total_ratings,
    ROUND(AVG(rating), 2)   AS avg_rating,
    COUNT(DISTINCT genre)   AS movie_count
FROM exploded
WHERE genre != '(no genres listed)'
GROUP BY genre
ORDER BY total_ratings DESC
