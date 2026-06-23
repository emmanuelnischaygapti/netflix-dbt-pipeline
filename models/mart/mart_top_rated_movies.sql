{{ config(materialized = 'table') }}

WITH fct_ratings AS (
    SELECT * FROM {{ ref('fct_ratings') }}
),
dim_movies AS (
    SELECT * FROM {{ ref('dim_movies') }}
)

SELECT
    m.movie_id,
    m.movie_title,
    m.genres,
    COUNT(r.rating)          AS rating_count,
    ROUND(AVG(r.rating), 2)  AS avg_rating,
    MIN(r.rating)            AS min_rating,
    MAX(r.rating)            AS max_rating
FROM fct_ratings r
JOIN dim_movies m ON r.movie_id = m.movie_id
GROUP BY m.movie_id, m.movie_title, m.genres
HAVING COUNT(r.rating) >= 50
ORDER BY avg_rating DESC
