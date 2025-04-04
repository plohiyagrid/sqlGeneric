-- Drop tables if they exist to ensure clean creation
DROP TABLE IF EXISTS citizenship;
DROP TABLE IF EXISTS person;
DROP TABLE IF EXISTS country;
DROP TABLE IF EXISTS continent;

-- Create table for continents
CREATE TABLE continent (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

-- Create table for countries
CREATE TABLE country (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    continent_id INTEGER NOT NULL REFERENCES continent(id),
    area_sqkm NUMERIC(15, 2) NOT NULL CHECK (area_sqkm > 0)
);

-- Create table for people
CREATE TABLE person (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    birthdate DATE
);

-- Create table for citizenship (many-to-many relationship between countries and people)
CREATE TABLE citizenship (
    person_id INTEGER NOT NULL REFERENCES person(id),
    country_id INTEGER NOT NULL REFERENCES country(id),
    PRIMARY KEY (person_id, country_id)
);

