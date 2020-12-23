SELECT W.day_of_week AS day_of_week, AVG(F.arrival_delay) AS delay
    FROM FLIGHTS AS F LEFT OUTER JOIN WEEKDAYS AS W
    ON F.day_of_week_id = W.did
    GROUP BY W.day_of_week
    ORDER BY AVG(F.arrival_delay) DESC
    LIMIT 1;
-- 1 row