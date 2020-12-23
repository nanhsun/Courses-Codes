USE geo;
SELECT y.`-car_code` as country_code, y.name as country, y.`-area` as area
FROM world x, x.mondial.country y
LET seas = (SELECT u.name as sea
                FROM x.mondial.sea as u, split(u.`-country`," ") as z
                WHERE y.`-car_code` = z)
WHERE array_count(seas) = 0;