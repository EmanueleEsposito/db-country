-- 1) Selezionare tutte le nazioni il cui nome inizia con la P e la cui area è maggiore di 1000 kmq
SELECT *
FROM countries 
WHERE name LIKE 'P%' AND area > 1000;

-- 2) Selezionare le nazioni il cui national day è avvenuto più di 100 anni fa
SELECT *
FROM countries
WHERE TIMESTAMPDIFF(YEAR,national_day, CURDATE()) > 100;

-- 3) Selezionare il nome delle regioni del continente europeo, in ordine alfabetico
SELECT c.name 
FROM countries c 
INNER JOIN regions r 
ON c.region_id = r.region_id 
WHERE r.name LIKE '%Europe%'
ORDER BY name ;

-- 4)  Contare quante lingue sono parlate in Italia
SELECT COUNT(cl.language_id) AS numero_lingue_italia
FROM countries c 
INNER JOIN country_languages cl 
ON c.country_id = cl.country_id 
WHERE c.name = 'Italy';

-- 5)  Selezionare quali nazioni non hanno un national day
SELECT *
FROM countries 
WHERE national_day IS NULL;

-- 6)  Per ogni nazione selezionare il nome, la regione e il continente
SELECT c.name, r.name, c2.name 
FROM countries c 
INNER JOIN regions r 
ON c.region_id = r.region_id 
INNER JOIN continents c2 
ON r.continent_id = c2.continent_id ;

-- 7) Modificare la nazione Italy, inserendo come national day il 2  giugno 1946
UPDATE countries 
SET national_day = '1946-06-02'
WHERE country_id =107;

-- 8) Per ogni regione mostrare il valore dell'area totale 
SELECT  r.name, SUM(c.area) AS area_totale_regione
FROM countries c 
INNER JOIN regions r 
ON c.region_id =r.region_id 
GROUP BY r.name ;

-- 9) Selezionare le lingue ufficiali dell'Albania
SELECT l.`language` AS lingue_ufficiali_albania
FROM languages l 
INNER JOIN country_languages cl 
ON l.language_id = cl.language_id 
INNER JOIN countries c 
ON cl.country_id = c.country_id 
WHERE c.name = 'Albania';

-- 10)  Selezionare il Gross domestic product (GDP) medio dello United Kingdom tra il 2000 e il 2010
SELECT avg(cs.gdp) AS media_gdp_uk 
FROM countries c 
INNER JOIN country_stats cs 
ON c.country_id = cs.country_id 
WHERE c.name = 'United Kingdom' AND cs.`year` >= '2000-01-01' AND cs.`year` <= '2010-12-31';

-- 11). Selezionare tutte le nazioni in cui si parla hindi, ordinate dalla più estesa alla meno estesa 
SELECT c.name, c.area, l.`language` 
FROM languages l 
INNER JOIN country_languages cl 
ON l.language_id = cl.language_id 
INNER JOIN countries c 
ON cl.country_id = c.country_id 
WHERE `language` = 'hindi'
ORDER BY c.area DESC ;

-- 12) . Per ogni continente, selezionare il numero di nazioni con area superiore ai 10.000 kmq ordinando i risultati a partire dal
 -- continente che ne ha di più  
SELECT c.name,  count(c2.country_id) AS numero_nazioni_per_continente 
FROM continents c  
INNER JOIN regions r 
ON c.continent_id = r.continent_id 
INNER JOIN countries c2 
ON c2.region_id = r.region_id
WHERE c2.area > 10000
GROUP BY c.name 
ORDER BY numero_nazioni_per_continente DESC ;
