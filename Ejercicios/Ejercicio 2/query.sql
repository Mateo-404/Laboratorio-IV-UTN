USE jurassicPark

/*EJERCICIO 1*/
CREATE INDEX cod_escuela ON Reserva(Escuela_idEscuela); /*"codigo_escuela"*/

/*EJERCICIO 2*/
DROP INDEX Reserva.cod_escuela;

/*EJERCICIO 3*/
CREATE INDEX idx_reserva_visita ON Reserva_Tipo_Visita(Cantidad_alumnos_reservado); /*"reserva_visita"*/

/*EJERCICIO 4*/
CREATE CLUSTERED INDEX  idx_Guia_Nombre_Apellido ON Guia(nombre, apellido);

/*EJERCICIO 5*/
CREATE INDEX idx_fecha_hora_reserva ON Reserva(hora, dia) WITH (FILLFACTOR = 90);

/*EJERCICIO 6*/
-- Primero creo los usuarios
CREATE LOGIN jPerez WITH PASSWORD = 'admin';
CREATE LOGIN aFernandez WITH PASSWORD = 'admin';

CREATE USER jPerez FOR LOGIN jPerez;
CREATE USER aFernandez FOR LOGIN aFernandez;

-- Garantizo los permisos
GRANT INSERT, UPDATE ON Telefono_Escuela TO jPerez, aFernandez;

/*EJERCICIO 7*/
REVOKE UPDATE ON Telefono_Escuela TO jPerez, aFernandez;

/*EJERCICIO 8*/
GRANT CREATE TABLE TO jPerez;

/*EJERCICIO 9*/
REVOKE SELECT ON Escuela TO public;

/*EJERCICIO 10*/
DROP INDEX idx_Guia_Nombre_Apellido;

/*EJERCICIO 11*/
CREATE UNIQUE INDEX idxx_Guia_Nombre_Apellido ON Guia(nombre, apellido);

/*EJERCICIO 12*/ --! Revisar de acá para abajo
-- Primero creo el Rol
CREATE ROLE CORDOBA;
-- Asigno permisos
GRANT SELECT ON reserva_visita TO CORDOBA;

/*EJERCICIO 13*/
-- Crear una vista sin el campo Arancel_por_Alumno
CREATE VIEW vista_sin_arancel AS SELECT Cantidad_alumnos_reservado, Cantidad_Alumnos_Reales, Reserva_idReserva, Tipo_visitas_idTipo_visitas, guia_idguia FROM Reserva_Tipo_Visita;

-- Conceder acceso a la vista al usuario jPerez
GRANT SELECT ON vista_sin_arancel TO jPerez;

/*EJERCICIO 14*/
CREATE ROLE ADM;
GRANT ALL PRIVILEGES ON jurassicPark TO ADM;

/*EJERCICIO 15*/
ALTER ROLE ADM ADD MEMBER aFernandez;

-- Denegar el permiso para realizar backups sobre la base de datos
REVOKE BACKUP ON jurassicPark FROM aFernandez;

-- Denegar el permiso para realizar backups sobre el log de transacciones (si el DBMS lo soporta)
REVOKE BACKUP FROM aFernandez;


