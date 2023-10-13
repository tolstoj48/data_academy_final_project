-- změny ceny celého spotřebního koše meziroční
SELECT
	tpm.year_cp,
	sum(average_prices) AS avg_price_box_current,
	lead(sum(average_prices)) over (ORDER by tpm.year_cp) AS avg_price_box_next,
	round(100 * (lead(sum(average_prices)) over (ORDER by tpm.year_cp) / sum(average_prices)) - 100, 2) AS annual__change_box
FROM
	t_petr_musil_project_SQL_primary_final tpm
WHERE
	tpm.industry_name = 'Vzdělávání'
GROUP BY 
	tpm.year_cp;