WITH MaxTime AS (
SELECT F.origin_city as OC,MAX(F.actual_time) as maxT
FROM FLIGHTS AS F
GROUP BY F.origin_city
)
SELECT DISTINCT F1.origin_city as origin_city,F1.dest_city as dest_city, MT.maxT as time
FROM FLIGHTS as F1, MaxTime as MT
WHERE F1.origin_city = MT.OC and F1.actual_time = MT.maxT
ORDER BY F1.origin_city,F1.dest_city ASC;

-- 334 rows
-- 6s
/*
origin_city	                    dest_city	            time
Aberdeen SD	                    Minneapolis MN	        106
Abilene TX	                    Dallas/Fort Worth TX	111
Adak Island AK	                Anchorage AK	        471
Aguadilla PR	                New York NY	            368
Akron OH	                    Atlanta GA	            408
Albany GA	                    Atlanta GA	            243
Albany NY	                    Atlanta GA	            390
Albuquerque NM	                Houston TX	            492
Alexandria LA	                Atlanta GA	            391
Allentown/Bethlehem/Easton PA	Atlanta GA	            456
Alpena MI	                    Detroit MI	            80
Amarillo TX	                    Houston TX	            390
Anchorage AK	                Barrow AK	            490
Appleton WI	                    Atlanta GA	            405
Arcata/Eureka CA	            San Francisco CA	    476
Asheville NC	                Chicago IL	            279
Ashland WV	                    Cincinnati OH	        84
Aspen CO	                    Los Angeles CA	        304
Atlanta GA	                    Honolulu HI	            649
Atlantic City NJ	            Fort Lauderdale FL	    212
*/