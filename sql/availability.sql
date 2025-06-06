-- Q8: How many movies/ tv shows are available in the US versus globally?
USE NetflixDB;

-- Query 8.1: Titles US versus Global
SELECT region, COUNT(*) AS titles_count
FROM (
    SELECT CASE WHEN m.available_globally = 1 THEN 'GLOBAL'
    ELSE 'US ONLY'
    END AS region
    FROM movie m
    
    UNION ALL
    
    SELECT CASE WHEN t.available_globally = 1 THEN 'GLOBAL'
    ELSE 'US ONLY'
    END AS region
    FROM tv_show t
) AS combined
GROUP BY region;