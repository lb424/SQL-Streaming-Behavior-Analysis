-- Q9: What movie/ tv shows have the highest viewership by year/month?
USE NetflixDB;

-- Query 9.1: Highest Viewership by Year
WITH combined AS (
SELECT YEAR(m.release_date) AS year, m.title, SUM(v.views) AS views, 'movie' AS type
FROM movie m
JOIN view_summary v ON m.id = v.movie_id
WHERE m.release_date IS NOT NULL
GROUP BY year, m.title

UNION ALL

SELECT YEAR(t.release_date) AS year, t.title, SUM(v.views) AS views, 'tv_show' AS type
FROM tv_show t
JOIN season s ON t.id = s.tv_show_id
JOIN view_summary v ON s.id = v.season_id
WHERE t.release_date IS NOT NULL
GROUP BY year, t.title
),

ranked AS (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY year ORDER BY views DESC) as rn
    FROM combined
)

SELECT year, title, views, type
FROM ranked
WHERE rn <= 10
ORDER BY year DESC, views DESC;

-- Query 9.2: Highest Viewership by Month
WITH combined AS (
SELECT MONTHNAME(m.release_date) AS month, m.title, SUM(v.views) AS views, 'movie' AS type
FROM movie m
JOIN view_summary v ON m.id = v.movie_id
WHERE m.release_date IS NOT NULL
GROUP BY month, m.title

UNION ALL

SELECT MONTHNAME(t.release_date) AS month, t.title, SUM(v.views) AS views, 'tv_show' AS type
FROM tv_show t
JOIN season s ON t.id = s.tv_show_id
JOIN view_summary v ON s.id = v.season_id
WHERE t.release_date IS NOT NULL
GROUP BY month, t.title
),

ranked AS (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY month ORDER BY views DESC) as rn
    FROM combined
)

SELECT month, title, views, type
FROM ranked
WHERE rn <= 10
ORDER BY month DESC, views DESC;