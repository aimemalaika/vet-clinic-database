CREATE DATABASE vet_clinic;

\c vet_clinic;
/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id SERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INT NOT NULL DEFAULT 0,
    neutered BOOL NOT NULL DEFAULT FALSE,
    weight_kg DECIMAL NOT NULL
);

-- Add a column species of type string to your animals table.
ALTER TABLE animals ADD species VARCHAR(50) DEFAULT NULL;



CREATE TABLE owners (
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    full_name varchar(100),
    age integer
);

CREATE TABLE species (
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name varchar(100)
);

-- Modify animals table: 
-- Make sure that id is set as autoincremented PRIMARY KEY
ALTER TABLE animals
ADD CONSTRAINT animals_pkey PRIMARY KEY (id);

-- Remove column species
ALTER TABLE animals
DROP COLUMN species;
-- Add column species_id which is a foreign key referencing species table
ALTER TABLE animals
ADD species_id integer;

ALTER TABLE animals 
ADD FOREIGN KEY (species_id) REFERENCES species (id);
-- Add column owner_id which is a foreign key referencing the owners table
ALTER TABLE animals
ADD owners_id integer;
ALTER TABLE animals 
ADD FOREIGN KEY (owners_id) REFERENCES owners (id);