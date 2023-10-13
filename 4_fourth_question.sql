SELECT
	tpm.year_cp,
	tpm.food_category,
	tpm.industry_name,
	round(((lead(tpm.average_prices) OVER(PARTITION BY tpm.food_category, tpm.industry_name ORDER BY tpm.year_cp) / tpm.average_prices) - 1) * 100, 2) AS annual_change_in_price,
	round(100 * lead(tpm.average_salary_CZK) OVER (PARTITION BY tpm.industry_name, tpm.food_category ORDER BY tpm.year_cp) / tpm.average_salary_CZK - 100, 2) AS annual_change_salary,
	round((((lead(tpm.average_prices) OVER(PARTITION BY tpm.food_category, tpm.industry_name ORDER BY tpm.year_cp) / tpm.average_prices) - 1) * 100) - (100 * lead(tpm.average_salary_CZK) OVER (PARTITION BY tpm.industry_name, tpm.food_category ORDER BY tpm.year_cp) / tpm.average_salary_CZK - 100), 2) AS difference_price_salary_change_perc
FROM
	t_petr_musil_project_SQL_primary_final tpm
ORDER BY
	tpm.food_category,
	tpm.year_cp;