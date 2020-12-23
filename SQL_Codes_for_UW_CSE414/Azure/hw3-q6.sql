with T as (select f.fid as ffid
    from FLIGHTS as f
    where f.origin_city = 'Seattle WA')
select distinct C1.name as carrier
from FLIGHTS as f1 
join T
on f1.fid = T.ffid
left outer join CARRIERS as C1
on f1.carrier_id = C1.cid
where f1.dest_city = 'San Francisco CA'
order by C1.name ASC;

--5sec
--4 rows
/*
carrier
Alaska Airlines Inc.
SkyWest Airlines Inc.
United Air Lines Inc.
Virgin America
*/