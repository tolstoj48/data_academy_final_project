# Projekt
# spojit czechia_payroll a czechia_price lze pomocí roku akorát --> ON year(cp.date_from) = cpay.payroll_year
# SELECT * FROM czechia_price cp JOIN czechia_payroll cpay ON year(cp.date_from) = cpay.payroll_year;
# zapisovat aliasy všechny snake_casem shodně
# Využít date_format(sloupec s datem, '%d.%m.%Y') --> formát viz dokumentace
# TO DO prověřit si data - inner vs. left join, prověřit celkové, že to tak je, komenty česky
# Průměr mezd dle odvětví ve vývoji
SELECT cpib.name AS "Industry",
    cp.payroll_year AS "Year",
    round(avg(cp.value)) AS "Average wages"
FROM czechia_price cp
    LEFT JOIN czechia_payroll_industry_branch cpib ON cp.industry_branch_code = cpib.code
WHERE # 5958 = Průměrná hrubá mzda na zaměstnance
    cp.value_type_code = 5958
    AND cpib.name IS NOT NULL
    AND cp.payroll_year IN (2006, 2018)
GROUP BY cpib.name,
    cp.payroll_year
ORDER BY cpib.name,
    cp.payroll_year;
# Ceny
SELECT year(cp.date_from) as "Year",
    cpc.name AS "Food category",
    round(avg(cp.value), 2) AS "Average price"
FROM czechia_price cp
    LEFT JOIN czechia_price_category cpc ON cp.category_code = cpc.code
WHERE cpc.name IN (
        'Chléb konzumní kmínový',
        'Mléko polotučné pasterované'
    ) # První rok za ceny je 2000 a poslední rok byl 2018 - ve sloupci date from
    AND year(cp.date_from) IN (2006, 2018)
GROUP BY year(cp.date_from),
    cpc.name;
# -------------------- POMOCNÉ
SELECT *
FROM czechia_price cp
    INNER JOIN czechia_price_category cpc ON cp.category_code = cpc.code
WHERE cpc.name IN (
        'Chléb konzumní kmínový',
        'Mléko polotučné pasterované'
    )
    AND year(cp.date_from) IN (2006, 2018);


# Prvně vytváříme první dvě tabulky a pak vytvoříme pět souborů SQL --> dohromady to bude sedm SQL
# Plus průvodní listina - obsahovat úvod projektu, popis tabulek dvou, výzkumné otázky a odpovědi konkrétní na ně, dále popisy proč jsme co vytvářeli, jak jsme to dělali a okomentovat vše
# Tzn. průvodní listina plus sedm SQL dotazů
# ale bude potřeba doplni ještě o všechny roky
/*Úkol 2 --> tohle se už blíží požadovanému výsledku*/
SELECT cpib.name AS industry,
    cpay.payroll_year AS payroll_year,
    cpc.name AS food_category,
    round(avg(cpay.value)) AS average_wages,
    round(avg(cp.value), 2) AS average_prices
FROM czechia_price cp # jenom společné roky
    JOIN czechia_payroll cpay ON year(cp.date_from) = cpay.payroll_year
    LEFT JOIN czechia_payroll_industry_branch cpib ON cpay.industry_branch_code = cpib.code
    LEFT JOIN czechia_price_category cpc ON cp.category_code = cpc.code
WHERE cpc.name IN (
        'Chléb konzumní kmínový',
        'Mléko polotučné pasterované'
    ) # 5958 = Průměrná hrubá mzda na zaměstnance
    AND cpay.value_type_code = 5958
    AND cpib.name IS NOT NULL # První rok za ceny je 2006 a poslední rok byl 2018 - ve sloupci date from
    AND cpay.payroll_year BETWEEN 2006 AND 2018
GROUP BY cpib.name,
    cpay.payroll_year,
    cpc.name
ORDER BY cpib.name,
    cpay.payroll_year;


# POMOCNÉ
SELECT *
FROM czechia_price cp;
SELECT count(1)
FROM czechia_price cp;
SELECT DISTINCT cp.region_code
FROM czechia_price cp;
# --> 14 krajů a null 
SELECT DISTINCT year(cp.date_from) AS year
FROM czechia_price cp
ORDER BY year;
# --> ceny za roky 2006 - 20018
SELECT *
FROM czechia_price cp
    JOIN czechia_region cr ON cp.region_code = cr.code;
SELECT COUNT(1)
FROM czechia_price cp
    JOIN czechia_region cr ON cp.region_code = cr.code;
SELECT COUNT(1)
FROM czechia_price cp
WHERE cp.region_code IS NULL;
# některé řádky czechia_price nemají přidělený region_code, INNE JOINy něco pak vyřadí
SELECT COUNT(1)
FROM czechia_price cp
    JOIN czechia_price_category cpc ON cp.category_code = cpc.code;
SELECT COUNT(1)
FROM czechia_price cp
WHERE cp.category_code IS NULL;
# --> vrací 0, tzn. každá cena má přidělený category_code
SELECT DISTINCT cp.category_code
FROM czechia_price cp;
# --> 27 hodnot bez null
SELECT cpc.code
FROM czechia_price_category cpc;
(
    SELECT DISTINCT cp.category_code
    FROM czechia_price cp
)
EXCEPT (
        SELECT cpc.code
        FROM czechia_price_category cpc
    ) # --> odtud plus o řádek níže plyne, že neexistuje žádný category_code, který by byl v czech_price a nebyl v czech_price_category, a je možné v klidu provádět INNER JOINy mezi těmito dvěma
    (
        SELECT cpc.code
        FROM czechia_price_category cpc
    )
EXCEPT (
        SELECT DISTINCT cp.category_code
        FROM czechia_price cp
    )