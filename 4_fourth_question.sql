-- změny ceny celého spotřebního koše meziroční
SELECT
	tpm.year_cp,
	sum(tpm.average_prices) AS avg_price_box_current,
	lead(sum(tpm.average_prices)) OVER (ORDER BY tpm.year_cp) AS avg_price_box_next,
	round(100 * (lead(sum(tpm.average_prices)) OVER (ORDER BY tpm.year_cp) / sum(average_prices)) - 100, 2) AS annual__change_box
FROM
	t_petr_musil_project_SQL_primary_final tpm
WHERE
	tpm.industry_name = 'Vzdělávání'
GROUP BY 
	tpm.year_cp;

-- změny ceny mezd za všechna odvětví
SELECT
	tpm.year_cp,
	sum(tpm.average_salary_CZK) AS avg_salary_box_current,
	lead(sum(tpm.average_salary_CZK)) OVER (ORDER BY tpm.year_cp) AS avg_price_box_next,
	round(100 * (lead(sum(tpm.average_salary_CZK)) OVER (ORDER BY tpm.year_cp) / sum(tpm.average_salary_CZK)) - 100, 2) AS annual__change_box
FROM
	t_petr_musil_project_SQL_primary_final tpm
WHERE
	tpm.food_category = 'Banány žluté'
GROUP BY 
	tpm.year_cp;