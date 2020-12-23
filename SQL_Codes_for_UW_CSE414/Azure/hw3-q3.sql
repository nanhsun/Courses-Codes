WITH T1 as (
    SELECT F.origin_city as city,COUNT(*) as num
    FROM FLIGHTS as F
    where F.actual_time < 180 and F.canceled = 0
    group by F.origin_city
)
SELECT F1.origin_city as origin_city, ISNULL((T1.num*100.0/COUNT(*)),0) as percentage
FROM FLIGHTS as F1 left outer join T1
on F1.origin_city = T1.city
GROUP BY F1.origin_city,T1.num
ORDER BY ISNULL((T1.num*100.0/COUNT(*)),0), F1.origin_city ASC;

--327 rows
-- 9 sec
/*
origin_city	            percentage
Guam TT	0
Pago Pago TT	        0
Aguadilla PR	        28.67924528
Anchorage AK	        31.65627783
San Juan PR	            33.54391685
Charlotte Amalie VI	    39.27007299
Ponce PR	            40.32258065
Fairbanks AK	        49.53917051
Kahului HI	            53.3411834
Honolulu HI	            54.53369551
San Francisco CA	    55.22370849
Los Angeles CA	        55.41278834
Seattle WA	            57.41093283
New York NY	            60.53243732
Long Beach CA	        61.71997902
Kona HI	                62.95279912
Newark NJ	            63.36756525
Plattsburgh NY	        64
Las Vegas NV	        64.47100618
Christiansted VI	    64.66666667
*/