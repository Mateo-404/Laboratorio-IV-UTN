/* EJERCICIO 1 */ /*
CREATE TABLE Escuela (
    idEscuela INT PRIMARY KEY,
    domicilio VARCHAR(45),
	Nombre VARCHAR(45),
	email VARCHAR(250)
);

CREATE TABLE Guia(
	idguia INT PRIMARY KEY IDENTITY,
	nombre VARCHAR(250),
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
/*EJERCICIO 3*/ /*REVISAR*/
/*
CREATE TABLE Reserva_Por_Grado(
	grado_idGrado INT,
	Reserva_tipo_visita_Tipo_visitas INT,
	Reserva_tipo_visita_Reserva_tipo_visita INT,
	FOREIGN KEY (grado_idGrado) REFERENCES grado(idGrado),
	FOREIGN KEY (Reserva_tipo_visita_Tipo_visitas) REFERENCES Reserva_tipo_visita(Reserva_idReserva),
	FOREIGN KEY (Reserva_tipo_visita_Reserva_tipo_visita) REFERENCES Tipo_visitas(idTipo_visitas),
	PRIMARY KEY (grado_idGrado, Reserva_tipo_visita_Tipo_visitas,Reserva_tipo_visita_Reserva_tipo_visita)
);
*/

*/
/*EJERCICIO 4*/
CREATE TABLE Reserva_Tipo_Visita(
	Cantidad_alumnos_reservado INT,
	arancel_por_alumno FLOAT,
	Cantidad_Alumnos_Reales INT
); 


/*EJERCICIO 5*/
ALTER TABLE Reserva_Tipo_Visita ADD Reserva_idReserva INT
ALTER TABLE Reserva_Tipo_Visita ADD Tipo_visitas_idTipo_visitas INT
ALTER TABLE Reserva_Tipo_Visita ADD guia_idguia INT
ALTER TABLE Reserva_Tipo_Visita ADD PRIMARY KEY(Reserva_idReserva,Tipo_visitas_idTipo_visitas, guia_idguia)
ALTER TABLE Reserva_Tipo_Visita ADD FOREIGN KEY (guia_idguia) REFERENCES Guia(idguia)

/*EJERCICIO 6*/
ALTER TABLE Guia ADD sueldo_hora FLOAT

/*EJERCICIO 7*/ /*DA ERROR*/
/*
ALTER TABLE Escuela ALTER COLUMN Nombre PRIMARY KEY IDENTITY
*/