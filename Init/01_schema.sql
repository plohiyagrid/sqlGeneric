CREATE TABLE continents (
    continent_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE countries (
    country_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    continent_id INT,
    population BIGINT,
    area BIGINT,
    FOREIGN KEY (continent_id) REFERENCES continents(continent_id) ON DELETE CASCADE
);

CREATE TABLE people (
    person_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    age INT
);

CREATE TABLE country_people (
    country_id INT,
    person_id INT,
    PRIMARY KEY (country_id, person_id),
    FOREIGN KEY (country_id) REFERENCES countries(country_id),
    FOREIGN KEY (person_id) REFERENCES people(person_id)
);
