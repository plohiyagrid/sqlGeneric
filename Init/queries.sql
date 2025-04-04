-- 1. Country with the biggest population (id and name of the country)
SELECT c.id, c.name, COUNT(ci.person_id) AS population
FROM country c
JOIN citizenship ci ON c.id = ci.country_id
GROUP BY c.id, c.name
ORDER BY population DESC
LIMIT 1;

-- 2. Top 10 countries with the lowest population density (names of the countries)
SELECT c.name, COUNT(ci.person_id) / c.area_sqkm AS population_density
FROM country c
JOIN citizenship ci ON c.id = ci.country_id
GROUP BY c.name, c.area_sqkm
ORDER BY population_density ASC
LIMIT 10;

-- 3. Countries with population density higher than average across all countries
WITH country_population_density AS (
    SELECT c.name, COUNT(ci.person_id) / c.area_sqkm AS population_density
    FROM country c
    JOIN citizenship ci ON c.id = ci.country_id
    GROUP BY c.name, c.area_sqkm
)
SELECT cpd.name, cpd.population_density
FROM country_population_density cpd
WHERE cpd.population_density > (
    SELECT AVG(population_density)
    FROM country_population_density
);

-- 4. Country with the longest name (if several countries have name of the same length, show all of them)
SELECT c.name
FROM country c
ORDER BY LENGTH(c.name) DESC
LIMIT 1;

-- 5. All countries with name containing letter "F", sorted in alphabetical order
SELECT c.name
FROM country c
WHERE c.name LIKE '%F%'
ORDER BY c.name;

-- 6. Country with a population closest to the average population of all countries
WITH avg_population AS (
    SELECT AVG(population) AS avg_population
    FROM (
        SELECT COUNT(ci.person_id) AS population
        FROM citizenship ci
        GROUP BY ci.country_id
    ) subquery
)
SELECT c.name, COUNT(ci.person_id) AS population
FROM country c
JOIN citizenship ci ON c.id = ci.country_id
GROUP BY c.id, c.name
ORDER BY ABS(COUNT(ci.person_id) - (SELECT avg_population FROM avg_population))
LIMIT 1;

-- 7. Count of countries for each continent
SELECT co.name AS continent_name, COUNT(c.id) AS country_count
FROM continent co
JOIN country c ON c.continent_id = co.id
GROUP BY co.name;

-- 8. Total area for each continent (print continent name and total area), sorted by area from biggest to smallest
SELECT co.name AS continent_name, SUM(c.area_sqkm) AS total_area
FROM continent co
JOIN country c ON c.continent_id = co.id
GROUP BY co.name
ORDER BY total_area DESC;

-- 9. Average population density per continent
-- Calculate average population density per continent
WITH country_population_density AS (
    SELECT c.continent_id,
           COUNT(ci.person_id) / c.area_sqkm AS population_density
    FROM country c
    LEFT JOIN citizenship ci ON c.id = ci.country_id
    GROUP BY c.id, c.continent_id, c.area_sqkm
)
SELECT co.name AS continent_name,
       AVG(cp.population_density) AS avg_population_density
FROM continent co
JOIN country_population_density cp ON cp.continent_id = co.id
GROUP BY co.name;


-- 10. For each continent, find a country with the smallest area (continent name, country name, and area)
SELECT co.name AS continent_name, 
       c.name AS country_name, 
       c.area_sqkm
FROM continent co
JOIN country c ON c.continent_id = co.id
WHERE c.area_sqkm = (
    SELECT MIN(area_sqkm)
    FROM country
    WHERE continent_id = co.id
);

-- 11. Find all continents which have an average country population less than 20 million
-- Find all continents with average country population less than 20 million
WITH country_population AS (
    SELECT c.continent_id, COUNT(ci.person_id) AS population
    FROM country c
    LEFT JOIN citizenship ci ON c.id = ci.country_id
    GROUP BY c.id
)
SELECT co.name AS continent_name
FROM continent co
JOIN country_population cp ON cp.continent_id = co.id
GROUP BY co.name
HAVING AVG(cp.population) < 20000000;


-- 12. Person with the biggest number of citizenships
SELECT p.name, COUNT(ci.country_id) AS citizenship_count
FROM person p
JOIN citizenship ci ON p.id = ci.person_id
GROUP BY p.name
ORDER BY citizenship_count DESC
LIMIT 1;

-- 13. All people who have no citizenship
SELECT p.name
FROM person p
LEFT JOIN citizenship ci ON p.id = ci.person_id
WHERE ci.person_id IS NULL;

-- 14. Country with the least people in the People table
SELECT c.name, COUNT(ci.person_id) AS people_count
FROM country c
LEFT JOIN citizenship ci ON c.id = ci.country_id
GROUP BY c.name
ORDER BY people_count ASC
LIMIT 1;

-- 15. Continent with the most people in the People table
SELECT co.name AS continent_name, COUNT(ci.person_id) AS people_count
FROM continent co
JOIN country c ON c.continent_id = co.id
JOIN citizenship ci ON c.id = ci.country_id
GROUP BY co.name
ORDER BY people_count DESC
LIMIT 1;

-- 16. Find pairs of people with the same name (print 2 ids and the name)
SELECT p1.id AS person_1_id, p2.id AS person_2_id, p1.name
FROM person p1
JOIN person p2
    ON p1.name = p2.name
    AND p1.id < p2.id;

SELECT * FROM person;
