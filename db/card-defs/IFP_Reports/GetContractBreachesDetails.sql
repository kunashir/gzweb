BEGIN
SELECT 
maininfo.InstanceID,
RegistrationNumber,
RegistrationDate,
(SELECT TOP(1) Comments 
 FROM [dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as executers
 WHERE executers.RowID = maininfo.Responsible) as UnitPerformer,
--departments.Comments as UnitPerformer,
maininfo.Description as ContractSubject,
counteragents.Name as Counteragent,
tasks.ActualStartDate as ApprovingStartsAt,
tasks.ActualEndDate as ApprovingEndsAt,
HistoryKind as ApprovingDecision,
CurrentPerformers.PerformerID as ApproverID,
[dbo].GetContractCurrentOwner(maininfo.InstanceID) as CurrentEmployee,
(SELECT TOP(1) Comments 
 FROM [dvtable_{7473F07F-11ED-4762-9F1E-7FF10808DDD1}] as deps 
 WHERE deps.RowID = employees.ParentRowID) as ApproverDepartment,
employees.CalendarID as ApproverCalendarID,
State,
maininfo.DocKind as ContractType,
'' as ContractKindString,
employees.LastName + ' '
 + CASE WHEN employees.FirstName IS NULL THEN '' ELSE LEFT(employees.FirstName,1) + '.' END 
 + CASE WHEN employees.MiddleName IS NULL THEN '' ELSE LEFT(employees.MiddleName,1) + '.' END as ApproverName
FROM [dvtable_{DAA76B4A-98F9-44BA-833C-DD874DB33214}] as maininfo,
[dvtable_{E79A6914-9A7A-467C-93CB-5A2F30BB5C52}] as approvalHistory,
[dvtable_{C78ABDED-DB1C-4217-AE0D-51A400546923}] as counteragents,
[dvtable_{7473F07F-11ED-4762-9F1E-7FF10808DDD1}] as departments,
[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as employees,
[dvtable_{D48E6155-C774-4205-AB70-7A67AB69DF22}] as tasks,
[dvtable_{9D09144D-CAEC-4732-AD4D-EB6A3864714A}] as CurrentPerformers,
dvsys_instances as instances
WHERE
instances.InstanceID = maininfo.InstanceID AND
ISNULL(instances.[Deleted], 0) = 0 AND
State is not null AND
--maininfo.State not in (11,12,13,14) AND -- not active, performed, recalled and rejected
maininfo.InstanceID = approvalHistory.InstanceID AND
approvalHistory.HistoryKind is not null AND
approvalHistory.Task is not null AND
tasks.InstanceID = approvalHistory.Task AND
tasks.ActualStartDate is not null AND
counteragents.RowID = Counteragent AND
CurrentPerformers.InstanceID = tasks.InstanceID AND
CurrentPerformers.DeputyFor is null AND CurrentPerformers.PerformerID is not null AND
Person is not null AND
employees.RowID = CurrentPerformers.PerformerID AND
((@currentState = 1 AND maininfo.State not in (11,13)) OR (@currentState = 0 AND 
RegistrationDate >= @dateStart AND RegistrationDate <= @dateEnd))
ORDER BY RegistrationDate DESC, maininfo.InstanceID
END
