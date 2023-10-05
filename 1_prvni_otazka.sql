SELECT tpm.industry_name,
    tpm.year_cp AS year_prev,
    tpm2.year_cp AS year_next,
    max(tpm.average_wages_physical) AS average_wages_physical_prev,
    max(tpm2.average_wages_physical) AS average_wages_physical_next,
    round(
        max(tpm2.average_wages_physical) / max(tpm.average_wages_physical),
        2
    ) AS change_in_wages
FROM t_petr_musil_project_SQL_primary_final tpm
    JOIN t_petr_musil_project_SQL_primary_final tpm2 ON tpm.industry_name = tpm2.industry_name
    AND tpm.year_cp = tpm2.year_cp - 1
GROUP BY tpm.industry_name,
    tpm.year_cp,
    year_next;