BEGIN

SELECT 
maininfo.InstanceID,
RegistrationDate,
tasks.ActualStartDate as ApprovingStartsAt,
tasks.ActualEndDate as ApprovingEndsAt,
HistoryKind as ApprovingDecision,
null as ApproverDepartment,
employees.CalendarID as ApproverCalendarID
FROM 
[dvtable_{DAA76B4A-98F9-44BA-833C-DD874DB33214}] as maininfo,
[dvtable_{E79A6914-9A7A-467C-93CB-5A2F30BB5C52}] as approvalHistory,
[dvtable_{7473F07F-11ED-4762-9F1E-7FF10808DDD1}] as departments,
[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as employees,
[dvtable_{D48E6155-C774-4205-AB70-7A67AB69DF22}] as tasks,
dvsys_instances as instances
WHERE
instances.InstanceID = maininfo.InstanceID AND
ISNULL(instances.[Deleted], 0) = 0 AND
State is not null AND
maininfo.InstanceID = approvalHistory.InstanceID AND
approvalHistory.HistoryKind is not null AND
approvalHistory.Task is not null AND
tasks.InstanceID = approvalHistory.Task AND
tasks.ActualStartDate is not null AND
Person is not null AND
employees.RowID = Person AND
(@counteragent = '00000000-0000-0000-0000-000000000000' OR @counteragent = Counteragent)
ORDER BY RegistrationDate DESC, maininfo.InstanceID
END
