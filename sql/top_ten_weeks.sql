-- Q3: Which movies and shows have spent the most total weeks in the top 10?
USE NetflixDB;

-- Query 3.1: Movies and TV Shows by total weeks in top 10
SELECT m.title AS title, MAX(v.cumulative_weeks_in_top10) AS total_weeks, 'movie' AS type
FROM movie m
JOIN view_summary v ON m.id = v.movie_id
GROUP BY m.id, m.title

UNION ALL

SELECT t.title AS title, MAX(v.cumulative_weeks_in_top10) AS total_weeks, 'tv_show' AS type
FROM tv_show t
JOIN season s ON t.id = s.tv_show_id
JOIN view_summary v ON s.id = v.season_id
GROUP BY t.id, t.title

ORDER BY total_weeks DESC
LIMIT 100;