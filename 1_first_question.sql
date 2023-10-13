SELECT
	tpm.industry_name,
	tpm.year_cp,
	max(tpm.average_salary_CZK) AS current_year_salary_CZK,
	lead(tpm.average_salary_CZK) OVER (PARTITION BY tpm.industry_name ORDER BY tpm.year_cp) AS next_year_salary_CZK,
	round(100 * lead(tpm.average_salary_CZK) OVER (PARTITION BY tpm.industry_name ORDER BY tpm.year_cp) / max(tpm.average_salary_CZK) - 100, 2) AS annual_change_salary
FROM
	t_petr_musil_project_SQL_primary_final tpm
GROUP BY
	tpm.industry_name,
	tpm.year_cp;