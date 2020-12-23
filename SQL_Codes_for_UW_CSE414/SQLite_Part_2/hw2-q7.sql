SELECT SUM(F.capacity) as capacity
    FROM FLIGHTS AS F LEFT OUTER JOIN MONTHS AS M
    ON F.month_id = M.mid
    WHERE (F.origin_city = "Seattle WA" OR F.origin_city = "San Francisco CA") AND 
    (F.dest_city = "Seattle WA" OR F.dest_city = "San Francisco CA") AND M.month = 'July' AND F.day_of_month = 10;
-- 1 row