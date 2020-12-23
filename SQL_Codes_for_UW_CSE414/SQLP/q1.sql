USE geo;
SELECT u.name as city
FROM geo.world x, x.mondial.country y, y.province z, 
            CASE  WHEN is_array(z.city) THEN z.city
                  ELSE [z.city] END u
WHERE y.name = 'Peru'
ORDER BY u.name;