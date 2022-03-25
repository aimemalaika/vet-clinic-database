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



