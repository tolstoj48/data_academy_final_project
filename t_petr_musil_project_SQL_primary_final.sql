# FINAL
SELECT 
    cpc.name AS food_category,
    cpib.name AS industry_name,
    cpay.payroll_year AS year_cp,
    # Roční průměr - v každém roce jsou většinou čtyři měření
    round(cpay.value, 2) AS average_wages_physical,
    # Průměr za celý rok - vstup jsou všechny měření ze všech krajů ve všech časových okamžicích v daný rok a z nich se počítá průměr
    round(avg(cp.value), 2) AS average_prices
FROM 
    czechia_price cp
    INNER JOIN czechia_price_category cpc ON cp.category_code = cpc.code
    INNER JOIN czechia_payroll cpay ON year(cp.date_from) = cpay.payroll_year
    INNER JOIN czechia_payroll_industry_branch cpib ON cpay.industry_branch_code = cpib.code 
WHERE 
    # Nezahrnuji nulové hodnoty mzdy
    cpay.value IS NOT NULL 
    # Pouze hodnoty typu Průměrná mzda na zaměstnance = 5958 (nikoliv Průměrný počet zaměstnaných osob = 316)
    AND cpay.value_type_code = 5958 
    # Pouze jeden typ výpočttu by měl vstupovat do průměru, zde fyzický = 100
    AND cpay.calculation_code = 100 
    # Výši mzdy bereme z posledního čtvrtletí, každý rok má v každém odvětví hodnotu za 4. čtvrtletí
    AND cpay.payroll_quarter = 4
    AND cpib.name IS NOT NULL
    AND cpc.name IS NOT NULL
GROUP BY 
    cpc.name,
    cpib.name,
    year_cp
ORDER BY 
    industry_name,
    year_cp;