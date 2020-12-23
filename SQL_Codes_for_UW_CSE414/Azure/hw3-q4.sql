with T as (
    select distinct f.dest_city as dest_city
    from FLIGHTS as f
    where f.origin_city = 'Seattle WA'
    )
select distinct f1.dest_city as city
from FLIGHTS as f1 join T
on f1.origin_city = T.dest_city
where f1.dest_city not in (select distinct f2.dest_city
    from FLIGHTS as f2
    where f2.origin_city = 'Seattle WA') and f1.dest_city <> 'Seattle WA'
order by f1.dest_city ASC;


--256 rows
--11 sec
/*
city
Aberdeen SD
Abilene TX
Adak Island AK
Aguadilla PR
Akron OH
Albany GA
Albany NY
Alexandria LA
Allentown/Bethlehem/Easton PA
Alpena MI
Amarillo TX
Appleton WI
Arcata/Eureka CA
Asheville NC
Ashland WV
Aspen CO
Atlantic City NJ
Augusta GA
Bakersfield CA
Bangor ME
*/