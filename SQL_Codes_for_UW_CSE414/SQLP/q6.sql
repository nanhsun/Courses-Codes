USE geo;
SELECT y.name as country_name, y.`-car_code` as country_code, mountains
FROM world x, x.mondial.country y
LET mountains = (SELECT u.name as mountain, u.height as height
                FROM x.mondial.mountain as u, split(u.`-country`," ") as z
                WHERE y.`-car_code` = z)
ORDER BY array_count(mountains) DESC;