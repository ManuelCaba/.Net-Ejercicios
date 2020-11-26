CREATE DATABASE ServicioOfertas;
USE ServicioOfertas;

CREATE TABLE ServicioOfertas.Ofertas (
	ID int NOT NULL PRIMARY KEY,
    Empresa varchar(40) NULL,
    Detalles varchar(150) NULL,
    Sueldo int NULL
);

INSERT INTO ServicioOfertas.Ofertas (ID, Empresa, Detalles, Sueldo)
VALUES (25, "Empresa Prueba", "Programador Junior de Java", 15000)