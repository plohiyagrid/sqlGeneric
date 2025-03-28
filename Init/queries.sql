-- SQL Queries to find the required data about countries

-- 1. Country with the biggest population (id and name of the country)
-- Find the country with the largest population
SELECT country_id, name
FROM countries
ORDER BY population DESC
LIMIT 1;

-- 2. Top 10 countries with the lowest population density (names of the countries)
-- Population density = population / area. This will return top 10 countries with the lowest population density.
SELECT name
FROM countries
ORDER BY population / area ASC
LIMIT 10;

-- 3. Countries with population density higher than average across all countries
-- This will return all countries that have a population density greater than the average.
SELECT name , (population / area) as population_density
FROM countries
WHERE population / area > (SELECT AVG(population / area) FROM countries);

-- 4. Country with the longest name (if several countries have name of the same length, show all of them)
-- This will return countries with the longest name length.
SELECT country_id, name
FROM countries
WHERE LENGTH(name) = (SELECT MAX(LENGTH(name)) FROM countries);

-- 5. All countries with name containing letter “F”, sorted in alphabetical order
-- This will return all countries whose name contains the letter "F", sorted alphabetically.
SELECT name
FROM countries
WHERE name ILIKE '%f%'
ORDER BY name;

-- 6. Country which has a population closest to the average population of all countries
-- This will return the country whose population is closest to the average population.
SELECT country_id, name
FROM countries
ORDER BY ABS(population - (SELECT AVG(population) FROM countries))
LIMIT 1;

-- SQL Queries to find the required data about countries and continents

-- 1. Count of countries for each continent
-- This will return the number of countries per continent.
SELECT continents.name AS continent_name, COUNT(countries.country_id) AS country_count
FROM continents
JOIN countries ON continents.continent_id = countries.continent_id
GROUP BY continents.name;

-- 2. Total area for each continent (print continent name and total area), sorted by area from biggest to smallest
-- This will return the total area for each continent, sorted by area.
SELECT continents.name AS continent_name, SUM(countries.area) AS total_area
FROM continents
JOIN countries ON continents.continent_id = countries.continent_id
GROUP BY continents.name
ORDER BY total_area DESC;

-- 3. Average population density per continent
-- This will return the average population density for each continent.
SELECT continents.name AS continent_name, AVG(countries.population / countries.area) AS avg_population_density
FROM continents
JOIN countries ON continents.continent_id = countries.continent_id
GROUP BY continents.name;

-- 4. For each continent, find a country with the smallest area (print continent name, country name and area)
-- This will return the country with the smallest area in each continent.
SELECT continents.name AS continent_name, countries.name AS country_name, countries.area
FROM continents
JOIN countries ON continents.continent_id = countries.continent_id
WHERE countries.area = (SELECT MIN(area) FROM countries WHERE continent_id = continents.continent_id);

-- 5. Find all continents, which have average country population less than 20 million
-- This will return continents where the average population of the countries is less than 20 million.
SELECT continents.name AS continent_name
FROM continents
JOIN countries ON continents.continent_id = countries.continent_id
GROUP BY continents.name
HAVING AVG(countries.population) < 20000000;

-- SQL Queries to find the required data about people

-- 1. Person with the biggest number of citizenships
-- This will return the person who holds the maximum number of citizenships (countries).
SELECT person_id, name
FROM people
WHERE person_id = (
    SELECT person_id
    FROM country_people
    GROUP BY person_id
    ORDER BY COUNT(country_id) DESC
    LIMIT 1
);

-- 2. All people who have no citizenship
-- This will return all people who are not associated with any country.
SELECT name
FROM people
WHERE person_id NOT IN (SELECT person_id FROM country_people);

-- 3. Country with the least people in People table
-- This will return the country with the least number of people in the `people` table.
SELECT countries.name
FROM countries
JOIN country_people ON countries.country_id = country_people.country_id
GROUP BY countries.name
ORDER BY COUNT(country_people.person_id) ASC
LIMIT 1;

-- 4. Continent with the most people in People table
-- This will return the continent with the most people based on the countries' population in the `people` table.
SELECT continents.name AS continent_name
FROM continents
JOIN countries ON continents.continent_id = countries.continent_id
JOIN country_people ON countries.country_id = country_people.country_id
GROUP BY continents.name
ORDER BY COUNT(country_people.person_id) DESC
LIMIT 1;

-- 5. Find pairs of people with the same name - print 2 ids and the name
-- This will return pairs of people who have the same name.
SELECT p1.person_id AS person_id_1, p2.person_id AS person_id_2, p1.name
FROM people p1
JOIN people p2 ON p1.name = p2.name AND p1.person_id < p2.person_id;

-- Additional Queries for Robust Update Handling

-- 1. Robust update query (fail if any id not found)
-- This query will fail the update if any of the provided ids are not found.
UPDATE countries
SET population = 50000000
WHERE country_id = 99999
AND EXISTS (SELECT 1 FROM countries WHERE country_id = 99999);
-- The update will fail if the country_id 99999 does not exist.

-- CRUD operations: A full set of queries for your entities (Countries, People, Country_People)

-- 2. Create a new country
INSERT INTO countries (name, continent_id, population, area)
VALUES ('NewCountry', 1, 5000000, 150000);


-- Pagination query example with dynamic filters and sorting
-- This example filters countries by population, sorts them by name, and applies pagination with a page size of 10.
SELECT *
FROM countries
WHERE population > 1000000
ORDER BY name
LIMIT 10 OFFSET 0;

-- Join query example for dynamic filtering: Fetch people along with the country they belong to
SELECT people.name, countries.name AS country_name
FROM people
JOIN country_people ON people.person_id = country_people.person_id
JOIN countries ON country_people.country_id = countries.country_id
WHERE countries.name = 'SomeCountry';

SELECT * FROM continents;
SELECT * FROM countries;
SELECT * FROM people;
SELECT * FROM country_people;

--Name and country
SELECT p.name AS Name, c.name AS Country
FROM people p
INNER JOIN country_people cp ON p.person_id = cp.person_id
INNER JOIN countries c ON c.country_id = cp.country_id;

--Countries and their people
SELECT c.name AS Country, STRING_AGG(p.name, ', ') AS People
FROM countries c
INNER JOIN country_people cp ON c.country_id = cp.country_id
INNER JOIN people p ON p.person_id = cp.person_id
GROUP BY c.name
ORDER BY c.name;

-- no. of citizenship
SELECT p.name AS Person, COUNT(DISTINCT cp.country_id) AS Number_of_Citizenships
FROM people p
LEFT JOIN country_people cp ON p.person_id = cp.person_id
GROUP BY p.person_id
ORDER BY p.name;


--Remove Nigerian citizenship for John Doe and make him australian
-- Start a transaction
BEGIN;

-- 1. Remove Nigerian citizenship for John Doe
DELETE FROM country_people
WHERE person_id = (SELECT person_id FROM people WHERE name = 'John Doe')
  AND country_id = (SELECT country_id FROM countries WHERE name = 'Nigeria');

-- 2. Add Australian citizenship for John Doe
INSERT INTO country_people (country_id, person_id)
VALUES (
  (SELECT country_id FROM countries WHERE name = 'South Africa'),
  (SELECT person_id FROM people WHERE name = 'John Doe')
);

-- If both operations succeed, commit the transaction
COMMIT;


--Name and country
SELECT p.name AS Name, c.name AS Country
FROM people p
INNER JOIN country_people cp ON p.person_id = cp.person_id
INNER JOIN countries c ON c.country_id = cp.country_id;