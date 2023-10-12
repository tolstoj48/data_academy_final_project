3. popsat otázky delší

## Obsah:
* [Úvod do projektu](#úvod-do-projektu)
* [Vstupní datové sady pro získání podkladu](#vstupní-datové-sady-pro-získání-podkladu)
* [Výzkumné otázky a odpovědi](#výzkumné-otázky-a-odpovědi)
* [Výstupy projektu](#výstup-projektu)

## Úvod do projektu:
Analytické oddělení naší organizace, která se zabývá vývojem životní úrovně občanů v Česku, chce odpovědět na několik definovaných výzkumných otázek. Ty adresují dostupnost základních potravin veřejnosti. Kolegové již vydefinovali základní otázky, na které se pokusí odpovědět a poskytnout tuto informaci tiskovému oddělení, a to pro účely prezentace na následující konferenci zaměřené na tuto oblast. Požadují proto datové podklady, z kterých bude jasné porovnání dostupnosti potravin na základě průměrných příjmů za určité časové období. Jako podpůrný materiál chtějí také tabulku s HDP, GINI koeficientem a populací dalších evropských zemí, a to za stejné období jako přehled pro Česko.

## Vstupní datové sady pro získání podkladu:
## Primární tabulky:
czechia_payroll – Informace o mzdách v různých odvětvích za několikaleté období. Datová sada pochází z Portálu otevřených dat ČR.

czechia_price – Informace o cenách vybraných potravin za několikaleté období. Datová sada pochází z Portálu otevřených dat ČR.

## Podpůrné číselníky:
czechia_payroll_calculation – Číselník kalkulací v tabulce mezd.

czechia_payroll_industry_branch – Číselník odvětví v tabulce mezd.

czechia_payroll_unit – Číselník jednotek hodnot v tabulce mezd.

czechia_payroll_value_type – Číselník typů hodnot v tabulce mezd.

czechia_price_category – Číselník kategorií potravin, které se vyskytují v našem přehledu.

Číselníky sdílených informací o ČR:

## Tabulky pro evropské země:
countries - Všemožné informace o zemích na světě, například hlavní město, měna, národní jídlo nebo průměrná výška populace.
economies - HDP, GINI, daňová zátěž, atd. pro daný stát a rok.

## Výzkumné otázky a odpovědi
### 1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
Vycházíme z dat v tabulce t_petr_musil_project_SQL_primary_final, kde jsou dostupná data za roky 2006 až 2018 - společné roky pro ceny i mzdy. Pokud posuzujeme růst nominální výše mezd/platů za celé období 2006 až 2018, došlo k růstu ve všech odvětvích.
Meziroční přírůstky jsou ve většině let ve všech odvětvích kladné, ale zároveň platí, že většina odvětví v daném období
zaznamenalo alespoň jeden meziroční pokles nominální výše mezd/platů. Výjimku tvořila Doprava a skladování s jedním meziročním 
přírůstkem rovným nule, dále Ostatní činnosti, Zdravotní a sociální péče a Zpracovatelský průmysl, v nichž meziročně mzdy rostly každý rok. Největší meziroční pokles zaznemalo odvětví Peněžnictví a pojišťovnictví mezi lety 2012 a 2013 s hodnotou -8.83 %. Naopak největší meziroční růst jsme sledovali mezi lety 2007 a 2008 v odvětví Výroba a rozvod elektřiny, plynu a tepla s hodnotou +13.76 %.
Poklesy nominálním mezd a platů lze patrně přičíst ekonomickému vývoji po finanční krizi po roce 2007-8, kdy najdeme většinu poklesů v dílčích odvětvích. Další poklesy pak byly zaznamenány z roku 2012 na 2013, což je někdy veřejností přičítáno ekonomickému poklesu vlivem fiskální politiky tehdejší české vlády.
### 2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
Na tuto otázku se nedá na základě dostupných dat obecně odpovědět - nelze určit celkovou průměrnou mzdu za všechna odvětví dohromady. Data za počet zaměstnanců jsou dostupná v prvním a posledním sledovaném odbobí jen za vybraná odvětví - v roce 2006 pro devět (navíc různými způsoby výpočtu - fyzicky, přepočtením) a v roce 2018 pro deset z 19. Nelze proto vypočítat celkovou průměrnou mzdu v Česku pomocí váženého průměru. Posuzovat tedy lze (pokud chceme posoudit roky 2006 a 2018 jako výchozí a konečné roky) pouze vývoj za jednotlivá odvětví. Protože cena chleba vzrostla mezi lety 2006 a 2018 z 16.12 Kč na 24.24, tedy o 50.37 %, pak v odvětvích, v nichž docházelo k pomalejšímu růstu průměrných mezd si pracovníci mohli pořídit v roce 2018 méně nebo stejně kilogramů chleba. Například v Administrativních a podpůrných činnostech to byl pokles z 896.03 na 864.4 kg chleba, dále Činnosti v oblasti nemovitostí z 1193.67 na 1159.61, Ostatní činnosti z 1022.57 na 977.58, Peněžnictví z 2483 na 2264.16, Těžba a dobývání z 1492.97 na 1486.76 Ve zbývajících odvětvích si naopak zaměstnanci mohli ze mzdy/platu pořídit více. Cena mléka pak vzrostla mezi sledovanými lety z 14.44 Kč na 19.82 Kč, což byl růst o 37.26 %. Proto si jednotek mléka mohli pořídit v roce 2018 více než na začátku sledovaného období pracovníci ze všech odvětví, vyjma Peněžnictví a pojišťovnictví, v němž došlo k poklesu z 2771.95 na 2769.08 litru mléka.
### 3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?
--> TODO - jak chceme růsty, ale za roky
### 4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
-->  TODO
### 5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?

## Výstup projektu
Výstupem jsou dvě tabulky v databázi, ze kterých se požadovaná data nutná k zodpovězení výzkumných otázek dají získat. Dále pak pět souborů s SQL dotazem do daných tabulek, které umožňují zodpovědezní výzkumných otázek:

1. t_petr_musil_project_SQL_primary_final.sql - pro data mezd a cen potravin za Českou republiku sjednocených na totožné 
porovnatelné období – společné roky. 
Pro generování výsledné tabulky jsem využil common table expression (CTE), a to z jednoduchého důvodu. Nejprve jsem se totiž pokoušel provést spojení tabulek za czechia_payroll a czechia_price a na nich provést agregační fci avg(). Na db je nastaven timeout, který po naspojování tabulek a na nich prováděných agregacích (zpětné rozčleňování řádků do kategorií podle GROUP BY) dotaz překročil. CTE mi přišlo jako vhodný nástroj (alternativa pro vnořené dotazy na FROM), jak provést agregační funkce před spojením a zmnožením řádků zvlášť a navíc zjednodušit původní SQL dotaz z hlediska čitelnosti. Za czechia_payroll jsem počítal průměrnou mzdu pro dané odvětví jako prostý průměr výše průměrných mezd pro daný rok za dílčí kvartály (value_type_code 5958 - průměrná mzda) a dle jednoho způsobu vykazování (calculation code - 200 - přepočtený). Nechtěl jsem míchat různé typy vykazování - odlišný typ dat. Výslednou tabulku z czechia_payroll jsem pak spojil s czechia_price pomocí roku (GROUP BY na czechia_payroll), což mi zajistilo, že se spojila data jen za společné roky pro obě vstupní datové sady. Na tabulce czechia_price jsem nastavil hodnoty pouze s region_code rovným NULL (jde o průměr ceny za celé Česko). Protože je měření pro každý druh produktu během daného roku hned několik, zvolil jsem pro výpočet průměrné ceny za daný rok pro daný produkt agregační fci avg() a členění dle roku year(date_from). Použití prostých průměrů zejména v případě výše průměrných mezd by bylo možné nahradit váženými průměry, ale v takovém případě by musela být dostupná data za počet zaměstnanců pro všechny kvartály všech let, v nichž máme hodnoty průměrných mezd, čemuž tak není a musíme se spokojit s průměry prostými.

2. t_petr_musil_project_SQL_secondary_final.sql - pro dodatečná data o dalších evropských státech. Zde bylo nutné vytvořit časové řady pro jednotlivé země Evropy a jejich dílčí ukazatele. Spojil jsem dvě tabulky, countries (základní data za země vč. informace, o tom, na jakém jsou kontinentu) s economies (časové řady), pomocí LEFT JOINu - nebyl jsem si jistý, zda některé názvy zemí se v obou tabulkách pro evropské země neliší. Protože jsem si pak ještě ověřil pomocným dotazem, že počet let pro dané ukazatele se pro všechny názvy zemí z tabulky countries v tabulce economies shodují - 13, změnil jsem dotaz na (INNER) JOIN. Období jsem vyfiltroval na 2006 až 2018, což je obodbí, které bylo možné sledovat v datech z tabulky t_petr_musil_project_SQL_primary_final.sql - první výstup projektu.

3. 1_first_question.sql, 2_second_question.sql, 3_third_question.sql, 4. fourth_question.sql, 5_fifth_question.sql.
