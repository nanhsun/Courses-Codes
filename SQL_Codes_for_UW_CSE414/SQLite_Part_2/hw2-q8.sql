SELECT C.name AS name, SUM(F.departure_delay) AS delay
    FROM FLIGHTS AS F LEFT OUTER JOIN CARRIERS AS C
    ON F.carrier_id = C.cid
    GROUP BY C.name;
-- 22 rows