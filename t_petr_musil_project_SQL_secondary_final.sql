CREATE OR REPLACE TABLE t_petr_musil_project_SQL_secondary_final
SELECT 
    c.country,
    e.`year`,
    e.GDP,
    e.gini AS gini_coefficient,
    e.population
FROM 
    countries c
    INNER JOIN economies e ON c.country = e.country
WHERE 
    -- Only european countries
    c.continent = 'Europe'
    -- Only period from the first input table
    AND e.`year` BETWEEN 2006 AND 2018
ORDER BY 
    c.country,
    e.`year`;


-- Helper SQL query
SELECT 
    c.country,
    count(DISTINCT e.year)
FROM 
    countries c
    LEFT JOIN economies e ON c.country = e.country
WHERE 
    c.continent = 'Europe'
    AND e.`year` BETWEEN 2006 AND 2018
GROUP BY 
    c.country
ORDER BY 
    c.country;