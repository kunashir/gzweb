BEGIN
--[dvreport_get_data_{BC93C698-F770-495a-A066-D39B1D7023DE}]
/*DECLARE @reportIndex as int
SET @reportIndex = 5
DECLARE @datestart as datetime
SET @datestart = '2000-01-01'
DECLARE @dateend as datetime
SET @dateend = '2010-02-01'
DECLARE @author as uniqueidentifier
SET @author = '00000000-0000-0000-0000-000000000000'
DECLARE @department as uniqueidentifier
SET @department = '{E59B9635-6A89-46A5-9A7F-E9B6B962C8DD}'
DECLARE @currentState as bit
SET @currentState = 0
*/

DECLARE @result TABLE
(
AssignmentID uniqueidentifier,
ParentCardID uniqueidentifier,
ParentCardTypeID uniqueidentifier,
ParentCardRegNumber nvarchar(MAX),
ParentCardRegDate datetime,
ParentCardContent nvarchar(MAX),
AssignmentState int,
AssignmentContent nvarchar(MAX),
AssignmentDate datetime,
AssignmentTerm datetime,
AssignmentAuthor nvarchar(MAX),
AssignmentExecuter nvarchar(MAX),
AssignmentCompletionDate datetime
)


declare @units table(DepartmentID uniqueidentifier, Level int, RootDepartmentID uniqueidentifier)
insert into @units
execute dbo.GetDepartmentTree @department

	INSERT INTO @result
	SELECT 
	WFMainInfo.InstanceID,
	CAST(WFProperties.Value as uniqueidentifier),
	[dbo].[GetCardTypeByID](CAST(WFProperties.Value as uniqueidentifier)),
	[dbo].[GetDocumentRegNumb](CAST(WFProperties.Value as uniqueidentifier)),
	[dbo].[GetDocumentRegDate](CAST(WFProperties.Value as uniqueidentifier)),
	[dbo].[GetDocumentContent](CAST(WFProperties.Value as uniqueidentifier)),
	WFPerforming.TaskState,

	WFMainInfo.Comments, -- Name
	WFPerforming.ActualStartDate,
	WFMainInfo.ExpectedEndDate,
	--WFMainInfo.CreatedBy,
	authors.DisplayString,
	---WFPerformers.PerformerID,
	performers.DisplayString,
	WFPerforming.ActualEndDate
	FROM 
	[dvtable_{7213A125-2CA4-40EE-A671-B52850F45E7D}] as WFMainInfo
    LEFT JOIN [dvtable_{9D09144D-CAEC-4732-AD4D-EB6A3864714A}] as WFPerformers ON WFPerformers.InstanceID = WFMainInfo.InstanceID
    LEFT JOIN [dvtable_{D48E6155-C774-4205-AB70-7A67AB69DF22}] as WFPerforming ON WFPerforming.InstanceID = WFMainInfo.InstanceID 
    LEFT JOIN [dvtable_{E1ED3A9F-E462-463C-8F63-D1BBFC7DEDED}] as WFProperties ON WFProperties.InstanceID = WFMainInfo.InstanceID
    LEFT JOIN [dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as performers ON performers.RowID = WFPerformers.PerformerID
    LEFT JOIN [dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as authors ON authors.RowID = WFMainInfo.CreatedBy
    LEFT JOIN @units as Units ON Units.DepartmentID = performers.ParentRowID
    LEFT JOIN [dvsys_instances] as Instances ON Instances.InstanceID = WFMainInfo.InstanceID
	WHERE 
	WFProperties.Name = 'Карточка' AND WFProperties.Value is not null AND
	WFPerforming.TaskState is not null AND
    WFPerforming.ActualStartDate is not null AND
	--WFMainInfo.ExpectedEndDate is not null AND
	WFPerforming.TaskState <> 7 AND
	WFPerformers.PerformerID is not null AND
    Units.DepartmentID is not null AND
    WFMainInfo.CreatedBy is not null AND
	ISNULL(Instances.[Deleted], 0) = 0 AND
	(@author = '00000000-0000-0000-0000-000000000000' OR WFMainInfo.CreatedBy = @author) AND
	NOT EXISTS (SELECT * FROM @units as Units WHERE Units.DepartmentID = authors.ParentRowID) AND
(@showBarcodeTasks = 1 OR (WFMainInfo.[Comments] NOT LIKE N'%Подтвердите факт принятия следующих документов%' ESCAPE '#'))

IF @showNotifTasks = 0 
	BEGIN
		DELETE Tasks FROM @result as Tasks 
		WHERE EXISTS (SELECT * FROM [dvtable_{E1ED3A9F-E462-463C-8F63-D1BBFC7DEDED}] as Props 
		WHERE Props.InstanceID = Tasks.AssignmentID AND Props.Name = 'AssignmentType' AND (Props.Value = 2 OR Props.Value = 7))
	END	

DECLARE @overdueStart As datetime
DECLARE @overdueEnd As datetime

DECLARE @currentDate As datetime
SET @currentDate = GETDATE()

IF @datestart > @currentDate SET @overdueStart = @currentDate
ELSE SET @overdueStart = @datestart

IF @dateend > @currentDate SET @overdueEnd = @currentDate
ELSE SET @overdueEnd = @dateend


IF @reportIndex = 0
	BEGIN
		SELECT DISTINCT *, CASE WHEN AssignmentTerm < @overdueStart AND AssignmentTerm is not null THEN 1 ELSE 0 END as IsOverdue FROM @result WHERE 
		AssignmentDate < @datestart AND (AssignmentCompletionDate is null OR AssignmentCompletionDate >= @datestart)
	END
ELSE IF @reportIndex = 1
	BEGIN
		SELECT DISTINCT *, 1 as IsOverdue FROM @result WHERE 
		AssignmentDate < @datestart AND (AssignmentCompletionDate is null OR AssignmentCompletionDate >= @datestart) AND AssignmentTerm < @overdueStart AND AssignmentTerm is not null
	END
ELSE IF @reportIndex = 2
	BEGIN
		SELECT DISTINCT *, 0 as IsOverdue FROM @result WHERE 
		AssignmentDate >= @datestart AND AssignmentDate <= @dateend
	END
ELSE IF @reportIndex = 3
	BEGIN
		SELECT DISTINCT *, CASE WHEN AssignmentCompletionDate > AssignmentTerm AND AssignmentTerm is not null THEN 1 ELSE 0 END as IsOverdue FROM @result WHERE 
		AssignmentCompletionDate is not null AND AssignmentCompletionDate >= @datestart AND AssignmentCompletionDate <= @dateend
	END
ELSE IF @reportIndex = 4
	BEGIN
		SELECT DISTINCT *, 1 as IsOverdue FROM @result WHERE 
		AssignmentCompletionDate is not null AND AssignmentCompletionDate >= @datestart AND AssignmentCompletionDate <= @dateend AND AssignmentCompletionDate > AssignmentTerm AND AssignmentTerm is not null
	END
ELSE IF @reportIndex = 5
	BEGIN
		IF @currentState = 1 
			BEGIN
				SELECT DISTINCT *, CASE WHEN AssignmentTerm < @currentDate AND AssignmentTerm is not null THEN 1 ELSE 0 END as IsOverdue FROM @result WHERE 
				AssignmentDate <= @currentDate AND (AssignmentCompletionDate is null OR AssignmentCompletionDate > @currentDate)
			END
		ELSE
			BEGIN
				SELECT DISTINCT *, CASE WHEN AssignmentTerm < @overdueEnd AND AssignmentTerm is not null THEN 1 ELSE 0 END as IsOverdue FROM @result WHERE 
				AssignmentDate <= @dateend AND (AssignmentCompletionDate is null OR AssignmentCompletionDate > @dateend) 
			END
	END
ELSE IF @reportIndex = 6
	BEGIN
		IF @currentState = 1 
			BEGIN
				SELECT DISTINCT *, 1 as IsOverdue FROM @result WHERE 
				AssignmentDate <= @currentDate AND (AssignmentCompletionDate is null OR AssignmentCompletionDate > @currentDate) AND AssignmentTerm < @currentDate AND AssignmentTerm is not null
			END
		ELSE
			BEGIN
				SELECT DISTINCT *, 1 as IsOverdue FROM @result WHERE 
				AssignmentDate <= @dateend AND (AssignmentCompletionDate is null OR AssignmentCompletionDate > @dateend) AND AssignmentTerm < @overdueEnd AND AssignmentTerm is not null
			END		
	END
END