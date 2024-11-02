USE jurassicPark;

-- 1
SELECT tv.idTipo_visitas, tv.descripcion
FROM Reserva_Tipo_Visita rtv
JOIN Tipo_Visita tv ON rtv.Reserva_idReserva = tv.idTipo_visitas
WHERE guia_idguia IN (SELECT idguia
						FROM Guia
						WHERE nombre = 'Cristina Zaluzi');

-- 2 Listar los códigos de escuelas que poseen una cantidad total real de alumnos que visitaron el parque, mayor a 400.
SELECT r.Escuela_idEscuela AS Codigo_Escuela
FROM Reservas r
JOIN Reserva_Tipo_Visita rtv ON r.idReserva = rtv.idReserva
GROUP BY r.Escuela_idEscuela
HAVING SUM (rtv.Cantidad_Alumnos_Reales) > 400;

-- 3
SELECT e.Nombre
FROM Escuela e
where e.idEscuela not in (select r.idReserva
							from Reserva r
							where YEAR(dia) = 2002)
							and
							e.idEscuela in (select r.idReserva
							from Reserva r
							where YEAR(dia) = 2001);
							
-- 4
SELECT g.idguia, g.nombre, g.apellido 
FROM Guia g
JOIN Reserva_Tipo_Visita rtv ON g.idguia = rtv.FK_guia_idguia
GROUP BY g.idguia, g.nombre, g.apellido 
HAVING COUNT(DISTINCT rtv.idTipo_visita ) > 10
AND SUM(rtv.Cantidad_Alumnos_Reales) > 200;

-- 5. Listar las escuelas que poseen más de 4 reservas con más de 3 tipos de visitas para cada reserva.
SELECT e.nombre AS nombre_escuela
FROM Escuelas e
JOIN Reservas r ON e.escuela_id = r.escuela_id
JOIN ReservaDetalle rd ON r.reserva_id = rd.reserva_id
GROUP BY e.escuela_id, e.nombre
HAVING COUNT(DISTINCT r.reserva_id) > 4
   AND COUNT(DISTINCT rd.tipo_visita_id) > 3;

-- 6
SELECT g.idguia, g.nombre, g.apellido
FROM Guia g 
JOIN Reserva_tipo_Visita rtv ON g.idguia = rtv.guia_idguia
JOIN Reserva r ON r.idReserva = rtv.Reserva_idReserva
GROUP BY  g.idguia, g.nombre, g.apellido,  rtv.Cantidad_Alumnos_Reales
HAVING rtv.Cantidad_Alumnos_Reales >= 0.4 * ( 
	SELECT SUM(rtv2.Cantidad_Alumnos_Reales) 
	FROM Reserva_Tipo_Visita rtv2 
	WHERE rtv2.guia_idguia = g.idguia 
);

-- 7. Listar las reservas donde todos los tipos de visita tienen la cantidad real de alumnos mayor en un 20% adicional a la cantidad reservada.
SELECT r.reserva_id
FROM Reservas r
JOIN ReservaDetalle rd ON r.reserva_id = rd.reserva_id
GROUP BY r.reserva_id
HAVING MIN(rd.cantidad_real) > 1.2 * MIN(rd.cantidad_reservada);

-- 8.	Listar el nombre y el código de aquellas escuelas que hayan asistido el día en que se registró la mayor cantidad de alumnos reales.
-- Supongo que mas de 1 dia tienen la misma cantidad de Alumnos Reales maxima

SELECT e.idEscuela, e.Nombre
FROM Escuela e
WHERE e.idEscuela IN (SELECT DISTINCT r.Escuela_idEscuela
						FROM Reserva_Tipo_Visita rtv
						JOIN Reserva r ON r.idReserva = rtv.Reserva_idReserva
						WHERE Cantidad_Alumnos_Reales = (SELECT TOP 1 Cantidad_Alumnos_Reales
														FROM Reserva_Tipo_Visita
														ORDER BY Cantidad_Alumnos_Reales DESC))

-- 9. Listar el código y nombre de las escuelas cuya fecha de reserva sea igual a la primera fecha de reserva realizada.
SELECT e.codigo_distrito_escolar, e.Nombre
FROM Escuela e
WHERE e.idEscuela in (
	SELECT DISTINCT r.Escuela_idEscuela
	FROM Reserva r
	WHERE r.dia = (
		SELECT MIN(dia)
		FROM Reserva));

-- 10.	Listar las escuelas que visitaron entre los años 2001 y en el 2002.
SELECT DISTINCT idEscuela, Nombre, codigo_distrito_escolar
FROM Escuela 
WHERE idEscuela IN (SELECT Escuela_idEscuela
						FROM Reserva
						WHERE Escuela_idEscuela IN (SELECT DISTINCT Escuela_idEscuela
													FROM Reserva
													WHERE YEAR(dia) = '2001')
								AND
								Escuela_idEscuela IN (SELECT DISTINCT Escuela_idEscuela
													FROM Reserva
													WHERE YEAR(dia) = '2002'));


-- 11. Listar los guías que tuvieron más de 3 escuelas diferentes y una cantidad total real de alumnos mayor a 200.
SELECT DISTINCT g.idguia
FROM Guia g
WHERE 
    -- Subconsulta para guías con más de 200 alumnos
    g.idguia IN (
        SELECT rtv.guia_idguia
        FROM Reserva_Tipo_Visita rtv
        GROUP BY rtv.guia_idguia
        HAVING SUM(rtv.Cantidad_Alumnos_Reales) > 200
    )
    AND 
    -- Subconsulta para guías con más de 3 escuelas distintas
    g.idguia IN (
        SELECT rtv.guia_idguia
        FROM Reserva r
        JOIN Reserva_Tipo_Visita rtv ON rtv.Reserva_idReserva = r.idReserva
        GROUP BY rtv.guia_idguia
        HAVING COUNT(DISTINCT r.Escuela_idEscuela) > 3
    );


-- 12.	Listar los nombres y códigos de escuelas con gasto total de todas las visitas mayor a $1900.
SELECT DISTINCT e.idEscuela, e.codigo_distrito_escolar, e.Nombre
FROM Escuela e
JOIN Reserva r ON e.idEscuela = r.Escuela_idEscuela 
WHERE r.idReserva IN (SELECT DISTINCT idReserva
						FROM Reserva_Tipo_Visita
						WHERE arancel_por_alumno = 1900);
						
-- 13. Listar los guías que hayan tenido en solo un tipo de visita de una reserva en particular por lo menos el 45% del total de alumnos totales que esa persona atendió.
Select G.nombre, G.apellido
From guia as G
where G.idguia in (
    Select RTV1.guia_idguia as guia,
           sum(RTV1.cantidad_alumnos_reales) * 0.45
    From Reserva_tipo_visita as RTV1
    Inner Join Reserva as R
    on RTV1.reserva_idreserva = R.idReserva
    where Year(R.dia) = '2024'
    Group by RTV1.guia_idguia
    Having sum(RTV1.cantidad_alumnos_reales) * 0.45 > any (
        Select RTV2.cantidad_alumnos_reales
        From Reserva_tipo_visita as RTV2
        Inner Join Reserva as R2
        on RTV2.reserva_idreserva = R2.idReserva
        where Year(dia) = '2024'
        and RTV2.guia_idguia = RTV1.guia_idguia
    )
)
