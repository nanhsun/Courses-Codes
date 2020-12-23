SELECT DISTINCT C.name AS name
    FROM FLIGHTS AS F1 LEFT OUTER JOIN CARRIERS AS C
    ON F1.carrier_id=C.cid
    GROUP BY F1.day_of_month,C.name
    HAVING COUNT(C.name) > 1000
    ORDER BY C.name;
-- 12 rows