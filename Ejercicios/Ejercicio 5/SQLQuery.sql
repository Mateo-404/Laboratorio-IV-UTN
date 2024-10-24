USE jurassicPark;

-- 1
SELECT tv.idTipo_visitas, tv.descripcion
FROM Reserva_Tipo_Visita rtv
JOIN Tipo_Visita tv ON rtv.Reserva_idReserva = tv.idTipo_visitas
WHERE guia_idguia IN (SELECT idguia
						FROM Guia
						WHERE nombre = 'Cristina Zaluzi');

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