USE geo;
SELECT T.religions as religion, COUNT(T.religions) as num_countries
FROM (SELECT y.name as country, r.`#text` as religions
FROM geo.world x, x.mondial.country y,
(CASE   WHEN y.religions IS MISSING THEN []
        WHEN is_array(y.religions) THEN y.religions
        ELSE [y.religions] END) AS r) as T
GROUP BY T.religions
ORDER BY COUNT(T.religions) DESC;