-- In the cps_dropout_rate_2011_2019 table, count how many records appear for each school_year
SELECT school_year, COUNT(school_id)
FROM cps_dropout_rate_2011_2019 
GROUP BY school_year
ORDER BY school_year; 
 

-- Identify the schools and their community area whose dropout rate in school year 2019 is greater than or equal to 25 percent.
SELECT  short_name, community, dropout_rate
FROM cps_sy1819_cca 
JOIN cps_dropout_rate_2011_2019 
USING (school_id)
WHERE dropout_rate >= 25
ORDER BY dropout_rate DESC
LIMIT 5;

-- Identify the top 10 community areas that have the highest number of crimes in 2019.
-- SELECT community, area_numbe FROM community_areas LIMIT 10;

-- SELECT community
-- FROM community_areas
-- JOIN crimes_2019
-- ON 'Community Area' = 'area_numbe';


-- Count the number of 2017 jobs in each community area.

SELECT  SUM(c000), a.community
FROM il_jobs_2017 job
JOIN il_geo_xwalk x
ON w_geocode=tabblk2010
JOIN census_tracts_2010 c
ON x.trct = CAST(c.geoid10 AS varchar) 
JOIN community_areas a 
ON a.area_num_1= c.commarea
GROUP BY a.community
ORDER BY a.community
LIMIT 20;

-- Identify the schools that are located in community areas that have the highest number of jobs in 2017.
SELECT  SUM(c000), a.community, s.short_name
FROM il_jobs_2017 job
JOIN il_geo_xwalk x
ON w_geocode=tabblk2010
JOIN census_tracts_2010 c
ON x.trct = CAST(c.geoid10 AS varchar) 
JOIN community_areas a 
ON a.area_num_1= c.commarea
JOIN cps_sy1819_cca s 
ON a.community = s.community
GROUP BY a.community, s.short_name
ORDER BY SUM(c000) DESC
LIMIT 20;

