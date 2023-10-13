CREATE OR REPLACE TABLE t_petr_musil_project_SQL_primary_final 
    WITH cpay_aggregated AS (
        SELECT 
            cpib.name AS industry_name,
            cpay.payroll_year AS year_cp,
            -- Roční průměr - v každém roce jsou čtyři měření pro každý obor
            round(avg(cpay.value), 2) AS average_salary_CZK
        FROM 
            czechia_payroll cpay 
            -- Každý řádek má industry_branch_code a množiny hodnot obou se shodují
            INNER JOIN czechia_payroll_industry_branch cpib ON cpay.industry_branch_code = cpib.code
            INNER JOIN czechia_payroll_unit cpu ON cpay.unit_code = cpu.code
        WHERE 
            cpay.value IS NOT NULL 
            -- Průměrná mzda na zaměstnance = 5958, Průměrný počet zaměstnaných osob = 316
            AND cpay.value_type_code = 5958
            -- Pouze jeden typ výpočtu by měl vstupovat do průměru, zde fyzický = 100, přepočtený = 200
            AND cpay.calculation_code = 200
        GROUP BY 
            cpib.name,
            cpay.payroll_year
    )
SELECT 
    cpay_aggregated.year_cp,
    cpay_aggregated.industry_name,
    cpay_aggregated.average_salary_CZK,
    cpc.name AS food_category,
    -- Průměr za celý rok - vstup jsou všechny měření ze všech krajů ve všech časových okamžicích v daný rok a z nich se počítá průměr
    round(avg(cp.value), 2) AS average_prices,
    cpc.price_unit as food_unit
FROM 
    cpay_aggregated 
    -- Jen společné roky, proto inner join
    INNER JOIN czechia_price cp ON year(cp.date_from) = cpay_aggregated.year_cp
    LEFT JOIN czechia_price_category cpc ON cp.category_code = cpc.code
-- Počítáme průměr z hodnot za celé Česko, nikoliv průměr cen z regionů
WHERE 
    cp.region_code IS NULL
GROUP BY 
    cpc.name,
	cpc.price_unit,
    cpay_aggregated.year_cp,
    cpay_aggregated.industry_name
ORDER BY 
    cpay_aggregated.year_cp,
    cpay_aggregated.industry_name,
    cpc.name,
    cpc.price_unit;