-- Q10: Which movie/ tv show had the highest drop in viewership after the first week?
USE NetflixDB;

-- Query 10.1: Movie Drop
WITH movie_week AS (
    SELECT m.title, v.hours_viewed, ROW_NUMBER() OVER (PARTITION BY m.id ORDER BY v.start_date) AS rn
    FROM movie m
    JOIN view_summary v ON m.id = v.movie_id
    WHERE v.view_rank <= 10
),

movie_calc AS (
    SELECT mv1.title,
    mv1.hours_viewed AS week1_view,
    mv2.hours_viewed AS week2_view,
    mv1.hours_viewed - mv2.hours_viewed as drop_views,
    ROUND((mv1.hours_viewed - mv2.hours_viewed)/mv1.hours_viewed * 100, 2) as drop_percent,
    'movie' AS type
    FROM movie_week mv1
    JOIN movie_week mv2
    ON mv1.title = mv2.title AND mv1.rn=1 AND mv2.rn=2
)

SELECT title, week1_view, week2_view, drop_views, drop_percent, type
FROM (
    SELECT *
    FROM movie_calc
) AS combined

ORDER BY drop_views DESC
LIMIT 20;

-- Query 10.2: TV Drop
WITH tv_week AS (
    SELECT t.title, v.hours_viewed, ROW_NUMBER() OVER (PARTITION BY t.id ORDER BY v.start_date) AS rn
    FROM tv_show t
    JOIN season s ON t.id = s.tv_show_id
    JOIN view_summary v ON s.id = v.season_id
),

tv_calc AS (
    SELECT tv1.title,
    tv1.hours_viewed AS week1_view,
    tv2.hours_viewed AS week2_view,
    tv1.hours_viewed - tv2.hours_viewed as drop_views,
    ROUND((tv1.hours_viewed - tv2.hours_viewed)/tv1.hours_viewed * 100, 2) as drop_percent,
    'tv_show' AS type
    FROM tv_week tv1
    JOIN tv_week tv2
    ON tv1.title = tv2.title AND tv1.rn=1 AND tv2.rn=2
)

SELECT title, week1_view, week2_view, drop_views, drop_percent, type
FROM (
    SELECT *
    FROM tv_calc
) AS combined

ORDER BY drop_views DESC
LIMIT 20;

-- Query 10.3: Movie and TV Drop
WITH movie_week AS (
    SELECT m.title, v.hours_viewed, ROW_NUMBER() OVER (PARTITION BY m.id ORDER BY v.start_date) AS rn
    FROM movie m
    JOIN view_summary v ON m.id = v.movie_id
    WHERE v.view_rank <= 10
),

movie_calc AS (
    SELECT mv1.title,
    mv1.hours_viewed AS week1_view,
    mv2.hours_viewed AS week2_view,
    mv1.hours_viewed - mv2.hours_viewed as drop_views,
    ROUND((mv1.hours_viewed - mv2.hours_viewed)/mv1.hours_viewed * 100, 2) as drop_percent,
    'movie' AS type
    FROM movie_week mv1
    JOIN movie_week mv2
    ON mv1.title = mv2.title AND mv1.rn=1 AND mv2.rn=2
),

tv_week AS (
    SELECT t.title, v.hours_viewed, ROW_NUMBER() OVER (PARTITION BY t.id ORDER BY v.start_date) AS rn
    FROM tv_show t
    JOIN season s ON t.id = s.tv_show_id
    JOIN view_summary v ON s.id = v.season_id
),

tv_calc AS (
    SELECT tv1.title,
    tv1.hours_viewed AS week1_view,
    tv2.hours_viewed AS week2_view,
    tv1.hours_viewed - tv2.hours_viewed as drop_views,
    ROUND((tv1.hours_viewed - tv2.hours_viewed)/tv1.hours_viewed * 100, 2) as drop_percent,
    'tv_show' AS type
    FROM tv_week tv1
    JOIN tv_week tv2
    ON tv1.title = tv2.title AND tv1.rn=1 AND tv2.rn=2
)

SELECT title, week1_view, week2_view, drop_views, drop_percent, type
FROM (
    SELECT *
    FROM movie_calc
    UNION ALL
    SELECT *
    FROM tv_calc
) AS combined

ORDER BY drop_views DESC
LIMIT 20;