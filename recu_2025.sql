CREATE TRIGGER TRG_Historia_DeptChange_corregido
ON Empleados
FOR UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Historia (EmpleadoId, DeptId)
    SELECT i.EmpleadoId, i.DeptiId
    FROM inserted i
    JOIN deleted d ON i.EmpleadoId = d.EmpleadoId
    WHERE ISNULL(i.DeptiId, -1) <> ISNULL(d.DeptiId, -1);
END;
GO


UPDATE EMPLEADOS
SET DeptiID=902 WHERE EmpleadoID=100
SELECT * FROM EMPLEADOS
SELECT * FROM HISTORIA
ORDER BY EmpleadoID
SELECT * FROM sys.triggers

DROP DATABASE TRABAJO