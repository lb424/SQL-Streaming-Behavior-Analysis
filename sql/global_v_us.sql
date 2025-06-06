-- Q2: How does viewership differ between globally available content and US-only content?
USE NetflixDB;

-- Query 2.1: Global versus US Total Hours for Movies
SELECT m.locale, 
CASE WHEN m.available_globally = 1 THEN 'Global'
ELSE 'US Only'
END AS region, SUM(v.hours_viewed) AS total_hours
FROM movie m

JOIN view_summary v on m.id = v.movie_id
WHERE m.locale IS NOT NULL
GROUP BY m.locale, region
ORDER BY total_hours DESC;

-- Query 2.2: Global versus US Total Hours for TV Shows
SELECT t.locale, 
CASE WHEN t.available_globally = 1 THEN 'Global'
ELSE 'US Only'
END AS region, SUM(v.hours_viewed) AS total_hours
FROM tv_show t

JOIN season s ON t.id = s.tv_show_id
JOIN view_summary v ON s.id = v.season_id
WHERE t.locale IS NOT NULL
GROUP BY t.locale, region
ORDER BY total_hours DESC;
