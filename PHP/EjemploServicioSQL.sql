CREATE DATABASE EjemploServicio;
USE EjemploServicio;

CREATE TABLE EjemploServicio.Personas (
	ID int NOT NULL PRIMARY KEY,
    Name varchar(40) NULL,
    Surname varchar(80) NULL,
    Age int NULL
);

INSERT INTO EjemploServicio.Personas (ID, Name, Surname, Age)
VALUES (25, "Pepe", "Iglesias", 25)