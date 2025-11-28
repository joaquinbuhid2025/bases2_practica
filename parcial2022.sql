SELECT p.Nombre,p.Apellido, c.ClinicaDesc, ISNULL(pr.ProvinciaDesc,'"'),m.MedDesc
FROM DISPENSAS d
INNER JOIN PACIENTES p ON p.PacienteID=d.PacienteID
INNER JOIN CLINICAS c ON c.ClinicaID=d.ClinicaID
--Acá es LEFT por que hay una clinica cuya provincia no esta registrada
LEFT JOIN PROVINCIAS pr ON c.ProvinciaID=pr.ProvinciaID
INNER JOIN MEDICAMENTOS m ON m.MedID=d.MedID
WHERE m.MedMonodroga='BISOPROLOL'
