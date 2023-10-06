SELECT tpm.industry_name,
    tpm.year_cp AS year_prev,
    tpm2.year_cp AS year_next,
    max(tpm.average_wages_counted) AS average_wages_counted_prev,
    max(tpm2.average_wages_counted) AS average_wages_counted_next,
    round(
        100 * (
            (
                max(tpm2.average_wages_counted) / max(tpm.average_wages_counted)
            ) - 1
        ),
        2
    ) AS annual_change_wages_in_perc
FROM t_petr_musil_project_SQL_primary_final tpm
    INNER JOIN t_petr_musil_project_SQL_primary_final tpm2 ON tpm.industry_name = tpm2.industry_name
    AND tpm.year_cp = tpm2.year_cp - 1
GROUP BY tpm.industry_name,
    tpm.year_cp,
    year_next;