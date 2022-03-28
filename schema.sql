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

--owners table
CREATE TABLE owners (
    id SERIAL PRIMARY KEY NOT NULL, 
    full_name VARCHAR(100) NOT NULL, 
    age INT NOT NULL
);

ALTER TABLE owners ADD COLUMN email VARCHAR(120);

--species table
CREATE TABLE species (
    id SERIAL PRIMARY KEY NOT NULL, 
    name VARCHAR(100) NOT NULL
);

-- Remove column species
ALTER TABLE animals DROP species;

--Add column species_id which is a foreign key referencing species table
ALTER TABLE animals
  ADD species_id INT,
  ADD CONSTRAINT fk_species
    FOREIGN KEY (species_id)
    REFERENCES species (id);

--Add column owner_id which is a foreign key referencing the owners table
ALTER TABLE animals
  ADD owner_id INT,
  ADD CONSTRAINT fk_owner
    FOREIGN KEY (owner_id)
    REFERENCES owners (id);

--vets table
CREATE TABLE vets (
    id SERIAL PRIMARY KEY NOT NULL, 
    name VARCHAR(100) NOT NULL, 
    date_of_graduation DATE NOT NULL
);

--Specialization table
CREATE TABLE specializations (
    species_id INT NOT NULL,
    vet_id INT NOT NULL,
    FOREIGN KEY (species_id) REFERENCES species (id),
    FOREIGN KEY (vet_id) REFERENCES vets (id) 
);

--Visit table
CREATE TABLE visits (
    animal_id INT NOT NULL,
    vet_id INT NOT NULL,
    date_of_visit DATE,
    FOREIGN KEY (animal_id) REFERENCES animals (id),
    FOREIGN KEY (vet_id) REFERENCES vets (id) 
);