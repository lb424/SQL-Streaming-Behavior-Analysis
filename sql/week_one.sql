-- Q5: Which movies/tv shows had the highest first week viewership?
USE NetflixDB;

-- Query 5.1: Outputs first week views for movies and tv shows
WITH movie_week_one AS (
    SELECT m.title, v.hours_viewed, ROW_NUMBER() OVER (PARTITION BY m.id ORDER BY v.start_date) AS rn
    FROM movie m
    JOIN view_summary v ON m.id = v.movie_id
    WHERE v.view_rank <= 10
),

first_movie AS (
    SELECT title, hours_viewed, 'movie' AS type
    FROM movie_week_one
    WHERE rn = 1
),

tv_week_one AS (
    SELECT t.title, v.hours_viewed, ROW_NUMBER() OVER (PARTITION BY t.id ORDER BY v.start_date) AS rn
    FROM tv_show t
    JOIN season s ON t.id = s.tv_show_id
    JOIN view_summary v ON s.id = v.season_id
    WHERE v.view_rank <= 10
),

first_tv AS (
    SELECT title, hours_viewed, 'tv_show' AS type
    FROM tv_week_one
    WHERE rn = 1
)

SELECT title, hours_viewed AS first_week_views, type
FROM (
    SELECT *
    FROM first_movie
    UNION ALL
    SELECT *
    FROM first_tv
) AS combined
ORDER BY first_week_views DESC
LIMIT 20;