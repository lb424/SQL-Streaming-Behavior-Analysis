-- Q1: What are the 10 most watched movies and tv-shows of all time?
USE NetflixDB;

-- Query 1.1: Top 10 Movies by hours viewed
SELECT m.title AS movie, SUM(v.hours_viewed) AS total_hours
FROM movie m
JOIN view_summary v ON m.id = v.movie_id

GROUP BY m.id, m.title
ORDER BY total_hours DESC
LIMIT 10;

-- Query 1.2: Top 10 TV Shows by hours viewed
SELECT t.title AS tv_show, SUM(v.hours_viewed) AS total_hours
FROM tv_show t
JOIN season s ON t.id = s.tv_show_id
JOIN view_summary v ON s.id = v.season_id

GROUP BY t.id, t.title
ORDER BY total_hours DESC
LIMIT 10;

-- Query 1.3: Top 10 Movies/TV Shows by hours viewed
SELECT m.title, SUM(v.hours_viewed) AS total_hours, 'movie' AS type
FROM movie m
JOIN view_summary v ON m.id = v.movie_id
GROUP BY m.id, m.title

UNION ALL

SELECT t.title, SUM(v.hours_viewed) AS total_hours, 'tv_show' AS type
FROM tv_show t
JOIN season s ON t.id = s.tv_show_id
JOIN view_summary v ON s.id = v.season_id
GROUP BY t.id, t.title

ORDER BY total_hours DESC
LIMIT 10;