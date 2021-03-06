USE geo;
SELECT y.`-car_code` as country_code, y.name as country_name, seas
FROM world x, x.mondial.country y
LET seas = (SELECT u.name as sea
                FROM x.mondial.sea as u, split(u.`-country`," ") as z
                WHERE y.`-car_code` = z)
WHERE array_count(seas) >= 2
ORDER BY array_count(seas) DESC;