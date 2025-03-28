
INSERT INTO continents (name) VALUES
('Africa'),
('Asia'),
('Europe'),
('North America'),
('South America'),
('Australia'),
('Antarctica');

INSERT INTO countries (name, continent_id, population, area) VALUES
('Nigeria', 1, 200000000, 923768),
('China', 2, 1400000000, 9596961),
('India', 2, 1300000000, 3287263),
('USA', 4, 331002651, 9833517),
('Canada', 4, 37742154, 9984670),
('Brazil', 5, 212559417, 8515767),
('Argentina', 5, 45195777, 2780400),
('Australia', 6, 25499884, 7692024),
('Germany', 3, 83783942, 357022),
('France', 3, 67890102, 643801),
('South Africa', 1, 59308690, 1219090),
('Egypt', 1, 91250000, 1002450);


INSERT INTO people (person_id, name, age) VALUES
(1, 'John Doe', 30),
(2, 'Jane Smith', 25),
(3, 'Robert Brown', 40),
(4, 'Emily White', 35),
(5, 'William Black', 50),
(6, 'Olivia Green', 28),
(7, 'David Harris', 45),
(8, 'Sarah Lewis', 32),
(9, 'Michael Clark', 60),
(10, 'Sophia King', 22);

INSERT INTO country_people (country_id, person_id) VALUES
(1, 1),
(1, 2),
(2, 3),
(2, 4),
(3, 5),
(3, 6),
(4, 7),
(4, 8),
(5, 9),
(5, 10),
(6, 1),
(6, 2),
(7, 3),
(7, 4);
