select distinct c.name as carrier
from FLIGHTS as f left outer join CARRIERs as c
on f.carrier_id = c.cid
where f.origin_city = 'Seattle WA' and f.dest_city = 'San Francisco CA'
order by c.name asc

--10sec
--4 rows