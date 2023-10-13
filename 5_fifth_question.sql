-- změny vypočtu raděj v HDP na osobu, protože to je relevantní ukazatel nějakého vývoje, protože růst HDP doprovázen růstem populace ještě neznamená, že je více produktu na obyvatele
SELECT 
    tpms.`year`,
    round(tpms.GDP / tpms.population, 2) AS GDP_current_per_capita,
    round(
        lead(tpms.GDP) OVER (
            PARTITION BY tpms.country
            ORDER BY tpms.`year`
        ) / lead(tpms.population) OVER (
            PARTITION BY tpms.country
            ORDER BY tpms.`year`
        ),
        2
    ) AS GDP_next_year_per_capita,
    round(
        100 * (
            (
                lead(tpms.GDP) OVER (
                    PARTITION BY tpms.country
                    ORDER BY tpms.`year`
                ) / lead(tpms.population) OVER (
                    PARTITION BY tpms.country
                    ORDER BY tpms.`year`
                )
            ) / (tpms.GDP / tpms.population)
        ) - 100,
        2
    ) AS GDPpc_annual_change_perc
FROM 
    t_petr_musil_project_SQL_secondary_final tpms
WHERE 
    tpms.country = 'Czech Republic';