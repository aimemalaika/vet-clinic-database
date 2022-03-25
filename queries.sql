/*Queries that provide answers to the questions from all projects.*/

-- Find all animals whose name ends in "mon".
SELECT * from animals WHERE name LIKE '%mon';

-- List the name of all animals born between 2016 and 2019.
SELECT * from animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31' AND date_of_birth NOT IN ('2016-01-01', '2019-12-31');

-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT name FROM animals WHERE neutered = TRUE AND escape_attempts < 3;

-- List date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');

-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

-- Find all animals not named Gabumon.
SELECT * FROM animals WHERE name <> 'Gabumon';

-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

-- Inside a transaction update the animals table by setting the species column to unspecified.
-- Verify that change was made. Then roll back the change and verify that species columns went back to the state before transaction.
BEGIN;

UPDATE animals
SET species = 'unspecified';

SELECT * FROM animals;

ROLLBACK;

SELECT * FROM animals;

-- Inside a transaction: 
-- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
-- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
-- Commit the transaction.
-- Verify that change was made and persists after commit.
BEGIN;

UPDATE animals 
SET species='digimon' 
WHERE name LIKE '%mon';

UPDATE animals 
SET species='pokemon' 
WHERE species='';

COMMIT;

SELECT * FROM animals;


-- Inside a transaction: 
-- Delete all animals born after Jan 1st, 2022.
-- Create a savepoint for the transaction.
-- Update all animals' weight to be their weight multiplied by -1.
-- Rollback to the savepoint
-- Update all animals' weights that are negative to be their weight multiplied by -1.
-- Commit transaction
BEGIN;

DELETE FROM animals WHERE date_of_birth > '2022-01-01';

SAVEPOINT AFTER_DELETING_ANIMALS_WITH_BOD_LATER_THAN_2022_01_01;

UPDATE animals SET weight_kg = weight_kg * -1;

ROLLBACK TO AFTER_DELETING_ANIMALS_WITH_BOD_LATER_THAN_2022_01_01;

UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;

COMMIT;

-- Write queries to answer the following questions: 

-- How many animals are there?
SELECT COUNT(*) FROM animals WHERE species='Animal'; 

-- How many animals have never tried to escape?
SELECT COUNT(*) FROM animals WHERE escape_attempts=0; 

-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, MAX(escape_attempts) FROM animals
GROUP BY neutered;

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg) AS min_weight_in_species, MAX(weight_kg) AS max_weight_in_species
FROM animals
GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) AS average_escape_attempt_per_species
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;


-- Write queries (using JOIN) to answer the following questions: 
-- What animals belong to Melody Pond?
SELECT o.full_name, a.name FROM owners o 
JOIN animals a
ON a.owners_id = o.id AND o.full_name like 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT a.name, a.date_of_birth, a.escape_attempts, a.neutered, s.name AS species FROM animals a
JOIN species s 
ON a.species_id = s.id
WHERE s.name like 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT o.full_name, a.name FROM owners o 
LEFT JOIN animals a
ON a.owners_id = o.id;

-- How many animals are there per species?
SELECT s.name as species, COUNT(*) FROM animals a
JOIN species s 
ON a.species_id = s.id
GROUP BY s.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT o.full_name, a.name, s.name AS species FROM owners o 
JOIN animals a
ON a.owners_id = o.id
JOIN species s
ON a.species_id = s.id
WHERE s.name LIKE 'Digimon' AND o.full_name like 'Jennifer Orwell';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT o.full_name, a.name, a.escape_attempts FROM owners o
JOIN animals a
ON a.owners_id = o.id
WHERE o.full_name like 'Dean Winchester' AND a.escape_attempts <= 0;

-- Who owns the most animals?
SELECT o.full_name AS owner_full_name, COUNT(*) AS animals_owned FROM owners o 
JOIN animals a
ON a.owners_id = o.id
GROUP BY owner_full_name
ORDER BY animals_owned DESC
LIMIT (1); 

-- Write queries to answer the following:
-- Who was the last animal seen by William Tatcher?
SELECT a.name, v.name, date_visited FROM visits vis 
JOIN vets v 
  ON vis.vet_id = v.id 
JOIN animals a 
  ON vis.animals_id = a.id 
WHERE v.name LIKE 'William Tatcher'
ORDER BY vis.date_visited DESC
LIMIT (1);

-- How many different animals did Stephanie Mendez see?
SELECT DISTINCT COUNT(*) FROM visits vis 
JOIN vets v 
  ON vis.vet_id = v.id 
JOIN animals a 
  ON vis.animals_id = a.id 
WHERE v.name LIKE 'Stephanie Mendez'
GROUP BY v.name;

-- List all vets and their specialties, including vets with no specialties.
SELECT v.name, sp.name FROM vets v 
LEFT JOIN specializations s 
  ON v.id = s.vet_id
LEFT JOIN species sp 
  ON sp.id = s.species_id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT a.name, vis.date_visited, v.name FROM animals a 
JOIN visits vis 
  ON a.id = vis.animals_id
JOIN vets v 
  ON v.id = vis.vet_id
WHERE vis.date_visited IN ('2020-04-01', '2020-08-30') 
    AND v.name LIKE 'Stephanie Mendez';

-- What animal has the most visits to vets?
SELECT a.name, COUNT(*) AS number_of_visits FROM visits vis 
JOIN animals a 
  ON vis.animals_id = a.id 
GROUP BY a.name
ORDER BY number_of_visits DESC
LIMIT (1);

-- Who was Maisy Smith's first visit?
SELECT a.name, v.name, vis.date_visited FROM visits vis 
JOIN vets v 
  ON vis.vet_id = v.id 
JOIN animals a 
  ON vis.animals_id = a.id 
WHERE v.name LIKE 'Maisy Smith'
ORDER BY vis.date_visited
LIMIT (1);

-- Details for most recent visit: 
-- animal information, vet information, and date of visit.
SELECT a.name, v.name, vis.date_visited FROM visits vis 
JOIN vets v 
  ON vis.vet_id = v.id 
JOIN animals a 
  ON vis.animals_id = a.id 
ORDER BY vis.date_visited DESC
LIMIT (1);

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*) AS number_of_visits_with_not_specialty_vet FROM visits vis 
JOIN vets v 
  ON vis.vet_id = v.id 
JOIN animals a 
  ON vis.animals_id = a.id
LEFT JOIN specializations sp
  ON v.id = sp.vet_id
LEFT JOIN species spe 
  ON spe.id = sp.species_id
WHERE sp.species_id != a.species_id OR spe.name IS NULL;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT spe.name, COUNT(*) AS most_visited_by_species FROM visits vis 
JOIN animals a 
  ON vis.animals_id = a.id
JOIN species spe 
  ON spe.id = a.species_id
JOIN vets v 
  ON vis.vet_id = v.id 
LEFT JOIN specializations sp
  ON v.id = sp.vet_id
WHERE sp.vet_id IS NULL AND v.name LIKE 'Maisy Smith'
GROUP BY spe.name
ORDER BY most_visited_by_species DESC
LIMIT (1); 
