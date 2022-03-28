/* Populate database with sample data. */

INSERT INTO animals(
  id,
  name,
  date_of_birth,
  escape_attempts,
  neutered,
  weight_kg
) VALUES (
  1, 
  'Agumon',
  '2020-02-03',
  0,
  TRUE,
  10.23
);

INSERT INTO animals(
  id,
  name,
  date_of_birth,
  escape_attempts,
  neutered,
  weight_kg
) VALUES (
  2, 
  'Gabumon',
  '2018-11-15',
  2,
  TRUE,
  8
);

INSERT INTO animals(
  id,
  name,
  date_of_birth,
  escape_attempts,
  neutered,
  weight_kg
) VALUES(
  3,
  'Pikachu',
  '2021-01-7',
  1,
  FALSE,
  15.08
);

INSERT INTO animals(
  id,
  name,
  date_of_birth,
  escape_attempts,
  neutered,
  weight_kg
) VALUES(
  4,
  'Devimon',
  '2017-05-12',
  5,
  TRUE,
  11
);

/*Inserting new data to table*/

INSERT INTO animals(
  id,
  name,
  date_of_birth,
  escape_attempts,
  neutered,
  weight_kg
) VALUES (
  5, 
  'Charmander',
  '2020-02-08',
  0,
  FALSE,
  -11
);

INSERT INTO animals(
  id,
  name,
  date_of_birth,
  escape_attempts,
  neutered,
  weight_kg
) VALUES (
  6, 
  'Plantmon',
  '2022-11-15',
  2,
  TRUE,
  -5.7
);

INSERT INTO animals(
  id,
  name,
  date_of_birth,
  escape_attempts,
  neutered,
  weight_kg
) VALUES(
  7,
  'Squirtle',
  '1993-04-02',
  3,
  FALSE,
  -12.13
);

INSERT INTO animals(
  id,
  name,
  date_of_birth,
  escape_attempts,
  neutered,
  weight_kg
) VALUES(
  8,
  'Angemon',
  '2005-06-12',
  1,
  TRUE,
  -45
);

INSERT INTO animals(
  id,
  name,
  date_of_birth,
  escape_attempts,
  neutered,
  weight_kg
) VALUES(
  9,
  'Boarmon',
  '2005-06-07',
  7,
  TRUE,
  20.4
);

INSERT INTO animals(
  id,
  name,
  date_of_birth,
  escape_attempts,
  neutered,
  weight_kg
) VALUES(
  10,
  'Blossom',
  '1998-10-13',
  3,
  TRUE,
  17
);

INSERT INTO animals(
  id,
  name,
  date_of_birth,
  escape_attempts,
  neutered,
  weight_kg
) VALUES(
  11,
  'Ditto',
  '1998-05-14',
  4,
  TRUE,
  22
);

/* Setting the species to unspecified*/
BEGIN; -- start transaction

UPDATE animals SET species = 'unspecified';

--verify the changes were made
SELECT * FROM animals;

--rollback changes made to species
ROLLBACK;

--verify that thet changes were rolledback
SELECT * FROM animals;

/* Adding the correct species */
BEGIN;

UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';

UPDATE animals SET species = 'pokemon' WHERE species IS NULL;

COMMIT;

--Verify that change was made and persists after commit.
SELECT * FROM animals;

/* Deleting all animals */
BEGIN;

DELETE FROM animals;

-- Verify that the animnals table is empty
SELECT * FROM animals;

ROLLBACK;

--verify that thet changes were rolledback
SELECT * FROM animals;

-- savepoint
BEGIN;

DELETE FROM animals WHERE date_of_birth > 'Jan 1, 2022';

SAVEPOINT save_point;

UPDATE animals SET weight_kg = weight_kg * -1;

ROLLBACK TO save_point;

UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;

COMMIT;

-- Insert data into the owners table
INSERT INTO owners(
  full_name,
  age
) VALUES(
  'Sam Smith',
  34
);

INSERT INTO owners(
  full_name,
  age
) VALUES(
  'Jennifer Orwell',
  19
);

INSERT INTO owners(
  full_name,
  age
) VALUES(
  'Bob',
  45
);

INSERT INTO owners(
  full_name,
  age
) VALUES(
  'Melody Pond',
  77
);

INSERT INTO owners(
  full_name,
  age
) VALUES(
  'Dean Winchester',
  14
);

INSERT INTO owners(
  full_name,
  age
) VALUES(
  'Jodie Whittaker',
  38
);

-- Insert data into the species table
INSERT INTO species(name) VALUES ('Pokemon');
INSERT INTO species(name) VALUES ('Digimon');

-- Modify inserted animals so it includes the species_id value
UPDATE animals
  SET species_id = (SELECT id FROM species WHERE name = 'Digimon')
  WHERE name LIKE '%mon';

UPDATE animals
  SET species_id = (SELECT id FROM species WHERE name = 'Pokemon')
  WHERE species_id IS NULL;

-- Modify inserted animals to include owner information (owner_id)
UPDATE animals
  SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith')
  WHERE name = 'Agumon';

UPDATE animals
  SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
  WHERE name IN ('Gabumon', 'Pikachu');

UPDATE animals
  SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob')
  WHERE name IN ('Devimon', 'Plantmon');

UPDATE animals
  SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond')
  WHERE name IN ('Charmander', 'Squirtle', 'Blossom');

UPDATE animals
  SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
  WHERE name IN ('Angemon', 'Boarmon');

-- Inserting data into vets table
INSERT INTO
  vets
    (name, age, date_of_graduation)
  VALUES
    ('William Tatcher', 45, '2000-04-23'),
    ('Maisy Smith', 26, '2019-01-17'),
    ('Stephanie Mendez', 64, '1981-05-04'),
    ('Jack Harkness', 38, '2008-06-08');

-- Inserting data into Specializations table
INSERT INTO 
  specializations
    (species_id, vets_id)
  VALUES (
    (
      SELECT id 
      FROM species 
      WHERE name = 'Pokemon'
    ),
    (
      SELECT id 
      FROM vets 
      WHERE name = 'William Tatcher'
    )
  );

INSERT INTO 
  specializations
    (species_id, vets_id)
  VALUES 
    (
      (
        SELECT id 
        FROM species 
        WHERE name = 'Pokemon'
      ),
      (
        SELECT id 
        FROM vets 
        WHERE name = 'Stephanie Mendez'
      )
    ),
    (
      (
        SELECT id 
        FROM species 
        WHERE name = 'Digimon'
      ),
      (
        SELECT id 
        FROM vets 
        WHERE name = 'Stephanie Mendez'
      )
    );

INSERT INTO 
  specializations
    (species_id, vets_id)
  VALUES (
    (
      SELECT id 
      FROM species 
      WHERE name = 'Digimon'
    ),
    (
      SELECT id 
      FROM vets 
      WHERE name = 'Jack Harkness'
    )
  );

-- Insert data for visits
INSERT INTO
  visits
    (animal_id, vets_id,  date_of_visit)
  VALUES 
    (
      (
        SELECT id
        FROM animals
        WHERE name = 'Agumon'
      ),
      (
        SELECT id 
        FROM vets
        WHERE name = 'William Tatcher'
      ),
      '2020-05-24'
    ),
    (
      (
        SELECT id
        FROM animals
        WHERE name = 'Agumon'
      ),
      (
        SELECT id 
        FROM vets
        WHERE name = 'Stephanie Mendez'
      ),
      '2020-07-22'
    ),
    (
      (
        SELECT id
        FROM animals
        WHERE name = 'Gabumon'
      ),
      (
        SELECT id 
        FROM vets
        WHERE name = 'Jack Harkness'
      ),
      '2021-02-02'
    ),
    (
      (
        SELECT id
        FROM animals
        WHERE name = 'Pikachu'
      ),
      (
        SELECT id 
        FROM vets
        WHERE name = 'Maisy Smith'
      ),
      '2020-01-05'
    ),
    (
      (
        SELECT id
        FROM animals
        WHERE name = 'Pikachu'
      ),
      (
        SELECT id 
        FROM vets
        WHERE name = 'Maisy Smith'
      ),
      '2020-03-08'
    ),
    (
      (
        SELECT id
        FROM animals
        WHERE name = 'Pikachu'
      ),
      (
        SELECT id 
        FROM vets
        WHERE name = 'Maisy Smith'
      ),
      '2020-05-14'
    ),
    (
      (
        SELECT id
        FROM animals
        WHERE name = 'Devimon'
      ),
      (
        SELECT id 
        FROM vets
        WHERE name = 'Stephanie Mendez'
      ),
      '2021-05-04'
    ),
    (
      (
        SELECT id
        FROM animals
        WHERE name = 'Charmander'
      ),
      (
        SELECT id 
        FROM vets
        WHERE name = 'Jack Harkness'
      ),
      '2021-02-24'
    ),
    (
      (
        SELECT id
        FROM animals
        WHERE name = 'Plantmon'
      ),
      (
        SELECT id 
        FROM vets
        WHERE name = 'Maisy Smith'
      ),
      '2019-12-21'
    ),
    (
      (
        SELECT id
        FROM animals
        WHERE name = 'Plantmon'
      ),
      (
        SELECT id 
        FROM vets
        WHERE name = 'William Tatcher'
      ),
      '2020-08-10'
    ),
    (
      (
        SELECT id
        FROM animals
        WHERE name = 'Plantmon'
      ),
      (
        SELECT id 
        FROM vets
        WHERE name = 'Maisy Smith'
      ),
      '2021-04-07'
    ),
    (
      (
        SELECT id
        FROM animals
        WHERE name = 'Squirtle'
      ),
      (
        SELECT id 
        FROM vets
        WHERE name = 'Stephanie Mendez'
      ),
      '2019-09-29'
    ),
    (
      (
        SELECT id
        FROM animals
        WHERE name = 'Angemon'
      ),
      (
        SELECT id 
        FROM vets
        WHERE name = 'Jack Harkness'
      ),
      '2020-10-03'
    ),
    (
      (
        SELECT id
        FROM animals
        WHERE name = 'Angemon'
      ),
      (
        SELECT id 
        FROM vets
        WHERE name = 'Jack Harkness'
      ),
      '2020-11-04'
    ),
    (
      (
        SELECT id
        FROM animals
        WHERE name = 'Boarmon'
      ),
      (
        SELECT id 
        FROM vets
        WHERE name = 'Maisy Smith'
      ),
      '2019-01-24'
    ),
     (
      (
        SELECT id
        FROM animals
        WHERE name = 'Boarmon'
      ),
      (
        SELECT id 
        FROM vets
        WHERE name = 'Maisy Smith'
      ),
      '2019-05-15'
    ),
     (
      (
        SELECT id
        FROM animals
        WHERE name = 'Boarmon'
      ),
      (
        SELECT id 
        FROM vets
        WHERE name = 'Maisy Smith'
      ),
      '2020-02-27'
    ),
     (
      (
        SELECT id
        FROM animals
        WHERE name = 'Boarmon'
      ),
      (
        SELECT id 
        FROM vets
        WHERE name = 'Maisy Smith'
      ),
      '2020-08-03'
    ),
     (
      (
        SELECT id
        FROM animals
        WHERE name = 'Blossom'
      ),
      (
        SELECT id 
        FROM vets
        WHERE name = 'Stephanie Mendez'
      ),
      '2020-05-24'
    ),
     (
      (
        SELECT id
        FROM animals
        WHERE name = 'Blossom'
      ),
      (
        SELECT id 
        FROM vets
        WHERE name = 'William Tatcher'
      ),
      '2021-01-11'
    );

-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animal_id, vet_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';