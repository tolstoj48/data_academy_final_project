# PRICES
SELECT year(date_from), cp.* FROM czechia_price cp INNER JOIN czechia_price_category cpc ON cp.category_code = cpc.code WHERE cp.region_code IS NULL ORDER BY year(date_from);

SELECT year(date_from), count(DISTINCT cpc.code) FROM czechia_price cp INNER JOIN czechia_price_category cpc ON cp.category_code = cpc.code GROUP BY year(date_from);

# Některé kategorie chybí v některých letech - např. "212 101 Jakostní víno bílé" až do roku 2015, jinak je počet kategorií potravin vždy 26 (do roku 2014), dále pak 27
SELECT 
cpc.code AS food_code,
cpc.name AS food_category, 
# Průměr za celý rok - vstup jsou všechny měření ze všech krajů ve všech časových okamžicích v daný rok a z nich se počítá průměr
round(avg(cp.value), 2) AS average_prices,
year(cp.date_from) AS year_cp
FROM czechia_price cp 
LEFT JOIN czechia_price_category cpc ON cp.category_code = cpc.code
GROUP BY cpc.code, cpc.name, year_cp;

# roky, které jsou date_from na cenách potravin
SELECT DISTINCT year(cp.date_from) AS year_date FROM czechia_price cp INNER JOIN czechia_price_category cpc ON cp.category_code = cpc.code ORDER BY year_date;

# PAYROLLS
SELECT * FROM czechia_payroll;

SELECT * FROM czechia_payroll WHERE value_type_code = 5958;

SELECT 
cpib.name AS industry_name,
cpay.payroll_year AS year_payroll,
# Roční průměr - v každém roce jsou většinou čtyři měření
round(avg(cpay.value), 2) AS average_wage_total
FROM czechia_payroll cpay 
LEFT JOIN czechia_payroll_value_type cpvt ON cpay.value_type_code = cpvt.code
LEFT JOIN czechia_payroll_unit cpu ON cpay.unit_code = cpu.code
LEFT JOIN czechia_payroll_industry_branch cpib ON cpay.industry_branch_code = cpib.code
# Nezahrnuji nulové hodnoty mzdy
WHERE cpay.value IS NOT NULL 
# Pouze hodnoty typu Průměrná mzda na zaměstnance -  5958 (nikoliv Průměrný počet zaměstnaných osob - 316)
AND value_type_code = 5958
# Roky, za které jsou data pro ceny potravin - společné roky
AND cpay.payroll_year BETWEEN 2006 AND 2018
# Pouze jeden typ výpočttu by měl vstupovat do průměru, zde 100 = fyzický
AND cpay.calculation_code = 100
GROUP BY cpib.name,cpay.payroll_year
ORDER BY cpib.name;

SELECT * 
FROM czechia_payroll cp 
LEFT JOIN czechia_payroll_industry_branch cpib ON cp.industry_branch_code = cpib.code



# PREFINAL
SELECT 
cpc.name AS food_category,
cpib.name AS industry_name,
cpay.payroll_year AS year_payroll,
# Roční průměr - v každém roce jsou většinou čtyři měření
round(avg(cpay.value), 2) AS average_wages_physical,
# Průměr za celý rok - vstup jsou všechny měření ze všech krajů ve všech časových okamžicích v daný rok a z nich se počítá průměr
round(avg(cp.value), 2) AS average_prices
FROM czechia_price cp 
INNER JOIN czechia_price_category cpc ON cp.category_code = cpc.code
INNER JOIN czechia_payroll cpay ON year(cp.date_from) = cpay.payroll_year
LEFT JOIN czechia_payroll_industry_branch cpib ON cpay.industry_branch_code = cpib.code
# Nezahrnuji nulové hodnoty mzdy
WHERE cpay.value IS NOT NULL 
# Pouze hodnoty typu Průměrná mzda na zaměstnance -  5958 (nikoliv Průměrný počet zaměstnaných osob - 316)
AND cpay.value_type_code = 5958
# Roky, za které jsou data pro ceny potravin - společné roky
AND cpay.payroll_year BETWEEN 2006 AND 2018
# Pouze jeden typ výpočttu by měl vstupovat do průměru, zde 100 = fyzický
AND cpay.calculation_code = 100
#!!! Je tohle za celou ČR?????
AND cp.region_code IS NULL
GROUP BY cpc.name,cpib.name,cpay.payroll_year
ORDER BY cpib.name;