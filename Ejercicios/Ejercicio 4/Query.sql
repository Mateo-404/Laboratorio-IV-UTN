USE jurassicPark;
-- <-- Unidad 4 -->
	-- 1
	-- Version 1
	SELECT Nombre, calle_escuela, altura_escuela, concat(t.codigo_area,'-',t.nro) as Telefono
	FROM Escuela e JOIN Telefono_Escuela t ON e.idEscuela = t.idEscuela 
	WHERE e.calle_escuela LIKE 'A%';
	-- Version 2
	SELECT e.Nombre, e.calle_escuela, e.altura_escuela, t.nro  
	FROM Escuela e LEFT JOIN Telefono_Escuela t BY (idEscuela)
	WHERE e.calle_escuela like 'A%' and t.nro is null;
	
	-- 2
	SELECT r.dia, e.Nombre, rt.Cantidad_alumnos_reservado, g.nombre
	from Escuela e 
	JOIN Reserva r on r.Escuela_idEscuela = e.idEscuela
	JOIN Reserva_Tipo_Visita rt on rt.Reserva_idReserva = r.idReserva
	JOIN Guia g on g.idguia = rt.guia_idguia;
	
	-- 4
	select e.Nombre, SUM(rtv.arancel_por_alumno * rtv.Cantidad_Alumnos_Reales)
	from Reserva_Tipo_Visita rtv 
	JOIN Reserva r on (r.idReserva = rtv.Reserva_idReserva)
	join Escuela e on (e.idEscuela = r.Escuela_idEscuela)
	GROUP BY e.Nombre
	HAVING SUM(rtv.arancel_por_alumno * rtv.Cantidad_Alumnos_Reales) > 2500;
	
	-- 6
	SELECT e.Nombre, r.dia
	FROM Reserva r
	JOIN Escuela e ON (r.Escuela_idEscuela = e.idEscuela)
	GROUP BY e.Nombre, dia
	HAVING COUNT(dia) > 1;
	
	-- 8
	SELECT rtv.Tipo_visitas_idTipo_visitas, r.dia,  sum(rtv.Cantidad_alumnos_reservado)as CantidadAlumnosTotales, g.nombre, e.Nombre
	FROM Reserva_Tipo_Visita rtv
	JOIN Reserva r on r.idReserva = rtv.Reserva_idReserva
	JOIN Guia g ON g.idguia = rtv.guia_idguia
	JOIN Escuela e ON e.idEscuela = r.Escuela_idEscuela
	GROUP BY rtv.Tipo_visitas_idTipo_visitas, r.dia, g.nombre, e.Nombre;

	-- 10
	SELECT g.nombre, g.apellido
	FROM Guia g
	LEFT JOIN Reserva_Tipo_Visita rtv ON rtv.guia_idguia = g.idguia
	WHERE rtv.Reserva_idReserva IS NULL;
	
	-- 12
	SELECT e.Nombre
	FROM Reserva_Tipo_Visita rtv
	JOIN Reserva r ON r.idReserva = rtv.Reserva_idReserva
	JOIN Escuela e ON e.idEscuela = r.Escuela_idEscuela
	GROUP BY e.Nombre
	HAVING SUM(rtv.Cantidad_Alumnos_Reales) = SUM(rtv.Cantidad_alumnos_reservado);

	-- 14
	SELECT e.Nombre , t.cod_area, t.nro
	FROM Escuela e
	JOIN Telefono_Escuela t ON e.idEscuela
	JOIN Reserva r on r.Escuela_idEscuela = e.idEscuela
	JOIN Reserva_Tipo_Visita rtv ON rtv.Reserva_idReserva = r.idReserva
	JOIN Tipo_Visita tv ON tv.idTipo_visitas = rtv.Tipo_visitas_idTipo_visitas
	WHERE tv.descripcion = 'Los Mamuts en Familia';

	-- 16
	CREATE TABLE Guia_Performance(
		idguia INT PRIMARY KEY,
		nombre varchar(50),
		totalAlumnosReservado INT,
		totalAlumnosReales INT
	);

	INSERT INTO Guia_Performance VALUES (
	SELECT g.idguia, g.nombre, SUM(rtv.Cantidad_alumnos_reservado), SUM(rtv.Cantidad_Alumnos_Reales)
	FROM Reserva r
	JOIN Reserva_Tipo_Visita rtv On r.idReserva = rtv.Reserva_idReserva
	JOIN Guia g ON g.idguia = rtv.guia_idguia
	WHERE YEAR(R.dia) = 2023
	GROUP BY g.idguia, g.nombre );