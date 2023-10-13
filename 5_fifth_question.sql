-- Roční změny mezd a cen
WITH prices_salaries_change AS (
    WITH prices_annual_change AS (
        SELECT
            tpm.year_cp,
            sum(tpm.average_prices) AS avg_price_box_current,
            lead(sum(tpm.average_prices)) OVER (ORDER BY tpm.year_cp) AS avg_price_box_next,
            round(100 * (lead(sum(tpm.average_prices)) OVER (ORDER BY tpm.year_cp) / sum(average_prices)) - 100, 2) AS annual_change_box
        FROM
            t_petr_musil_project_SQL_primary_final tpm
        WHERE
            tpm.industry_name = 'Vzdělávání'
        GROUP BY 
            tpm.year_cp
    )
    SELECT
        tpm.year_cp,
        prices_annual_change.annual_change_box AS annual_change_prices,
        round(100 * (lead(sum(tpm.average_salary_CZK)) OVER (ORDER BY tpm.year_cp) / sum(tpm.average_salary_CZK)) - 100, 2) AS annual_change_salaries
    FROM
        t_petr_musil_project_SQL_primary_final tpm
        JOIN prices_annual_change ON tpm.year_cp = prices_annual_change.year_cp
    WHERE
        tpm.food_category = 'Banány žluté'
    GROUP BY 
        tpm.year_cp
)
-- Roční změny HDP
SELECT 
    tpms.`year`,
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
    ) AS GDPpc_annual_change_perc,
    prices_salaries_change.annual_change_prices,
    prices_salaries_change.annual_change_salaries
FROM 
    t_petr_musil_project_SQL_secondary_final tpms
JOIN 
    prices_salaries_change ON prices_salaries_change.year_cp = tpms.`year`
WHERE 
    tpms.country = 'Czech Republic';