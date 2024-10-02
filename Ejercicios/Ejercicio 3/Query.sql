USE jurassicPark;
-- EJERCICIOS GUIA 3
-- <-- INSERT -->
	-- 1
	INSERT INTO Distrito_Escolar(CP) 
	VALUES (123); -- Agregué Distrito para que no salte error

	INSERT INTO Escuela(idEscuela, domicilio, Nombre, email, codigo_distrito_escolar, calle_escuela, altura_escuela)
	VALUES (1998, 'Acuña 1342', 'UTN FRRa', 'utn@edu.com', 123, 'Acuña', '1342');

	-- 2
	INSERT INTO Guia(nombre, guia_idguia, apellido)
	VALUES ('Mateo', NULL, 'Gariboglio'); -- No coloco idguia porque se incrementa automáticamente

	-- 3 (???)
	INSERT INTO Escuela(idEscuela, Nombre, domicilio)
	VALUES (14, 'Mario Vecchioli', 'Bv Sta fe 1997');

	-- 4 (???)
	-- Borrar todos los telefonos
	DELETE FROM Telefono_Escuela;
	-- Insertar los nuevos telefonos
	INSERT INTO Telefono_Escuela(codigo_area, Escuela_idEscuela) SELECT 1111, idEscuela FROM Escuela; -- Ojo con la PK

-- <-- UPDATE --> (Sin chequear)
	-- 5
	UPDATE Telefono_Escuela
	SET codigo_area = 54453223;
	-- 6
	UPDATE Reserva SET dia = '2018-12-23' WHERE dia = '2018-01-01';
	-- 7
	UPDATE Reserva_Tipo_Visita SET arancel_por_alumno = -2 WHERE Tipo_visitas_idTipo_visitas = 2 AND Cantidad_alumnos_reservado > 10; -- Supongo que 2 es el id para las escuelas
	-- 8
	UPDATE Reserva_Tipo_Visita SET guia_idguia = 2 WHERE guia_idguia = 1;

-- <-- DELETE -->
	-- 9
	DELETE FROM Reserva_Tipo_Visita WHERE Cantidad_alumnos_reservado < 10;
	-- 10
	DELETE FROM Guia WHERE nombre = NULL;

-- <-- SELECT -->
	-- 11
	SELECT * FROM Guia WHERE nombre = 'Bernardo';
	-- 12
	SELECT COUNT(*) FROM Reserva WHERE dia > '2004-3-1';
	-- 13
	SELECT SUM(Cantidad_alumnos_reservado) FROM Reserva_Tipo_Visita;
	-- 14
	SELECT * FROM Reserva_Tipo_Visita WHERE Cantidad_alumnos_reservado > 20;
	-- 15 ¡Arreglar!
/*	SELECT * FROM Reserva_Tipo_Visita RTV, Reserva R WHERE RTV.Cantidad_Alumnos_Reales = 0 AND 5 < ; */
	-- 16
	SELECT DISTINCT  COUNT(Escuela_idEscuela) FROM Reserva WHERE dia > '2018-06-30';

-- <-- VARIOS -->
	-- 17
	INSERT Guia(nombre, apellido) VALUES ('Pedro', 'Sanchez'); -- El atributo `idguia` es autoincremental
	-- 18 (???)
	-- Hay 2 formas, una es modificar la tabla para que la columna idTipo_Visitas sea incremental, la otra es:
	-- Obtener el maximo valor
	SELECT MAX(idTipo_visitas) FROM Tipo_Visita;
	-- Para luego ingresar el valor manualmente
	INSERT INTO Tipo_Visita(idTipo_visitas, descripcion, arancel_por_alumno) VALUES (6, 'alumnos de la UTN', 199);
	-- 19
	-- Creación de la tabla donde se insertarán los datos viejos
	CREATE TABLE Escuela2(
		idEscuela2 INT PRIMARY KEY,
		domicilio VARCHAR(45),
		nombre VARCHAR(45),
		email VARCHAR(45),
		codigo_distrito_escolar INT FOREIGN KEY REFERENCES Distrito_Escolar(CP),
		calle_escuela VARCHAR(45),
		altura_escuela VARCHAR(45)
	);
	-- Inserto los datos viejos
	INSERT INTO Escuela2 SELECT * FROM Escuela;
	-- Incremento de ID
	UPDATE Escuela2 SET idEscuela2 =+ 1;
	-- Elimino datos de la tabla vieja
	DELETE FROM Escuela;
	-- Inserto los datos ACTUALIZADOS a la tabla vieja
	INSERT INTO Escuela SELECT * FROM Escuela2;
	
	-- 20
	UPDATE Telefono_Escuela SET codigo_area = CONCAT(9, codigo_area);
	-- 21
	UPDATE Reserva SET dia = DAY(dia) + 1;
	-- 22
	SELECT idReserva, MAX(dia), hora, Escuela_idEscuela FROM Reserva;
	-- 23
	SELECT apellido FROM Guia GROUP BY apellido HAVING COUNT(*) > 1;
	-- 24
	SELECT dia, COUNT(*) AS CantReservas FROM Reserva GROUP BY dia;
	-- 25 (???)
	-- 26
	SELECT * FROM Reserva_Tipo_Visita GROUP BY guia_idguia HAVING COUNT(*) > 3;
