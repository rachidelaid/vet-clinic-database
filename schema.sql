/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id SERIAL PRIMARY KEY NOT NULL, 
    name VARCHAR(100) NOT NULL, 
    date_of_birth DATE NOT NULL, 
    escape_attempts INT NOT NULL,
    neutered BOOLEAN NOT NULL,
    weight_kg DECIMAL NOT NULL
);

/* Add a column species of type string to the animals table */
ALTER TABLE animals 
    ADD species VARCHAR(255);
