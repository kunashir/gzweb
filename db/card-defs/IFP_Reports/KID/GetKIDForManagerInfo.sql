BEGIN
--[dvreport_get_data_{968F24DB-AB52-47CE-83C0-72DDB130A5C1}]
-- ??????????? ? ???????
declare @rootDepartments table(DepartmentID uniqueidentifier)
insert into @rootDepartments
select CONVERT(uniqueidentifier, Department.Items) from [dbo].[idocfn_split_string](@departments,';') as Department
where Department.Items is not null AND Department.Items != ''

-- ??????????? ? ???????
declare @executerstable table(PerformerID uniqueidentifier)
insert into @executerstable
select CONVERT(uniqueidentifier, Executer.Items) from [dbo].[idocfn_split_string](@executers,';') as Executer
where Executer.Items is not null AND Executer.Items != ''

DECLARE @executersCount as int
SET @executersCount = (SELECT COUNT(*) FROM @executerstable)
--print(@executersCount)

-- ?????? ?????? ???? ????????????? ?? ???????? (??? ????????)
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
--DepartmentID uniqueidentifier
DepartmentName nvarchar(max),
DepartmentLevel int,
EmployeeID uniqueidentifier,
EmployeeName nvarchar(max),
IsManager bit
)

INSERT INTO @performers
SELECT 
--Departments.RowID,
Departments.Name,
Units.Level,
Employees.RowID,
Employees.DisplayString,
CASE WHEN Departments.Manager = Employees.RowID THEN 1 ELSE 0 END as IsManager
FROM 
@units as Units,
[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as Employees,
[dvtable_{7473F07F-11ED-4762-9F1E-7FF10808DDD1}] as Departments
WHERE
Employees.ParentRowID = Units.DepartmentID AND
Departments.RowID = Units.DepartmentID
ORDER BY RootDepartmentID, [Level] ASC, IsManager DESC

-- ??????? ??? ??????????? ?? @performers, ??????? ?? ??????? ? @executerstable ???? @executerstable ?? ?????
IF @executersCount > 0 
	BEGIN
		DELETE PERFORMERS FROM @performers AS PERFORMERS WHERE
		NOT EXISTS (SELECT * FROM @executerstable AS EXECUTERS WHERE EXECUTERS.PerformerID = PERFORMERS.EmployeeID)
	END

--SELECT * FROM @performers

DECLARE @result TABLE
(
InstanceID uniqueidentifier,
CreatedAt datetime,
Term datetime,
CompletedAt datetime,
Performer uniqueidentifier
)

INSERT INTO @result
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
@units as Units
WHERE
Properties.InstanceID = MainInfo.InstanceID AND
Instances.InstanceID = MainInfo.InstanceID AND
MainInfo.InstanceID = Performing.InstanceID AND
MainInfo.InstanceID = Performers.InstanceID AND
Performing.ActualStartDate is not null AND
--MainInfo.ExpectedEndDate is not null AND
Performing.TaskState <> 7 AND
(@author = '00000000-0000-0000-0000-000000000000' OR MainInfo.CreatedBy = @author) AND
--Performing.ActualStartDate <= @dateend AND
Performers.PerformerID = Employees.RowID AND
Employees.ParentRowID = Units.DepartmentID AND
Properties.Name = 'Карточка' AND Properties.Value is not null AND
ISNULL(Instances.[Deleted], 0) = 0 AND
(@showBarcodeTasks = 1 OR (MainInfo.[Comments] NOT LIKE N'%Подтвердите факт принятия следующих документов%' ESCAPE '#'))


IF @showNotifTasks = 0 
	BEGIN
		DELETE Tasks FROM @result as Tasks 
		WHERE EXISTS (SELECT * FROM [dvtable_{E1ED3A9F-E462-463C-8F63-D1BBFC7DEDED}] as Props WHERE Props.InstanceID = Tasks.InstanceID AND Props.Name = 'AssignmentType' AND (Props.Value = 2 OR Props.Value = 7))
	END	


DECLARE @currentDate As datetime
SET @currentDate = GETDATE()

IF @currentstate = 1
	BEGIN
		SELECT 
		Performers.EmployeeID,
		Performers.EmployeeName,
		Performers.DepartmentName,
		0 as OnExecutionAtStart,
		0 as OnExecutionAtStartOverdue,
		0 as Issued,
		0 as Completed,
		0 as CompletedOverdue,
		(SELECT COUNT(*) FROM @result as Result WHERE CreatedAt <= @currentDate AND (CompletedAt is null OR CompletedAt > @currentDate) AND EmployeeID = Performer) as OnExecutionAtEnd,
		(SELECT COUNT(*) FROM @result as Result WHERE CreatedAt <= @currentDate AND (CompletedAt is null OR CompletedAt > @currentDate) AND EmployeeID = Performer AND Term < @currentDate AND Term is not null) as OnExecutionAtEndOverdue
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

		SELECT 
		Performers.EmployeeID,
		Performers.EmployeeName,
		Performers.DepartmentName,
		(SELECT COUNT(*) FROM @result as Result WHERE CreatedAt < @datestart AND (CompletedAt is null OR CompletedAt >= @datestart) AND EmployeeID = Performer) as OnExecutionAtStart,
		(SELECT COUNT(*) FROM @result as Result WHERE CreatedAt < @datestart AND (CompletedAt is null OR CompletedAt >= @datestart) AND EmployeeID = Performer AND Term < @overdueStart AND Term is not null) as OnExecutionAtStartOverdue,
		(SELECT COUNT(*) FROM @result as Result WHERE CreatedAt >= @datestart AND CreatedAt <= @dateend AND EmployeeID = Performer) as Issued,
		(SELECT COUNT(*) FROM @result as Result WHERE CompletedAt is not null AND CompletedAt >= @datestart AND CompletedAt <= @dateend AND EmployeeID = Performer) as Completed,
		(SELECT COUNT(*) FROM @result as Result WHERE CompletedAt is not null AND CompletedAt >= @datestart AND CompletedAt <= @dateend AND EmployeeID = Performer AND CompletedAt > Term AND Term is not null) as CompletedOverdue,
		(SELECT COUNT(*) FROM @result as Result WHERE CreatedAt <= @dateend AND (CompletedAt is null OR CompletedAt > @dateend) AND EmployeeID = Performer) as OnExecutionAtEnd,
		(SELECT COUNT(*) FROM @result as Result WHERE CreatedAt <= @dateend AND (CompletedAt is null OR CompletedAt > @dateend) AND EmployeeID = Performer AND Term < @overdueEnd AND Term is not null) as OnExecutionAtEndOverdue
		FROM @performers AS Performers
	END
END