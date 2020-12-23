SELECT F.origin_city as city
FROM FLIGHTS as F
where F.canceled = 0
GROUP BY F.origin_city
HAVING Max(F.actual_time) <180
ORDER BY F.origin_city ASC;

--109 rows
--3 sec
/*
city
Aberdeen SD
Abilene TX
Alpena MI
Ashland WV
Augusta GA
Barrow AK
Beaumont/Port Arthur TX
Bemidji MN
Bethel AK
Binghamton NY
Brainerd MN
Bristol/Johnson City/Kingsport TN
Butte MT
Carlsbad CA
Casper WY
Cedar City UT
Chico CA
College Station/Bryan TX
Columbia MO
Columbus GA
*/