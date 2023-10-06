# Tady nejsou data za ty roky --> nejde dělat smysluplné vážěné průměry, protože chybí hodnoty počtu pracovníků za všechna odvětví v každém roce (už vůbec nejsou data za jednotlivé kvaráty)
SELECT
tpm.industry_name, 
tpm.average_value_counted AS salary_2006,
tpm2.average_value_counted AS salary_2018,
tpm.average_prices AS prices_of_food_2006,
tpm2.average_prices AS prices_of_food_2018,
tpm.food_category,
tpm.price_unit,
round(tpm.average_value_counted / tpm.average_prices, 2) AS units_available_2006,
round(tpm2.average_value_counted / tpm2.average_prices, 2) AS units_available_2018,
CASE
	WHEN tpm.average_value_counted / tpm.average_prices >= tpm2.average_value_counted / tpm2.average_prices THEN 'less or same'
	ELSE 'more'
END AS change_between_06_18
FROM t_petr_musil_project_SQL_primary_final tpm 
INNER JOIN t_petr_musil_project_SQL_primary_final tpm2 ON tpm.year_cp = tpm2.year_cp - 12 AND tpm.industry_name = tpm2.industry_name AND tpm.food_category = tpm2.food_category
WHERE 
tpm.food_category IN ('Chléb konzumní kmínový','Mléko polotučné pasterované')
AND tpm.value_type_code = 5958
AND tpm2.value_type_code = 5958
AND tpm.year_cp IN (2006, 2018)
ORDER BY tpm.year_cp, tpm.industry_name;

# HELPERS
# 
select * from czechia_payroll cp inner join czechia_payroll_industry_branch cpib on cp.industry_branch_code = cpib.code 
# value type 316 = zaměstnaných osob
where cp.value_type_code = 316 
and cp.payroll_year between 2006 and 2018 
# code 100 = fyzických, 200 přepočtených, ale obě jsou docela prořídlé na roky, i když se to udělá za všechny typy hodnot, tak to nedá za všechna odvětví 
#and cp.calculation_code = 200 
# bez hodnot to nemá cenu
and cp.value is not null
ORDER by cp.payroll_year, cp.industry_branch_code;