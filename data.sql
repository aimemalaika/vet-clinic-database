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