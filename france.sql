--womens AVG salary/h for Froance:
SELECT 
    ROUND(AVG(salary_women)::numeric, 2) AS avg_women
FROM 
    net_salary_per_town_categories nsptc;

--mens AVG salary/h for Froance:
SELECT  
    ROUND(AVG(salary_men)::numeric, 2) AS avg_men
FROM 
    net_salary_per_town_categories nsptc;


--womens and mens AVG salary/h for Froance:
SELECT 
    ROUND(AVG(salary_women)::numeric, 2) AS avg_women, 
    ROUND(AVG(salary_men)::numeric, 2) AS avg_men
FROM 
    net_salary_per_town_categories nsptc;
 
   --women AVG salary/h grouped by regions:
   
SELECT 
	region,
	ROUND(AVG(salary_women)::numeric, 2) AS avg_women
FROM
	net_salary_per_town_categories nsptc
JOIN name_geographic_information ngi  ON nsptc.town_code = ngi.town_code
GROUP BY region;


-- mens AVG salary/h grouped by regions:
   
SELECT 
	region,
    ROUND(AVG(salary_men)::numeric, 2) AS avg_men
FROM
	net_salary_per_town_categories nsptc
JOIN name_geographic_information ngi  ON nsptc.town_code = ngi.town_code
GROUP BY region;
   
--womens and mens AVG salary/h grouped by regions:
   
SELECT 
	region,
	ROUND(AVG(salary_women)::numeric, 2) AS avg_women, 
    ROUND(AVG(salary_men)::numeric, 2) AS avg_men
FROM
	net_salary_per_town_categories nsptc
JOIN name_geographic_information ngi  ON nsptc.town_code = ngi.town_code
GROUP BY region;


--Median womens salary/h grouped by regions:
SELECT
	region,
	percentile_cont(0.5) WITHIN GROUP (ORDER BY salary_women) AS median_salary
FROM net_salary_per_town_categories nsptc 
JOIN name_geographic_information ngi  ON nsptc.town_code = ngi.town_code
GROUP BY region;


--Median mens salary/h grouped by regions:
SELECT
	region,
	percentile_cont(0.5) WITHIN GROUP (ORDER BY salary_men) AS median_men_salary
FROM net_salary_per_town_categories nsptc 
JOIN name_geographic_information ngi  ON nsptc.town_code = ngi.town_code
GROUP BY region;


--Median womens and mens salary/h grouped by regions:
SELECT
	region,
	percentile_cont(0.5) WITHIN GROUP (ORDER BY salary_men) AS median_men_salary,
	percentile_cont(0.5) WITHIN GROUP (ORDER BY salary_women) AS median_salary
FROM net_salary_per_town_categories nsptc 
JOIN name_geographic_information ngi  ON nsptc.town_code = ngi.town_code
GROUP BY region;


--Median womens salary/h grouped by regions:
SELECT
	region,
	percentile_cont(0.5) WITHIN GROUP (ORDER BY salary_women) AS median_women_salary
FROM net_salary_per_town_categories nsptc 
JOIN name_geographic_information ngi  ON nsptc.town_code = ngi.town_code
GROUP BY region;


--SUM of all firms grouped by regions:
SELECT 
	ngi.region, 
	firms_all 
FROM base_etablissement_par_tranche_effectif bepte
JOIN name_geographic_information ngi ON ngi.region_code = bepte.region_code 
GROUP BY
	ngi.region, 
	bepte.firms_all;




--SUM of unkown firms grouped by regions:
SELECT 
	ngi.region, 
	bepte.firms_uknown
FROM base_etablissement_par_tranche_effectif bepte
JOIN name_geographic_information ngi ON ngi.region_code = bepte.region_code 
GROUP BY
	ngi.region, 
	bepte.firms_uknown;


--SUM of firms_1_5 grouped by regions:
SELECT 
	ngi.region, 
	bepte.firms_1_5
FROM base_etablissement_par_tranche_effectif bepte
JOIN name_geographic_information ngi ON ngi.region_code = bepte.region_code 
GROUP BY
	ngi.region, 
	bepte.firms_1_5;



--SUM of firms_6_9 grouped by regions:
SELECT 
	ngi.region, 
	bepte.firms_6_9
FROM base_etablissement_par_tranche_effectif bepte
JOIN name_geographic_information ngi ON ngi.region_code = bepte.region_code 
GROUP BY
	ngi.region, 
	bepte.firms_6_9;


--SUM of firms_10_19 grouped by regions:
SELECT 
	ngi.region, 
	bepte.firms_10_19
FROM base_etablissement_par_tranche_effectif bepte
JOIN name_geographic_information ngi ON ngi.region_code = bepte.region_code 
GROUP BY
	ngi.region, 
	bepte.firms_10_19;


--SUM of firms_20_49 grouped by regions:
SELECT 
	ngi.region, 
	bepte.firms_20_49
FROM base_etablissement_par_tranche_effectif bepte
JOIN name_geographic_information ngi ON ngi.region_code = bepte.region_code 
GROUP BY
	ngi.region, 
	bepte.firms_20_49;


--SUM of firms_50_99 grouped by regions:
SELECT 
	ngi.region, 
	bepte.firms_50_99
FROM base_etablissement_par_tranche_effectif bepte
JOIN name_geographic_information ngi ON ngi.region_code = bepte.region_code 
GROUP BY
	ngi.region, 
	bepte.firms_50_99;


--SUM of firms_100_199 grouped by regions:
SELECT 
	ngi.region, 
	bepte.firms_100_199
FROM base_etablissement_par_tranche_effectif bepte
JOIN name_geographic_information ngi ON ngi.region_code = bepte.region_code 
GROUP BY
	ngi.region, 
	bepte.firms_100_199;


--SUM of firms_200_499 grouped by regions:
SELECT 
	ngi.region, 
	bepte.firms_200_499
FROM base_etablissement_par_tranche_effectif bepte
JOIN name_geographic_information ngi ON ngi.region_code = bepte.region_code 
GROUP BY
	ngi.region, 
	bepte.firms_200_499;


--SUM of firms_above_500 grouped by regions:
SELECT 
	ngi.region, 
	bepte.firms_above_500
FROM base_etablissement_par_tranche_effectif bepte
JOIN name_geographic_information ngi ON ngi.region_code = bepte.region_code 
GROUP BY
	ngi.region, 
	bepte.firms_above_500;























