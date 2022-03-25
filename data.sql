/* Populate database with sample data. */

/* Populate database with animals data in animals table. */
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES 
('Agumon', 'Feb 3 2020', 0, TRUE, 10.23),
('Gabumon', 'Nov 15 2018', 2, TRUE, 8),
('Pikachu', 'Jan 7 2021', 1, FALSE, 15.04),
('Devimon', 'May 12 2017', 5, TRUE, 11);


INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES 
('Charmander', 'Feb 8 2020', 0, FALSE, -11),
('Plantmon', 'Nov 15 2021', 2, TRUE, -5.7),
('Squirtle', 'Apr 2 1993', 3, FALSE, -12.13),
('Angemon', 'Jun 12 2005', 1, TRUE, -45)
('Boarmon', 'Jun 7 2005', 7, TRUE, 20.4)
('Blossom', 'Oct 13 1998', 3, TRUE, 17)
('Ditto', 'May 14 2022', 4, TRUE, 22);

INSERT INTO owners(full_name, age)VALUES 
('Sam Smith', 34),
('Jennifer Orwell', 19),
('Bob', 45),
('Melody Pond', 77),
('Dean Winchester', 14),
('Jodie Whittaker', 38);

INSERT INTO species(name) VALUES 
('Pokemon'),
('Digimon');

-- Modify your inserted animals so it includes the species_id value: 
UPDATE animals SET species_id=2 where name LIKE '%mon';
UPDATE animals SET species_id=1 where name NOT LIKE '%mon';

-- Modify your inserted animals to include owner information (owner_id): 
UPDATE animals SET owners_id=1 WHERE name='Agumon';
UPDATE animals SET owners_id=2 where name IN ('Gabumon', 'Pikachu');
UPDATE animals SET owners_id=3 where name IN ('Devimon', 'Plantmon');
UPDATE animals SET owners_id=4 where name IN ('Charmander', 'Squirtle', 'Blossom');
UPDATE animals SET owners_id=5 where name IN ('Angemon', 'Boarmon');

-- Update owners names with typo in Local DB
UPDATE owners SET full_name='Dean Winchester' WHERE full_name like 'Dean Wincheste';
UPDATE owners SET full_name='Jodie Whittaker' WHERE full_name like 'Jodie Whittake'; 

INSERT INTO vets(name, age, date_of_graduation)
VALUES 
    ('William Tatcher', 45, '2000-04-23'),
    ('Maisy Smith', 26, '2019-01-17'),
    ('Stephanie Mendez', 64, '1981-05-04'),
    ('Jack Harkness', 38, '2008-06-08');

INSERT INTO specializations(vet_id, species_id)
VALUES 
    (1, 1),
    (3, 2),
    (3, 1),
    (4, 2);

INSERT INTO visits(vet_id, animals_id, date_visited) VALUES 
(1, 8, '2020-05-24'),
(3, 8, '2020-07-22'),
(4, 9, '2021-02-02'),
(2, 10, '2020-01-05'),
(2, 10, '2020-03-08'),
(2, 10, '2020-05-14'),
(3, 11, '2021-05-04'),
(4, 1, '2021-02-24'),
(2, 2, '2019-12-21'),
(1, 2, '2020-08-10'),
(2, 2, '2021-04-07'),
(3, 3, '2019-09-29'),
(4, 4, '2020-10-03'),
(4, 4, '2020-11-04'),
(2, 5, '2019-01-24'),
(2, 5, '2019-05-15'),
(2, 5, '2020-02-27'),
(2, 5, '2020-08-03'),
(3, 6, '2020-05-24'),
(1, 6, '2021-01-11');