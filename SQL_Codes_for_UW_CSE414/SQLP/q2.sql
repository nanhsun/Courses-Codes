USE geo;
SELECT y.name, y.population, array_count(r) as religions
FROM geo.world x, x.mondial.country y
LET r = CASE    WHEN y.religions is missing THEN []
                WHEN is_array(y.religions) THEN y.religions
                ELSE [y.religions] END
ORDER BY y.name;
