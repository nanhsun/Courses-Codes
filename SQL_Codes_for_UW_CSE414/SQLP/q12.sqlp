USE geoindex;

SELECT DISTINCT table1.y AS first_country , table2.y2 AS second_country, Sea, Mount
FROM (SELECT  Y1.name as y, s.name As sea, m.name as mou
FROM country AS Y1, sea AS s, split(s.`-country`, ' ') AS z1,
               mountain AS m, split(m.`-country`, ' ') AS z2 
WHERE  Y1.`-car_code` = z1 and Y1.`-car_code` = z2 ) AS table1,
(SELECT  Y2.name as y2, s2.name As sea2, m2.name as mou2
FROM country AS Y2, sea AS s2, split(s2.`-country`, ' ') AS z3,
    mountain AS m2, split(m2.`-country`, ' ') AS z4 
WHERE  Y2.`-car_code` = z3 and Y2.`-car_code` = z4 ) AS table2

LET Mount = (SELECT DISTINCT innertable.mou as mountain
                FROM (SELECT  Y1.name as y, s.name As sea, m.name as mou
                        FROM country AS Y1, sea AS s, split(s.`-country`, ' ') AS z1,
                                    mountain AS m, split(m.`-country`, ' ') AS z2 
                        WHERE  Y1.`-car_code` = z1 and Y1.`-car_code` = z2) as innertable
                WHERE table1.y = innertable.y
),
Sea = (SELECT DISTINCT innertable.sea as sea
                FROM (SELECT  Y1.name as y, s.name As sea, m.name as mou
                        FROM country AS Y1, sea AS s, split(s.`-country`, ' ') AS z1,
                                    mountain AS m, split(m.`-country`, ' ') AS z2 
                        WHERE  Y1.`-car_code` = z1 and Y1.`-car_code` = z2) as innertable
                WHERE table1.y = innertable.y
)

WHERE table1.y > table2.y2 and table1.sea = table2.sea2 and table1.mou = table2.mou2;