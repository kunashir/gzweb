BEGIN
/*DECLARE @departments As nvarchar(max)
SET @departments = '{E59B9635-6A89-46A5-9A7F-E9B6B962C8DD};{13F8C643-6C1C-456C-9BCC-3631C14787E2}'
DECLARE @currentstate As bit
SET @currentstate = 0
DECLARE @author As uniqueidentifier
SET @author = '00000000-0000-0000-0000-000000000000'
DECLARE @datestart As datetime
SET @datestart = '2000-01-01 00:00:00'
DECLARE @dateend As datetime
SET @dateend = '2010-02-01 00:00:00'*/

declare @rootDepartments table(DepartmentID uniqueidentifier)
insert into @rootDepartments
select CONVERT(uniqueidentifier, Department.Items) from [dbo].[idocfn_split_string](@departments,';') as Department
where Department.Items is not null AND Department.Items != ''

declare @units table(DepartmentID uniqueidentifier, Level int, RootDepartmentID uniqueidentifier)
declare @Counter int       
select @Counter = COUNT(*) from  @rootDepartments
declare @item uniqueidentifier
	while @Counter !=0         
	begin         
		select @item = DepartmentID from @rootDepartments 
		delete from @rootDepartments where DepartmentID = @item
		insert into @units
		execute dbo.GetDepartmentTree @item
		SET @Counter = @Counter - 1
	end 
declare @performers table
(
DepartmentID uniqueidentifier,
RootDepartmentID uniqueidentifier,
DepartmentLevel int,
EmployeeID uniqueidentifier
)

INSERT INTO @performers
SELECT 
Departments.RowID,
Units.RootDepartmentID,
Units.Level,
Employees.RowID
FROM 
@units as Units,
[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as Employees,
[dvtable_{7473F07F-11ED-4762-9F1E-7FF10808DDD1}] as Departments
WHERE
Employees.ParentRowID = Units.DepartmentID AND
Departments.RowID = Units.DepartmentID


DECLARE @wftasks TABLE
(
InstanceID uniqueidentifier,
CreatedAt datetime,
Term datetime,
CompletedAt datetime,
Performer uniqueidentifier
)

INSERT INTO @wftasks
SELECT DISTINCT 
MainInfo.InstanceID,
Performing.ActualStartDate,
MainInfo.ExpectedEndDate,
Performing.ActualEndDate,
Performers.PerformerID 
FROM
[dvtable_{7213A125-2CA4-40EE-A671-B52850F45E7D}] as MainInfo,
[dvtable_{D48E6155-C774-4205-AB70-7A67AB69DF22}] as Performing,
[dvtable_{9D09144D-CAEC-4732-AD4D-EB6A3864714A}] as Performers,
[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as Employees,
[dvtable_{E1ED3A9F-E462-463C-8F63-D1BBFC7DEDED}] as Properties,
dvsys_instances as Instances,
@performers as Units
WHERE
Properties.InstanceID = MainInfo.InstanceID AND
Instances.InstanceID = MainInfo.InstanceID AND
MainInfo.InstanceID = Performing.InstanceID AND
MainInfo.InstanceID = Performers.InstanceID AND
Performing.ActualStartDate is not null AND
--MainInfo.ExpectedEndDate is not null AND -- показываем и те, что без срока
Performing.TaskState <> 7 AND
(@author = '00000000-0000-0000-0000-000000000000' OR MainInfo.CreatedBy = @author) AND
--Performing.ActualStartDate <= @dateend AND
Performers.PerformerID = Employees.RowID AND
Employees.ParentRowID = Units.DepartmentID AND
Properties.Name = 'Карточка' AND Properties.Value is not null AND
ISNULL(Instances.[Deleted], 0) = 0 AND
--надо отсеить внутрениие поручения:
NOT EXISTS(SELECT * FROM @performers as Perfs WHERE Perfs.EmployeeID = MainInfo.CreatedBy AND Perfs.RootDepartmentID = Units.RootDepartmentID)AND
(@showBarcodeTasks = 1 OR (MainInfo.[Comments] NOT LIKE N'%Подтвердите факт принятия следующих документов%' ESCAPE '#'))

IF @showNotifTasks = 0 
	BEGIN
		DELETE Tasks FROM @wftasks as Tasks 
		WHERE EXISTS (SELECT * FROM [dvtable_{E1ED3A9F-E462-463C-8F63-D1BBFC7DEDED}] as Props WHERE Props.InstanceID = Tasks.InstanceID AND Props.Name = 'AssignmentType' AND (Props.Value = 2 OR Props.Value = 7))
	END	

DECLARE @result TABLE
(
RootDepartmentID uniqueidentifier,
OnExecutionAtStart int,
OnExecutionAtStartOverdue int,
Issued int,
Completed int,
CompletedOverdue int,
OnExecutionAtEnd int,
OnExecutionAtEndOverdue int
)

DECLARE @currentDate As datetime
SET @currentDate = GETDATE()

IF @currentstate = 1
	BEGIN
		INSERT INTO @result
		SELECT 
		Performers.RootDepartmentID,
		0 as OnExecutionAtStart,
		0 as OnExecutionAtStartOverdue,
		0 as Issued,
		0 as Completed,
		0 as CompletedOverdue,
		(SELECT COUNT(*) FROM @wftasks as Result WHERE CreatedAt <= @currentDate AND (CompletedAt is null OR CompletedAt > @currentDate) AND EmployeeID = Performer) as OnExecutionAtEnd,
		(SELECT COUNT(*) FROM @wftasks as Result WHERE CreatedAt <= @currentDate AND (CompletedAt is null OR CompletedAt > @currentDate) AND EmployeeID = Performer AND Term is not null AND Term < @currentDate) as OnExecutionAtEndOverdue
		FROM @performers AS Performers
	END
ELSE
	BEGIN
		DECLARE @overdueStart As datetime
		DECLARE @overdueEnd As datetime

		IF @datestart > @currentDate SET @overdueStart = @currentDate
		ELSE SET @overdueStart = @datestart

		IF @dateend > @currentDate SET @overdueEnd = @currentDate
		ELSE SET @overdueEnd = @dateend

		INSERT INTO @result
		SELECT 
		Performers.RootDepartmentID,
		(SELECT COUNT(*) FROM @wftasks as Result WHERE CreatedAt < @datestart AND (CompletedAt is null OR CompletedAt >= @datestart) AND EmployeeID = Performer) as OnExecutionAtStart,
		(SELECT COUNT(*) FROM @wftasks as Result WHERE CreatedAt < @datestart AND (CompletedAt is null OR CompletedAt >= @datestart) AND EmployeeID = Performer AND Term is not null AND Term < @overdueStart) as OnExecutionAtStartOverdue,
		(SELECT COUNT(*) FROM @wftasks as Result WHERE CreatedAt >= @datestart AND CreatedAt <= @dateend AND EmployeeID = Performer) as Issued,
		(SELECT COUNT(*) FROM @wftasks as Result WHERE CompletedAt is not null AND CompletedAt >= @datestart AND CompletedAt <= @dateend AND EmployeeID = Performer) as Completed,
		(SELECT COUNT(*) FROM @wftasks as Result WHERE CompletedAt is not null AND CompletedAt >= @datestart AND CompletedAt <= @dateend AND EmployeeID = Performer AND CompletedAt > Term AND Term is not null) as CompletedOverdue,
		(SELECT COUNT(*) FROM @wftasks as Result WHERE CreatedAt <= @dateend AND (CompletedAt is null OR CompletedAt > @dateend) AND EmployeeID = Performer) as OnExecutionAtEnd,
		(SELECT COUNT(*) FROM @wftasks as Result WHERE CreatedAt <= @dateend AND (CompletedAt is null OR CompletedAt > @dateend) AND EmployeeID = Performer AND Term < @overdueEnd AND Term is not null) as OnExecutionAtEndOverdue
		FROM @performers AS Performers
	END

--DECLARE @departmentName as nvarchar(max)
--SET @departmentName = 


SELECT 
(SELECT TOP(1) [Name] 
 From [dvtable_{7473F07F-11ED-4762-9F1E-7FF10808DDD1}] as Units 
 WHERE Units.RowID = RootDepartmentID) as DepartmentName,
RootDepartmentID as DepartmentID,
COUNT(*) as EmployeesCount,
SUM(OnExecutionAtStart) as OnExecutionAtStart,
SUM(OnExecutionAtStartOverdue) as OnExecutionAtStartOverdue,
SUM(Issued) as Issued,
SUM(Completed) as Completed,
SUM(CompletedOverdue) as CompletedOverdue,
SUM(OnExecutionAtEnd) as OnExecutionAtEnd,
SUM(OnExecutionAtEndOverdue) as OnExecutionAtEndOverdue
FROM @result As Result 
GROUP BY RootDepartmentID
END
