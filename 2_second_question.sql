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
-- Otherwise two rows for every year
LIMIT 38;