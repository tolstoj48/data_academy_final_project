-- Tady nejsou data za ty roky --> nejde dělat smysluplné vážěné průměry, protože chybí hodnoty počtu pracovníků za všechna odvětví v každém roce (už vůbec nejsou data za jednotlivé kvaráty)
-- Ani bez ohledu na způsob zisku dat nelze složit tak, aby pro každé odvětví byla alespoň jedno čtvrletí hodnota v každém roce, ani pro rok 2006 ani pro rok 2018 se to nedá dohromady -> tzn. nelze z toho dopočítat průměrné mzdy za celý
SELECT
	max(tpm.industry_name), 
	first_value(tpm.average_salary_CZK) OVER (PARTITION BY tpm.industry_name ORDER BY tpm.year_cp) AS salary_2006_CZK,
	last_value(tpm.average_salary_CZK) OVER (PARTITION BY tpm.industry_name ORDER BY tpm.year_cp ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS salary_2018_CZK,
	first_value(tpm.average_prices) OVER (PARTITION BY tpm.food_category ORDER BY tpm.year_cp) AS prices_of_food_2006_CZK,
	last_value(tpm.average_prices) OVER (PARTITION BY tpm.food_category ORDER BY tpm.year_cp ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)  AS prices_of_food_2018_CZK,
	tpm.food_category,
	round(first_value(tpm.average_salary_CZK) OVER (PARTITION BY tpm.industry_name ORDER BY tpm.year_cp) / first_value(tpm.average_prices) OVER (PARTITION BY tpm.food_category ORDER BY tpm.year_cp), 2) AS units_available_2006,
	round(last_value(tpm.average_salary_CZK) OVER (PARTITION BY tpm.industry_name ORDER BY tpm.year_cp ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) / last_value(tpm.average_prices) OVER (PARTITION BY tpm.food_category ORDER BY tpm.year_cp ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), 2) AS units_available_2018,
	CASE
		WHEN first_value(tpm.average_salary_CZK) OVER (PARTITION BY tpm.industry_name ORDER BY tpm.year_cp) / first_value(tpm.average_prices) OVER (PARTITION BY tpm.food_category ORDER BY tpm.year_cp) >= last_value(tpm.average_salary_CZK) OVER (PARTITION BY tpm.industry_name ORDER BY tpm.year_cp ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) / last_value(tpm.average_prices) OVER (PARTITION BY tpm.food_category ORDER BY tpm.year_cp ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) THEN 'less or same'
		ELSE 'more'
	END AS change_between_06_18
FROM 
	t_petr_musil_project_SQL_primary_final tpm 
WHERE 
	tpm.food_category IN ('Chléb konzumní kmínový','Mléko polotučné pasterované')
	AND tpm.year_cp IN (2006, 2018)
GROUP BY 
	tpm.industry_name, 
	tpm.food_category, 
	tpm.year_cp
ORDER BY 
	tpm.year_cp, 
	tpm.industry_name
-- Jinak dva řádky pro každý rok
LIMIT 38;