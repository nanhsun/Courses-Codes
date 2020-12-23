SELECT distinct f.dest_city as city
from FLIGHTS as f
where f.origin_city <> 'Seattle WA' and f.dest_city not in (
    select distinct f2.dest_city
    from FLIGHTS as f1 join FLIGHTS as f2
    on f1.dest_city = f2.origin_city
    where f1.origin_city = 'Seattle WA' and f2.dest_city <> 'Seattle WA'
)
order by f.dest_city ASC

--16sec
--4 rows
/*
city
Devils Lake ND
Hattiesburg/Laurel MS
Seattle WA
St. Augustine FL
*/