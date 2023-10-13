SELECT
	tpm.year_cp,
	tpm.food_category,
	tpm.average_prices AS avg_prices_current_year,
	lead(tpm.average_prices) OVER(PARTITION BY tpm.food_category ORDER BY tpm.year_cp) AS avg_prices_next_year,
	round(((lead(tpm.average_prices) OVER(PARTITION BY tpm.food_category ORDER BY tpm.year_cp) / tpm.average_prices) - 1) * 100, 2) AS annual_change_in_price,
	round(((last_value(tpm.average_prices) OVER(PARTITION BY tpm.food_category ORDER BY tpm.year_cp ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) / first_value(tpm.average_prices) OVER(PARTITION BY tpm.food_category ORDER BY tpm.year_cp ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) - 1) * 100, 2)AS overall_change_price
FROM
	t_petr_musil_project_SQL_primary_final tpm
WHERE
	tpm.industry_name = 'Vzdělávání'
ORDER BY
	tpm.food_category,
	tpm.year_cp;