SELECT F.flight_num AS flight_num
    FROM FLIGHTS AS F LEFT OUTER JOIN CARRIERS AS C
    ON F.carrier_id= C.cid
    LEFT OUTER JOIN WEEKDAYS as W
    ON F.day_of_week_id = W.did
    WHERE W.day_of_week = "Monday" AND C.name = "Alaska Airlines Inc." AND F.origin_city = "Seattle WA" AND F.dest_city = "Boston MA"
    GROUP BY F.flight_num;

-- 3 rows