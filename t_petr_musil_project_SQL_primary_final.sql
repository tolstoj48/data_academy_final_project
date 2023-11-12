-- by petr_m_10 (discord name) or Petr_M

CREATE OR REPLACE TABLE t_petr_musil_project_SQL_primary_final 
    WITH cpay_aggregated AS (
        SELECT 
            cpib.name AS industry_name,
            cpay.payroll_year AS year_cp,
            -- Year average - four measurements in every year for every sector
            round(avg(cpay.value), 2) AS average_salary_CZK
        FROM 
            czechia_payroll cpay 
            -- Every row has industry_branch_code and values of both are identical
            INNER JOIN czechia_payroll_industry_branch cpib ON cpay.industry_branch_code = cpib.code
            INNER JOIN czechia_payroll_unit cpu ON cpay.unit_code = cpu.code
        WHERE 
            cpay.value IS NOT NULL 
            -- Average salary per employee = 5958, Average number of employess = 316
            AND cpay.value_type_code = 5958
            -- Only one type of calculation should be put into average, physical = 100, recalculated = 200
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
    -- Average for the whole year - input are all measurements for every region in all time spots in the given year - the base for calculation
    round(avg(cp.value), 2) AS average_prices,
    cpc.price_unit as food_unit
FROM 
    cpay_aggregated 
    -- Only common years -> therefore inner join
    INNER JOIN czechia_price cp ON year(cp.date_from) = cpay_aggregated.year_cp
    LEFT JOIN czechia_price_category cpc ON cp.category_code = cpc.code
-- Calculating average from values for the whole Czechia, not average of prices from regions
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