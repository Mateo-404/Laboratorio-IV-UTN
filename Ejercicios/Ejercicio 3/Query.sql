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
INSERT INTO Telefono_Escuela(codigo_area, Escuela_idEscuela) SELECT 11111111 , idEscuela FROM Escuela;

