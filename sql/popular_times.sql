-- Q7: What period of time yields the most releases for movies and tv shows?
USE NetflixDB;

-- Query 7.1: Releases by year
SELECT YEAR(m.release_date) AS year, COUNT(*) AS release_ct
FROM movie m
WHERE m.release_date IS NOT NULL
GROUP BY YEAR(m.release_date)

UNION ALL

SELECT YEAR(t.release_date) AS year, COUNT(*) AS release_ct
FROM tv_show t
WHERE t.release_date IS NOT NULL
GROUP BY YEAR(t.release_date)

ORDER BY year DESC;

-- Query 7.2: Releases by Month
SELECT MONTHNAME(m.release_date) AS month, COUNT(*) AS release_ct
FROM movie m
WHERE m.release_date IS NOT NULL
GROUP BY MONTHNAME(m.release_date)

UNION ALL

SELECT MONTHNAME(t.release_date) AS month, COUNT(*) AS release_ct
FROM tv_show t
WHERE t.release_date IS NOT NULL
GROUP BY MONTHNAME(t.release_date)

ORDER BY release_ct DESC;