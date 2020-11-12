CREATE TABLE Departamentos (
	ID Int NOT NULL IDENTITY,
	Nombre Varchar(50) NOT NULL,
	
	CONSTRAINT PK_Departamento PRIMARY KEY (ID)
)


CREATE TABLE Personas (
	ID Int NOT NULL IDENTITY,
	Nombre Varchar(50) NOT NULL,
	Apellidos Varchar(80) NULL,
	FechaNacimiento Date NULL,
	Foto VarBinary(MAX) NULL,
	Direccion Varchar(100) NULL,
	Telefono Varchar(30) NULL,
	IDDepartamento Int NULL,
	
	CONSTRAINT PK_Persona PRIMARY KEY (ID),
	CONSTRAINT FK_Departamento_Persona FOREIGN KEY (IDDepartamento) REFERENCES Departamentos (ID) ON DELETE NO ACTION ON UPDATE CASCADE
)

INSERT INTO Departamentos (Nombre)
VALUES ('Marketing y Ventas'),
('Contabilidad y Finanzas'),
('Cadena de suministro'),
('Recursos Humanos')

INSERT INTO Personas (Nombre, IDDepartamento)
VALUES ('Prueba', 1)