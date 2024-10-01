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

/*EJERCICIO 12*/
-- Primero creo el Rol
CREATE ROLE CORDOBA;
-- Asigno permisos
GRANT SELECT ON Reserva_Tipo_Visita TO CORDOBA;

/*EJERCICIO 13*/
-- Agrego a jPerez a Cordoba
ALTER ROLE CORDOBA ADD MEMBER jPerez;
-- Deniego ver el campo
DENY ALL ON Reserva_Tipo_Visita(arancel_por_alumno) TO jPerez;

/*EJERCICIO 14*/
CREATE ROLE ADM;
GRANT CONTROL ON DATABASE::jurassicPark TO ADM;

/*EJERCICIO 15*/
ALTER ROLE ADM ADD MEMBER aFernandez;

-- Denegar el permiso para realizar backups sobre la base de datos
DENY BACKUP DATABASE ON DATABASE::jurassicPark TO aFernandez;

-- Denegar el permiso para realizar backups sobre el log de transacciones
DENY BACKUP LOG ON DATABASE::jurassicPark TO aFernandez;