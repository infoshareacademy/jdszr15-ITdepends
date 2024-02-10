select 
avg(salary)*160 as mean_monthly, avg(salary_h_ceo)*160 as mean_monthly_exectuvie,
min(salary)*160 as min_mean_monthly , min(salary_h_ceo)*160 as min_mean_monthly_exectuvie,
max(salary)*160 as max_mean_monthly, max(salary_h_ceo)*160 as max_mean_monthly_exectuvie
from net_salary_per_town_categories nsptc  /* średnia miesięczna  */ 

-- min, średnia, max dla CEO i ogólna
select 
avg(salary) as monthly, avg(salary_h_ceo) as mean_exectuvie,
min(salary) as min_monthly , min(salary_h_ceo) as min_monthly_exectuvie,
max(salary) as max_monthly, max(salary_h_ceo) as max_monthly_exectuvie
from net_salary_per_town_categories nsptc

select round(avg(salary_h_18_25)::numeric,2), avg(salary_h_women_26_50), avg(salary_h_women_50)
from net_salary_per_town_categories nsptc 

 -- percentyle, mediana 
select
percentile_cont(0.5) WITHIN group (order by salary)as mediana_mean_salary, 
percentile_cont(0.5) within group (order by salary_h_ceo) as mediana_mean_exectuvie,
percentile_cont(0.5) within group (order by salary_h_manager)as mediana_middle_m_salary
from net_salary_per_town_categories nsptc -- mediana per HOUR CEO, general salary, middle mamnager
 
SELECT region, abs((median_women_ceo)-(median_men_ceo)) AS diff_median,richest_women_ceo AS richest_women_ceo, 
richest_men_ceo AS richest_men_ceo  FROM 
(SELECT region,
percentile_cont(0.5) within group (order by nsptc.salary_h_women_ceo::NUMERIC) as median_women_ceo,
percentile_cont(0.5) within group (order by nsptc.salary_h_men_ceo::NUMERIC) as median_men_ceo,
percentile_cont(0.9) within group (order by nsptc.salary_h_women_ceo::NUMERIC) as richest_women_ceo,
percentile_cont(0.9) within group (order by nsptc.salary_h_men_ceo::NUMERIC) as richest_men_ceo,
percentile_cont(0.1) within group (order by nsptc.salary_h_women_ceo::NUMERIC) as poorest_women_ceo,
percentile_cont(0.1) within group (order by nsptc.salary_h_men_ceo::NUMERIC) as poorest_men_ceo
FROM net_salary_per_town_categories nsptc
JOIN name_geographic_information ngis ON nsptc.town_code = ngis.town_code
GROUP BY ngis.region) AS q 


select nsptc.salary_h_women_ceo, region, avg(salary_h_women_ceo) over (partition by region) as avg
from
"France".net_salary_per_town_categories nsptc
join "France".name_geographic_information ngis
on nsptc.town_code = ngis.town_code
order by (ngis.region, nsptc.salary_h_women_ceo)

SELECT  q.region, avg_women_salary, avg_men_salary   FROM
(SELECT
region,
avg(salary_h_women_ceo) OVER (PARTITION BY region) AS avg_women_salary,
avg(salary_h_men_ceo) OVER (PARTITION BY region) AS avg_men_salary
FROM net_salary_per_town_categories nsptc
INNER JOIN name_geographic_information ngis
ON nsptc.town_code = ngis.town_code
ORDER BY (ngis.region)) AS q
GROUP BY 1,2,3;
-- zależność płaca od płci 

SELECT * FROM name_geographic_information ngi 

SELECT DISTINCT town_name, count(town_name) FROM name_geographic_information ngi 
GROUP BY town_name 

SELECT DISTINCT  q.town_name , region,  avg_women_salary, avg_men_salary FROM
(SELECT
ngi.town_name, region,
	avg(salary_h_women_ceo) OVER (PARTITION BY ngi.town_name) AS avg_women_salary,
	avg(salary_h_men_ceo) OVER (PARTITION BY ngi.town_name) AS avg_men_salary
FROM net_salary_per_town_categories nsptc 
INNER JOIN name_geographic_information ngi 
ON nsptc.town_code = ngi.town_code
) AS q
ORDER BY avg_men_salary DESC ; -- pogrupowanie

SELECT DISTINCT(ngi.town_name),
				avg(salary_h_women_ceo) OVER (PARTITION BY ngi.town_name) AS avg_women_salary,
				avg(salary_h_men_ceo) OVER (PARTITION BY ngi.town_name) AS avg_men_salary
FROM net_salary_per_town_categories nsptc
INNER JOIN name_geographic_information ngi
ON nsptc.town_code = ngi.town_code
ORDER BY avg_women_salary DESC; -- TO samo ale łatwiej


SELECT DISTINCT town_name, * FROM name_geographic_information ngi 


select firms_all, avg_salary from 
(select firms_all , avg(salary) over (partition by firms_all) as avg_salary
from net_salary_per_town_categories nsptc  
left join base_etablissement_par_tranche_effectif bepte on nsptc.town_code  = bepte.town_code 
order by 1,2  ) AS  q
GROUP BY 1,2; -- dependece salary ON how big the firm IS // how TO calculate correlation? 

SELECT * FROM population p 	
SELECT sum(p.ppl_num_cat)  FROM population p  WHERE p.town_name='Paris'



SELECT town_name, sum_pop from 
(SELECT  town_name, sum(ppl_num_cat) over (partition by town_name) as sum_pop
from population p  
order by town_name DESC  ) AS  q
GROUP BY 1,2;


--sum_salary man 18-25
WITH sum_salary_man_18_25 AS (SELECT SUM(salary_h_18_25) FROM net_salary_per_town_categories nsptc)
SELECT * FROM sum_salary_man_18_25


--sum_salary man 26-50
WITH sum_salary_man_26_50 AS (SELECT SUM(salary_h_26_50) FROM net_salary_per_town_categories nsptc);
--sum_salary man > 50
WITH sum_salary_man_>50 AS (SELECT SUM(salary_h_50) FROM net_salary_per_town_categories nsptc);


SELECT region,
(median_men_ceo - median_women_ceo) AS diff_median_w_CEO,
median_women_ceo, median_men_ceo,
richest_women_ceo, richest_men_ceo,
poorest_women_ceo, poorest_men_ceo
FROM (SELECT region,
percentile_cont(0.5) within group (order by nsptc.salary_h_women_ceo::NUMERIC) as median_women_ceo,
percentile_cont(0.5) within group (order by nsptc.salary_h_men_ceo::NUMERIC) as median_men_ceo,
percentile_cont(0.9) within group (order by nsptc.salary_h_women_ceo::NUMERIC) as richest_women_ceo,
percentile_cont(0.9) within group (order by nsptc.salary_h_men_ceo::NUMERIC) as richest_men_ceo,
percentile_cont(0.1) within group (order by nsptc.salary_h_women_ceo::NUMERIC) as poorest_women_ceo,
percentile_cont(0.1) within group (order by nsptc.salary_h_men_ceo::NUMERIC) as poorest_men_ceo
FROM
"France".net_salary_per_town_categories nsptc
JOIN "France".name_geographic_information ngis
ON nsptc.town_code = ngis.town_code) AS q
GROUP BY ngis.region,
diff_median_w_CEO,
median_women_ceo, median_men_ceo,
richest_women_ceo, richest_men_ceo,
poorest_women_ceo, poorest_men_ceo
ORDER BY ngis.region


-- COPY salary_per_town_categories TO 'C:\tmp\persons_db.csv' DELIMITER ',' CSV HEADER;

-- (median_women_ceo)-(median_men_ceo) AS diff_median