```Incorrect Code```
USE geo;
SELECT m.name as mountain, m.height as height, y.`-car_code` as country_code, y.name as country
FROM geo.world x, x.mondial.country y, x.mondial.mountain m
LET SplitString = Split(m.`-country`," ")
WHERE y.`-car_code` = SplitString;

```Correct Code```
USE geo;
SELECT m.name as mountain, int(m.height) as height, y.`-car_code` as country_code, y.name as country
FROM geo.world x, x.mondial.country y, x.mondial.mountain m, split(m.`-country`," ") as SplitString
WHERE y.`-car_code` = SplitString
ORDER BY int(m.height) DESC;