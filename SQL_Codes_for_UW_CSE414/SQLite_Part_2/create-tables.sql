CREATE TABLE CARRIERS (cid varchar(7) PRIMARY KEY, name varchar(83));
CREATE TABLE MONTHS (mid int PRIMARY KEY, month varchar(9));
CREATE TABLE WEEKDAYS (did int PRIMARY KEY, day_of_week varchar(9));

CREATE TABLE FLIGHTS (fid int PRIMARY KEY, 
         month_id int REFERENCES MONTHS(mid),        -- 1-12
         day_of_month int,    -- 1-31 
         day_of_week_id int REFERENCES WEEKDAYS(did),  -- 1-7, 1 = Monday, 2 = Tuesday, etc
         carrier_id varchar(7) REFERENCES CARRIERS(cid), 
         flight_num int,
         origin_city varchar(34), 
         origin_state varchar(47), 
         dest_city varchar(34), 
         dest_state varchar(46), 
         departure_delay int, -- in mins
         taxi_out int,        -- in mins
         arrival_delay int,   -- in mins
         canceled int,        -- 1 means canceled
         actual_time int,     -- in mins
         distance int,        -- in miles
         capacity int, 
         price int            -- in $             
         );
PRAGMA foreign_keys=ON;

SELECT F1.origin_city, F1.dest_city, MAX(F1.actual_time)
FROM FLIGHTS AS F1, FLIGHTS AS F2
WHERE F1.month_id = F2.month_id AND F1.day_of_month = F2.day_of_month AND F1.dest_city != F2.origin_city AND F1.carrier_id = F2.carrier_id
GROUP BY F1.origin_city,F1.dest_city;

SELECT MAX(F.actual_time)
FROM FLIGHTS AS F
GROUP BY F.origin_city,F.dest_city,F.actual_time;

WITH MaxTime AS(
    SELECT F.carrier_id as Fcid,F.month_id as Fmid,F.day_of_month as Fdm, F.origin_city as Foc, F.dest_city as Fdc, MAX(F.actual_time) as MaxT
    FROM FLIGHTS AS F
    GROUP BY F.carrier_id,F.month_id,F.day_of_month,F.origin_city,F.dest_city
)
SELECT COUNT(*)
FROM MaxTime as MT1, MaxTime as MT2
WHERE MT1.Fmid = MT2.Fmid AND MT1.Fdm = MT2.Fdm AND MT1.Fcid = MT2.Fcid
;


SELECT COUNT(*) FROM (
with T as (select f.fid as ffid
    from FLIGHTS as f
    where f.origin_city = 'Seattle WA')
select distinct C1.name
from FLIGHTS as f1 
join T
on f1.fid = T.ffid
left outer join CARRIERS as C1
on f1.carrier_id = C1.cid
where f1.dest_city = 'San Francisco CA'
) z;

SELECT COUNT(*) FROM (
select f.dest_city as dest_city
    from FLIGHTS as f
    group by f.dest_city
) z;
SELECT COUNT(*) FROM (
    select f.origin_city as origin_city, f.dest_city as dest_city
    from FLIGHTS as f
    where f.origin_city = 'Seattle WA'
    group by f.dest_city
) z;

