/*Queries that provide answers to the questions from all projects.*/

/*Find all animals whose name ends in "mon".*/
SELECT * from animals WHERE name LIKE '%mon';

/*List the name of all animals born between 2016 and 2019.*/
SELECT name FROM  animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-01-01';

/*List the name of all animals that are neutered and have less than 3 escape attempts.*/
SELECT name from animals WHERE neutered = TRUE AND escape_attempts < 3;

/*List date of birth of all animals named either "Agumon" or "Pikachu".*/
SELECT date_of_birth from animals WHERE name = 'Agumon' OR name = 'Pikachu';

/*List name and escape attempts of animals that weigh more than 10.5kg*/
SELECT name from animals WHERE weight_kg > 10.5;

/*Find all animals that are neutered.*/
SELECT * from animals WHERE neutered = TRUE;

/*Find all animals not named Gabumon.*/
SELECT * from animals WHERE name <> 'Gabumon';

/*Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)*/
SELECT * from animals WHERE weight_kg >=10.4 AND weight_kg <=17.3;

/* Count number of animals */
SELECT COUNT(*) FROM animals;

/* Count number of animals that have not attempted escape */
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

/* Avarage weight of animals */
SELECT AVG(weight_kg) FROM animals;

/* Sum escape attempts and compare between neutered and non-neutered */
SELECT neutered, SUM(escape_attempts) FROM animals GROUP BY neutered;

/* Minimum and maximum weights of each type of animal*/
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

/* Average number of escape attempts per animal type of those born between 1990 and 2000 */
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth 
BETWEEN 'Jan 1, 1990' AND 'Dec 31, 2000' GROUP BY species;