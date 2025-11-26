-- 1.	Indique la sentencia SQL del procedimiento almacenado que permita obtener
-- los nombres y apellidos de los empleados que trabajaron en algún momento
-- (en su historia en la empresa) en el departamento que se ingresa como
-- parámetro. Mostrar cada empleado una sola vez. (2,5 ptos)

CREATE PROCEDURE empleados_por_departamento(@DeptID INT)
AS
BEGIN
SELECT DISTINCT e.Nombre, e.Apellido FROM EMPLEADOS e
INNER JOIN HISTORIA h ON e.EmpleadoID=h.EmpleadoID
WHERE h.DeptID=@DeptID
END

-- 2.	Indique la sentencia SQL para obtener los nombres y apellidos de los
-- empleados que han trabajado en todos los departamentos de la empresa. (2,5 ptos)
SELECT e.Nombre, e.Apellido FROM EMPLEADOS e
WHERE NOT EXISTS(
	SELECT 1 FROM DEPARTAMENTOS d
	WHERE NOT EXISTS(
		SELECT 1 FROM HISTORIA h
		WHERE h.EmpleadoID=e.EmpleadoID
		AND d.DeptID=h.DeptID
	)
)

-- 4.	Si al momento de insertar un nuevo empleado no se puede definir el campo EmpleadoId como
-- Identity por requerimientos funcionales. ¿Qué problema se podría dar al querer consultar del
-- último EmpleadoId + 1 antes dar de alta el nuevo medicamento? ¿Qué tipo de bloqueo debería utilizar
-- para transaccionar la consulta del último EmpleadoId + 1 y dar de alta del nuevo empleado?
-- Indique el código SQL para realizarlo. (2,5 ptos)
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
BEGIN TRANSACTION
	DECLARE @EmpleadoID INT
	BEGIN TRY
		SELECT @EmpleadoID=ISNULL(MAX(EmpleadoID),0) + 1  FROM EMPLEADOS
		INSERT INTO EMPLEADOS values(@EmpleadoID,'Joaquin','Buhid',50,124,120000)
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE()
		ROLLBACK TRANSACTION
	END CATCH
