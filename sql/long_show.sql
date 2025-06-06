-- Q6: What is the average number of views for tv shows that have 3+ and <3 seasons?
USE NetflixDB;

-- Query 6.1: Average views for tv shows >= 3 seasons
WITH tv_three_plus AS (
    SELECT tv_show_id
    FROM season
    GROUP BY tv_show_id
    HAVING COUNT(*) >= 3
)

SELECT 'tv_show' AS type, AVG(v.views) AS avg_views
FROM tv_show t
JOIN tv_three_plus p ON t.id = p.tv_show_id
JOIN season s ON t.id = s.tv_show_id
JOIN view_summary v ON s.id = v.season_id;
    
-- Query 6.2: Average views for tv shows <3 seasons
WITH tv_three_plus AS (
    SELECT tv_show_id
    FROM season
    GROUP BY tv_show_id
    HAVING COUNT(*) < 3
)

SELECT 'tv_show' AS type, AVG(v.views) AS avg_views
FROM tv_show t
JOIN tv_three_plus p ON t.id = p.tv_show_id
JOIN season s ON t.id = s.tv_show_id
JOIN view_summary v ON s.id = v.season_id;
