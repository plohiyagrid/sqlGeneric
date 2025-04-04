-- Insert dummy data into continents
INSERT INTO continent (name)
VALUES
    ('Africa'),
    ('Asia'),
    ('Europe'),
    ('South America');

-- Insert dummy data into countries
INSERT INTO country (name, continent_id, area_sqkm)
VALUES
    ('Nigeria', 1, 923768.00),
    ('South Africa', 1, 1219090.00),
    ('India', 2, 3287263.00),
    ('China', 2, 9596961.00),
    ('Germany', 3, 357022.00),
    ('France', 3, 643801.00),
    ('Argentina', 4, 2780400.00),
    ('Brazil', 4, 8515767.00);

-- Insert dummy data into people
INSERT INTO person (name, birthdate)
VALUES
    ('John Doe', '1990-01-15'),
    ('Jane Smith', '1985-03-22'),
    ('James Brown', '1992-07-10'),
    ('Emily White', '1995-05-30'),
    ('Michael Johnson', '1988-11-01'),
    ('Sarah Williams', '1993-06-17'),
    ('David Jones', '1987-09-05'),
    ('Emma Davis', '1994-12-19'),
    ('Daniel Garcia', '1986-02-28'),
    ('Sophia Martinez', '1990-08-07'),
    ('Olivia Robinson', '1991-04-03'),
    ('Lucas Clark', '1989-10-11'),
    ('Ethan Lewis', '1993-01-25'),
    ('Mason Walker', '1984-12-01'),
    ('Amelia Hall', '1992-03-13'),
    ('Isabella Young', '1996-06-22'),
    ('Mia Scott', '1994-09-07'),
    ('Elijah King', '1990-02-02'),
    ('Avery Turner', '1988-05-19'),
    ('Jack Harris', '1992-08-15'),
    ('John Doe', '1990-01-17');

-- Insert dummy data into citizenships (people and countries relationships)
INSERT INTO citizenship (person_id, country_id)
VALUES
    (1, 1), (1, 2),
    (2, 1), (2, 3),
    (3, 2), (3, 4),
    (4, 3), (4, 4),
    (5, 5), (5, 6),
    (6, 6), (6, 7),
    (7, 8), (7, 1),
    (8, 3), (8, 4),
    (9, 5), (9, 6),
    (10, 7), (10, 8),
    (11, 1), (11, 2),
    (12, 5), (12, 6),
    (13, 2), (13, 7),
    (14, 8), (14, 1),
    (15, 3), (15, 4),
    (16, 2), (16, 8),
    (17, 7), (17, 6),
    (18, 5), (18, 3),
    (19, 4), (19, 1),
    (20, 6), (20, 8);
