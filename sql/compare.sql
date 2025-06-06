-- Q4: How does user viewership between movies and tv shows compare?
USE NetflixDB;

-- Query 4.1: Total Hours by Type
SELECT 'movie' AS type, SUM(v.hours_viewed) AS total_hours
FROM movie m
JOIN view_summary v ON m.id = v.movie_id

UNION ALL

SELECT 'tv_show' AS type, SUM(v.hours_viewed) AS total_hours
FROM tv_show t
JOIN season s ON t.id = s.tv_show_id
JOIN view_summary v ON s.id = v.season_id;

-- Query 4.2: Average Hours per Title
SELECT 'movie' AS type, AVG(view.total_hours) AS avg_hours
FROM (
    SELECT 'movie' AS type, SUM(v.hours_viewed) AS total_hours
    FROM movie m
    JOIN view_summary v ON m.id = v.movie_id
    GROUP BY m.id
)
AS view

UNION ALL

SELECT 'tv_show' AS type, AVG(view.total_hours) AS avg_hours
FROM (
    SELECT 'tv_show' AS type, SUM(v.hours_viewed) AS total_hours
    FROM tv_show t
    JOIN season s ON t.id = s.tv_show_id
    JOIN view_summary v ON s.id = v.season_id
    GROUP BY t.id
)
AS view;

-- Query 4.3: Average Weekly hours Viewed
SELECT 'movie' AS type, AVG(v.hours_viewed) AS avg_weekly_hours
FROM movie m
JOIN view_summary v ON m.id = v.movie_id

UNION ALL

SELECT 'tv_show' AS type, AVG(v.hours_viewed) AS avg_weekly_hours
FROM tv_show t
JOIN season s ON t.id = s.tv_show_id
JOIN view_summary v ON s.id = v.season_id;