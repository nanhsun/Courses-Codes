SELECT C.name as carriers, MAX(F.price) as max_price
    FROM FLIGHTS AS F LEFT OUTER JOIN CARRIERS AS C
    ON F.carrier_id = C.cid
    WHERE (F.origin_city = "Seattle WA" OR F.origin_city = "New York NY") AND 
    (F.dest_city = "Seattle WA" OR F.dest_city = "New York NY")
    GROUP BY C.name;
-- 3 rows