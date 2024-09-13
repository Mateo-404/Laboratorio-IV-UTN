USE jurassicPark

/* EJERCICIO 1 */
CREATE TABLE Escuela (
    idEscuela INT PRIMARY KEY,
    domicilio VARCHAR(45),
	Nombre VARCHAR(45),
	email VARCHAR(250)
);

CREATE TABLE Guia(
	idguia INT PRIMARY KEY IDENTITY,
	nombre VARCHAR(250),
	apellido VARCHAR(250),
	guia_idguia INT,
	FOREIGN KEY (guia_idguia) REFERENCES Guia(idguia)
);

CREATE TABLE Reserva (
    idReserva INT,
    dia DATE,
    hora INT,
    Escuela_idEscuela INT,
    FOREIGN KEY (Escuela_idEscuela) REFERENCES Escuela(idEscuela)
);

CREATE TABLE Tipo_Visita(
	idTipo_visitas INT IDENTITY(1,1) PRIMARY KEY,
	descripcion VARCHAR(250),
	arancel_por_alumno FLOAT
);

/*EJERCICIO 2*/
CREATE TABLE Telefono_Escuela (
	codigo_area INT,
	nro INT,
	Escuela_idEscuela INT,
	PRIMARY KEY (codigo_area, nro),
	FOREIGN KEY (Escuela_idEscuela) REFERENCES Escuela(idEscuela) 
);

/*! <- DE ACA EN ADELANTE ->*/

/*EJERCICIO 4*/
CREATE TABLE Reserva_Tipo_Visita(
	Cantidad_alumnos_reservado INT,
	arancel_por_alumno FLOAT,
	Cantidad_Alumnos_Reales INT
);

/*EJERCICIO 5*/
ALTER TABLE Reserva_Tipo_Visita ADD Reserva_idReserva INT NOT NULL;
ALTER TABLE Reserva_Tipo_Visita ADD Tipo_visitas_idTipo_visitas INT NOT NULL;
ALTER TABLE Reserva_Tipo_Visita ADD guia_idguia INT CONSTRAINT FK_guia_idguia FOREIGN KEY (guia_idguia) REFERENCES Guia(idguia);
ALTER TABLE Reserva_Tipo_Visita ADD CONSTRAINT PK_Reserva_Tipo_Visita PRIMARY KEY (Reserva_idReserva, Tipo_visitas_idTipo_visitas);


/*Tuve que agragar la tabla Grado para el ejercicio 3*/
CREATE TABLE grado(
	idGrado INT PRIMARY KEY
);

/*EJERCICIO 3*/ /*REVISAR*/
CREATE TABLE Reserva_Por_Grado(
	grado_idGrado INT FOREIGN KEY REFERENCES grado(idGrado),
 /*	Reserva_tipo_visita_Tipo_visitas INT FOREIGN KEY REFERENCES Reserva_Tipo_Visita(Reserva_idReserva),*/
	Reserva_tipo_visita_Reserva_tipo_visita INT FOREIGN KEY REFERENCES Tipo_Visita(idTipo_visitas),
	PRIMARY KEY (grado_idGrado,/* Reserva_tipo_visita_Tipo_visitas, */ Reserva_tipo_visita_Reserva_tipo_visita)
);

/*EJERCICIO 6*/
ALTER TABLE Guia ADD sueldo_hora FLOAT;

/*EJERCICIO 7*/
ALTER TABLE Escuela ADD CONSTRAINT UNQ_Nombre UNIQUE (Nombre);

/*Ejercicio 8*/
CREATE TABLE Distrito_Escolar(
	CP INT IDENTITY(1,1) CONSTRAINT PK_CP PRIMARY KEY,
	nombre_distro VARCHAR(50) NOT NULL
);

/*Ejercicio 9*/ /*REVISAR*/
ALTER TABLE Escuela ADD codigo_distrito_escolar INT FOREIGN KEY REFERENCES Distrito_Escolar(CP);

/*Ejercicio 10*/
ALTER TABLE Escuela DROP COLUMN domicilio;

/*Ejercicio 11*/
ALTER TABLE Escuela ADD calle_escuela VARCHAR(45);
ALTER TABLE Escuela ADD altura_escuela INT;

/*Ejercicio 12*/
ALTER TABLE Guia ADD domicilio_guia VARCHAR(45);

/*Ejercicio 13*/
DROP TABLE Telefono_Escuela;

/*Ejercicio 14*/
CREATE TABLE Email_Escuela (
    idEscuela INT FOREIGN KEY REFERENCES Escuela(idEscuela),
    email VARCHAR(255)
);

/*Ejercicio 15*/
ALTER TABLE Email_Escuela ALTER COLUMN idEscuela INT NOT NULL;
ALTER TABLE Email_Escuela ADD CONSTRAINT PK_idEscuela PRIMARY KEY (idEscuela);

/*Ejercicio 16*/
ALTER TABLE Guia ALTER COLUMN nombre VARCHAR(250) NOT NULL;
ALTER TABLE Guia ALTER COLUMN apellido VARCHAR(250) NOT NULL;

/*Ejercicio 17*/
ALTER TABLE Escuela ADD CONSTRAINT UQ_Calle_Altura UNIQUE (calle_escuela, altura_escuela);