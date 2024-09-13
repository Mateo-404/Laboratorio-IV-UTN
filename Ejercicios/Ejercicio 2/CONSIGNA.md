# EJERCICIOS GUIA 2
## INDICES Y ASIGNACION DE PERMISOS

1. Crear un índice no agrupado para la tabla `Reserva` sobre el campo `codigo_escuela`.

2. Eliminar el índice creado en el punto anterior.

3. Crear un índice que optimice la búsqueda y ordenamiento de la tabla `reserva_visita`, si la consulta que se quisiera optimizar es por `Cantidad de Alumnos Reservados`.

4. Crear un nuevo índice agrupado sobre la tabla `Guia` sobre los campos `Apellido` y `Nombre`.

5. Crear un índice que optimice la búsqueda por `Fecha` y `Hora` de la reserva (índice compuesto) teniendo en cuenta que se realizan inserciones con mucha asiduidad sobre esta tabla (FILLFACTOR).

6. Conceder permiso de `INSERT` y `UPDATE` sobre la tabla `telefono_escuela` a los usuarios `jPerez`, `aFernandez`.

7. Eliminar los permisos de `UPDATE` sobre la tabla `telefono_escuela` para todos los usuarios.

8. Conceder permisos de `CREATE TABLE` al usuario `jPerez`.

9. Revocar los permisos de `SELECT` para el usuario `public` sobre la tabla de `Escuelas`.

10. Eliminar el índice sobre `Nombre` y `Apellido` en la tabla `Guia`.

11. Crear un índice que impida ingresar dos guías con igual `Nombre` y `Apellido`.

12. Conceder al grupo `CORDOBA` permiso de `SELECT` para la tabla `reserva_visita`.

13. El usuario `jPerez` (parte del grupo `CORDOBA`) no debe poder ver el campo `Arancel_por_Alumno` (pero sí el resto de la tabla). ¿Cómo se le deniega el permiso?

14. Conceder al grupo `ADM` todos los permisos aplicables sobre la base `Jurasik_Park` (creación de tablas, backup, etc).

15. Denegar al usuario `aFernandez` (miembro del grupo `ADM`) el permiso para realizar backups sobre la base y sobre el log de transacciones.
