SELECT C.name AS name, COUNT(CASE WHEN F.canceled=1 THEN 1 END) * 100.0 / COUNT(ALL) AS percentage
    FROM FLIGHTS AS F LEFT OUTER JOIN CARRIERS as C
    ON F.carrier_id = C.cid
    WHERE F.origin_city = "Seattle WA"
    GROUP BY C.name
    HAVING (COUNT(CASE WHEN F.canceled=1 THEN 1 END) * 1.0 / COUNT(ALL)) > 0.005;
-- 6 rows
