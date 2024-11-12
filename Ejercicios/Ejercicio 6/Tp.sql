USE jurassicPark;
-- <-- PROCEDIMIENTOS --> 
-- 1. Crear un procedimiento almacenado que devuelva la cantidad total de Alumnos Reales asignados a un guía.
CREATE PROCEDURE contarAlumnosR_Guia
    @CodGuia INT
AS
	DECLARE  @TotalAlumnosReales INT
    -- Calcula la suma y asigna el resultado al parámetro de salida
    SELECT @TotalAlumnosReales = SUM(rtv.Cantidad_Alumnos_Reales)
    FROM Reserva_Tipo_Visita rtv
    WHERE rtv.guia_idguia = @CodGuia
	RETURN @TotalAlumnosReales;

-- 2. Crear un procedimiento almacenado para insertar una nueva escuela.
CREATE PROCEDURE insertarNuevaEscuela
    @Codigo_Escuela INT,
    @Nombre_Escuela VARCHAR(45),
    @Domicilio_Escuela VARCHAR(45)
AS
    INSERT INTO Escuela (idEscuela, Nombre, domicilio)
    VALUES (@Codigo_Escuela, @Nombre_Escuela, @Domicilio_Escuela);

-- 3. Crear un procedimiento almacenado que liste los guías cuyos apellidos comiencen con una cadena de texto. O predeterminadamente con A
CREATE PROCEDURE listarGuias_Apellido
    @Patron_Apellido VARCHAR(250)
AS
    -- Si el parámetro es NULL, se asigna el valor predeterminado 'A%'
    IF @Patron_Apellido IS NULL
        SET @Patron_Apellido = 'A%';

    SELECT nombre
    FROM guia
    WHERE nombre LIKE @Patron_Apellido;


-- <-- TRIGGERS -->
-- 4. Crear un trigger que elimine las filas correspondientes de la tabla Telefono al borrar una escuela.
CREATE TRIGGER DelTel_DelEscuela
ON Escuela
FOR DELETE
AS
BEGIN
    DELETE FROM Telefonos
    WHERE Escuela_idEscuela  IN (SELECT idEscuela FROM deleted); -- En deleted están las tuplas eliminadas
END;

-- 5. Crear un trigger que actualice Reserva_tipo_visita al actualizar el codigo_guia en Guia.
/*
	UPDATE:
	inserted: Contiene las filas después de la operación de actualización (es decir, los nuevos valores de las filas modificadas).
	deleted: Contiene las filas antes de la operación de actualización (es decir, los valores antiguos de las filas modificadas).
*/
CREATE TRIGGER UPD_ReservaVisita__UPD_Guia
ON guia
FOR UPDATE
AS
BEGIN
    IF UPDATE(guia_idguia)  -- Verifica si la columna 'guia_idguia' fue actualizada
    BEGIN
        UPDATE Reserva_tipo_visita
        SET guia_idguia = inserted.idguia  -- Actualiza con el nuevo valor de 'idguia'
        FROM inserted  -- Obtiene los nuevos valores
        WHERE Reserva_tipo_visita.guia_idguia = deleted.idguia;  -- Compara el id de guia con el valor antiguo de 'idguia'
    END
END;

-- 6. Crear un trigger que verifique la existencia de una escuela antes de insertar en Telefono.
CREATE TRIGGER CHECKEscuelaExist_Telefono_INSERT
ON Telefono_Escuela
FOR INSERT
AS
BEGIN
    -- Verifica si la escuela existe en la tabla 'Escuela' usando el 'Escuela_idEscuela' insertado.
    IF NOT EXISTS (
        SELECT TOP 1 idEscuela
        FROM Escuela
        WHERE idEscuela = (SELECT Escuela_idEscuela FROM inserted)
    )
    BEGIN
        -- Si no existe, Revierte la transacción.
        ROLLBACK TRANSACTION;
    END
END;


-- 7. Crear un stored procedure que inserte 26 escuelas con nombres y direcciones secuenciales.
CREATE PROCEDURE INSERT_26Escuelas
AS
BEGIN
    DECLARE @i INT = 1;
    WHILE @i < 27
    BEGIN
        -- Genera un nombre de escuela, y asigna numero en incremento como 'Nom_Escuela1', 'Nom_Escuela2', lo mismo con direccion
        DECLARE @Nombre_Escuela VARCHAR(50) = 'Nom_Escuela' + @i ;
        DECLARE @Domicilio_Escuela VARCHAR(50) = 'Dir_Escuela' + @i;

        -- Inserta una nueva escuela con el nombre y la dirección generados en la tabla 'Escuela'.
        INSERT INTO Escuela (Nombre, domicilio)
        VALUES (@Nombre_Escuela, @Domicilio_Escuela);

        -- Incrementa la variable @i para pasar al siguiente número en la secuencia.
        SET @i = @i + 1;
    END
END;



-- 8. Crear un stored procedure para insertar un guía con autenticación de usuario desde la tabla USERID.
CREATE PROCEDURE INSERT_Guia
    @CodGuia INT,
    @Apellido VARCHAR(150),
    @Nombre VARCHAR(150),
    @UserID CHAR(25),
    @Password CHAR(25)
AS
BEGIN
    -- Verifica si existe un usuario con el UserID y Password proporcionados
    IF EXISTS (SELECT TOP 1 * FROM USERID WHERE UserID = @UserID AND Password = @Password)
    BEGIN
        -- Si el usuario es válido, inserta un nuevo guía en la tabla 'guia'
        INSERT INTO guia (idguia, nombre, apellido)
        VALUES (@CodGuia, @Nombre, @Apellido);
    END
    ELSE
    BEGIN
        -- Si el usuario no existe o las credenciales no son válidas, revierte la transacción
        ROLLBACK TRANSACTION;
    END
END;



-- 9. Crear un trigger para insertar datos en la tabla AUDITORIA si la cantidad de alumnos asistentes es mayor a 50
CREATE TRIGGER INSERT_ReservaVisita_Auditoria
ON Reserva_tipo_visita
FOR INSERT, UPDATE  -- Hacemos que el trigger se ejecute tanto para INSERT como para UPDATE
AS
BEGIN
    -- Verifica si la cantidad de alumnos reales es mayor a 50 en los registros insertados o actualizados
    IF EXISTS (SELECT TOP 1 * FROM inserted WHERE Cantidad_Alumnos_Reales > 50)
    BEGIN
        -- Inserta los datos en la tabla AUDITORIA si la condición es verdadera
        INSERT INTO AUDITORIA(Reserva_idReserva, Tipo_visitas_idTipo_visitas, Cantidad_Alumnos_Reales, Cantidad_alumnos_reservado, arancel_por_alumno, guia_idguia)
        SELECT Reserva_idReserva, Tipo_visitas_idTipo_visitas, Cantidad_Alumnos_Reales, Cantidad_alumnos_reservado, arancel_por_alumno, guia_idguia
        FROM inserted;  -- Se usa la tabla 'inserted', que contiene los registros recién insertados o actualizados
    END
END;


