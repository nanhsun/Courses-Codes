USE geo;
SELECT T.ethnicgroups as ethnic_group, COUNT(T.ethnicgroups) as num_countries, FLOOR(SUM(T.population)) as total_population
FROM (SELECT y.name as country, eg.`#text` as ethnicgroups, (float(eg.`-percentage`)*0.01*int(y.population)) as population
FROM geo.world x, x.mondial.country y,
(CASE   WHEN y.ethnicgroups IS MISSING THEN []
        WHEN is_array(y.ethnicgroups) THEN y.ethnicgroups
        ELSE [y.ethnicgroups] END) AS eg) as T
GROUP BY T.ethnicgroups
ORDER BY COUNT(T.ethnicgroups) DESC;