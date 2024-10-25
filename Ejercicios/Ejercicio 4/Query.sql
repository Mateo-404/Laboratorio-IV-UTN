USE jurassicPark;
-- <-- Unidad 4 -->
	-- 1
	-- Version 1
	SELECT Nombre, calle_escuela, altura_escuela, concat(t.codigo_area,'-',t.nro) as Telefono
	FROM Escuela e JOIN Telefono_Escuela t ON e.idEscuela = t.Escuela_idEscuela
	WHERE e.calle_escuela LIKE 'A%';
	-- Version 2
	SELECT e.Nombre, e.calle_escuela, e.altura_escuela, t.nro
	FROM Escuela e 
	LEFT JOIN Telefono_Escuela t ON t.Escuela_idEscuela = e.idEscuela  
	WHERE e.calle_escuela like 'A%' and t.nro is null;
	
	-- 2
	SELECT r.dia, e.Nombre, rt.Cantidad_alumnos_reservado, g.nombre
	from Escuela e 
	JOIN Reserva r on r.Escuela_idEscuela = e.idEscuela
	JOIN Reserva_Tipo_Visita rt on rt.Reserva_idReserva = r.idReserva
	JOIN Guia g on g.idguia = rt.guia_idguia;
	
	-- 3
	SELECT Reserva_idReserva, SUM(Cantidad_Alumnos_Reales) as TotalAlumnos, SUM(arancel_por_alumno*Cantidad_Alumnos_Reales*1.21)
	FROM Reserva_Tipo_Visita
	GROUP BY Reserva_idReserva;

	-- 4
	select e.Nombre, SUM(rtv.arancel_por_alumno * rtv.Cantidad_Alumnos_Reales)
	from Reserva_Tipo_Visita rtv 
	JOIN Reserva r on (r.idReserva = rtv.Reserva_idReserva)
	join Escuela e on (e.idEscuela = r.Escuela_idEscuela)
	GROUP BY e.Nombre
	HAVING SUM(rtv.arancel_por_alumno * rtv.Cantidad_Alumnos_Reales) > 2500;
	
	-- 5
	SELECT e.Nombre
	FROM Reserva_Tipo_Visita rtv
	JOIN Reserva r ON r.idReserva = rtv.Reserva_idReserva
	JOIN Escuela e ON e.idEscuela = r.idReserva
	JOIN Guia g ON g.idguia = rtv.guia_idguia
	WHERE g.nombre = 'Cristina' AND g.apellido = 'Zaluzi'
	GROUP BY e.Nombre;

	-- 6
	SELECT e.Nombre, r.dia
	FROM Reserva r
	JOIN Escuela e ON (r.Escuela_idEscuela = e.idEscuela)
	GROUP BY e.Nombre, dia
	HAVING COUNT(dia) > 1;
	
	-- 7
	SELECT rtv.guia_idguia, MAX(g.nombre), MAX(g.apellido)
	FROM Reserva_Tipo_Visita rtv
	JOIN Guia g ON g.idguia = rtv.guia_idguia
	GROUP BY rtv.guia_idguia
	HAVING COUNT(rtv.guia_idguia) > 10 AND SUM(Cantidad_Alumnos_Reales) > 100; 

	-- 8
	SELECT rtv.Tipo_visitas_idTipo_visitas, r.dia,  sum(rtv.Cantidad_alumnos_reservado)as CantidadAlumnosTotales, g.nombre, e.Nombre
	FROM Reserva_Tipo_Visita rtv
	JOIN Reserva r on r.idReserva = rtv.Reserva_idReserva
	JOIN Guia g ON g.idguia = rtv.guia_idguia
	JOIN Escuela e ON e.idEscuela = r.Escuela_idEscuela
	GROUP BY rtv.Tipo_visitas_idTipo_visitas, r.dia, g.nombre, e.Nombre;

	-- 9
	SELECT tv.idTipo_visitas, MAX(descripcion)
	FROM Reserva_Tipo_Visita rtv
	JOIN Tipo_Visita tv ON rtv.Tipo_visitas_idTipo_visitas = tv.idTipo_visitas
	GROUP BY tv.idTipo_visitas
	HAVING COUNT(tv.idTipo_visitas) > 5;

	-- 10
	SELECT g.nombre, g.apellido
	FROM Guia g
	LEFT JOIN Reserva_Tipo_Visita rtv ON rtv.guia_idguia = g.idguia
	WHERE rtv.Reserva_idReserva IS NULL;
	
	-- 11
	SELECT DISTINCT g.nombre, g.apellido
	FROM Reserva_Tipo_Visita rtv
	JOIN Reserva r on rtv.Reserva_idReserva = r.idReserva
	JOIN Escuela e ON r.Escuela_idEscuela = e.idEscuela
	JOIN Guia g ON g.idguia = rtv.guia_idguia
	WHERE e.Nombre NOT LIKE 'E%';

	-- 12
	SELECT e.Nombre
	FROM Reserva_Tipo_Visita rtv
	JOIN Reserva r ON r.idReserva = rtv.Reserva_idReserva
	JOIN Escuela e ON e.idEscuela = r.Escuela_idEscuela
	GROUP BY e.Nombre
	HAVING SUM(rtv.Cantidad_Alumnos_Reales) = SUM(rtv.Cantidad_alumnos_reservado);

	-- 13
	/*
	Realizar la Union de las consultas: 
		- Nombres de las escuelas con reservas antes de las 9:00 hs
		- Apellidos de los guías cuyos nombres comiencen con `V`
		- Ordenar el resultado en forma descendente
	*/

	SELECT e.*, g.apellido
	FROM Escuela e
	JOIN Reserva r on r.Escuela_idEscuela = e.idEscuela
	FULL JOIN Guia g ON 1 = 0 -- Esto asegura que no hay ninguna relación directa entre las escuelas y los guías. Asegurando que muestra null cuando la columna no tiene relacion con la otra tabla
	WHERE r.hora < 9
	AND g.apellido LIKE 'V%'
	ORDER BY apellido DESC;

	-- 14
	SELECT e.Nombre , t.cod_area, t.nro
	FROM Escuela e
	JOIN Telefono_Escuela t ON e.idEscuela
	JOIN Reserva r on r.Escuela_idEscuela = e.idEscuela
	JOIN Reserva_Tipo_Visita rtv ON rtv.Reserva_idReserva = r.idReserva
	JOIN Tipo_Visita tv ON tv.idTipo_visitas = rtv.Tipo_visitas_idTipo_visitas
	WHERE tv.descripcion = 'Los Mamuts en Familia';

	-- 15
	SELECT e.Nombre, MAX(dia)
	FROM Reserva r
	JOIN Escuela e on e.idEscuela = r.Escuela_idEscuela
	WHERE dia < GETDATE() -- Para que no nos de reservas Futuras
	GROUP BY e.Nombre;

	-- 16
	CREATE TABLE Guia_Performance(
		idguia INT PRIMARY KEY,
		nombre varchar(50),
		totalAlumnosReservado INT,
		totalAlumnosReales INT
	);

	INSERT INTO Guia_Performance(idguia, nombre, totalAlumnosReservado, totalAlumnosReales)
	SELECT g.idguia, g.nombre, SUM(rtv.Cantidad_alumnos_reservado), SUM(rtv.Cantidad_Alumnos_Reales)
	FROM Reserva r
	JOIN Reserva_Tipo_Visita rtv On r.idReserva = rtv.Reserva_idReserva
	JOIN Guia g ON g.idguia = rtv.guia_idguia
	WHERE YEAR(R.dia) = 2023
	GROUP BY g.idguia, g.nombre;