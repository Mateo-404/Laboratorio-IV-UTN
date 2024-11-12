# Ejercicios: Procedimientos Almacenados 

1. **Crear un procedimiento almacenado** que tenga como parámetro de entrada un número entero (Codigo_Guia) y devuelva la cantidad total de Alumnos Reales asignados a ese guía.
2. **Crear un procedimiento almacenado** para ingresar nuevas escuelas, que tenga como parámetros de entrada los valores de Código_Escuela, Nombre_Escuela, y Domicilio_Escuela.
3. **Crear un procedimiento almacenado** que liste los nombres de los guías con apellidos que comiencen con una cadena de texto determinada por un parámetro de entrada (con valor predeterminado es: comienza con A).

# Ejercicios: Triggers

4. **Crear un trigger** sobre la tabla escuela que en caso de que se borre una fila de ésta elimine las respectivas filas de la tabla telefono_escuela.
5. **Crear un trigger** que en caso de UPDATE del codigo_guia de la tabla Guia, haga el correspondiente update en la tabla reserva_visita.
6. **Crear un trigger** que en caso de inserción sobre la tabla telefono_escuela verifique la existencia del código de escuela correspondiente y en caso de no encontrarla no realice el proceso.

# Ejercicios: Procedimientos Almacenados y Triggers
7. **Crear un stored procedure** que realice una inserción de 26 escuelas en forma secuencial de la forma:
   - Nom_Escuela1 Dir_Escuela1
   - Nom_Escuela2 Dir_Escuela2
   - Nom_Escuela3 Dir_Escuela3
8. **Crear un stored procedure** que inserte valores en la tabla de Guía (Codigo_Guia, Apellido y Nombre) pero que además de estos parámetros requiera UserID (char) y Password (char). Estos dos parámetros deben ser validados (deben existir) en una tabla llamada USERID.
9. **Crear un trigger** en donde, si se insertan valores en la tabla Reserva_Visita, si la cantidad de alumnos asistentes es mayor a 50, inserte en una tabla llamada AUDITORIA los valores insertados.