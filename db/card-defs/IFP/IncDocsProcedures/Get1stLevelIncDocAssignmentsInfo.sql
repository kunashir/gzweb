BEGIN

DECLARE @FirstLevelTasks TABLE (InstanceID uniqueidentifier)

INSERT INTO @FirstLevelTasks
SELECT AssignmentMainInfo.InstanceID FROM 
(SELECT AssignmentHistory.TaskID 
FROM [dvtable_{AD95E7FB-592C-4CAA-BBDF-25F32F0B2987}] as IncDocResolutions WITH(NOLOCK),
[dvtable_{86AF6157-D65A-4F8D-8F92-3DAAD2910A9B}] as AssignmentHistory WITH(NOLOCK)
WHERE IncDocResolutions.InstanceID = @cardID AND
IncDocResolutions.ResolutionID = AssignmentHistory.InstanceID) as ZeroLevelTasks,
[dvtable_{E3335F61-DBD9-447B-A539-4BF721FFD7B0}] as AssignmentMainInfo WITH(NOLOCK)
WHERE AssignmentMainInfo.ParentTaskID = ZeroLevelTasks.TaskID


DECLARE @incDocAssignments TABLE
(InstanceID uniqueidentifier,
Assignee uniqueidentifier,
DisplayString nvarchar(MAX),
AuthorID uniqueidentifier,
Author nvarchar(MAX),
Content nvarchar(MAX),
State int)

INSERT INTO @incDocAssignments
SELECT
AssignmentMainInfo.InstanceID,
Assignees.Assignee,
Employees.DisplayString,
AssignmentMainInfo.Author,
null,
AssignmentMainInfo.Content,
AssignmentMainInfo.State
FROM @FirstLevelTasks as tasks,
[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as Employees WITH(NOLOCK),
[dvtable_{E3335F61-DBD9-447B-A539-4BF721FFD7B0}] as AssignmentMainInfo WITH(NOLOCK),
[dvtable_{80314B8B-4825-4205-9FE7-F6B294DA9113}] as Assignees WITH(NOLOCK)
WHERE AssignmentMainInfo.InstanceID = tasks.InstanceID AND
Assignees.InstanceID = AssignmentMainInfo.InstanceID AND
Employees.RowID = Assignees.Assignee

SELECT 
Assignments.InstanceID,
Assignments.Assignee,
Assignments.DisplayString,
Assignments.AuthorID,
Employees.DisplayString as Author,
Assignments.Content,
Assignments.State,
AssignmentHistory.Comment,
AssignmentHistory.Date
FROM @incDocAssignments as Assignments
LEFT JOIN [dvtable_{86AF6157-D65A-4F8D-8F92-3DAAD2910A9B}] as AssignmentHistory WITH(NOLOCK) ON AssignmentHistory.InstanceID = Assignments.InstanceID 
LEFT JOIN [dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as Employees WITH(NOLOCK) ON Employees.RowID = Assignments.AuthorID

END