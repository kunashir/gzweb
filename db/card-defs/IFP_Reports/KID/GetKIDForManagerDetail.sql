BEGIN
--[dvreport_get_data_{77BA5F1F-C975-4DD2-83EA-A1D1A29692A5}]

/*DECLARE @reportIndex as int
SET @reportIndex = 3
DECLARE @datestart as datetime
SET @datestart = '2010-01-01'
DECLARE @dateend as datetime
SET @dateend = '2010-02-01'
DECLARE @author as uniqueidentifier
SET @author = '00000000-0000-0000-0000-000000000000'
DECLARE @executer as uniqueidentifier
SET @executer = '409B43F4-BB6B-4AB9-A102-7FB50C0C22B3'
DECLARE @currentState as bit
SET @currentState = 0*/


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
    LEFT JOIN [dvsys_instances] as Instances ON Instances.InstanceID = WFMainInfo.InstanceID
	WHERE 
	WFProperties.Name = 'Карточка' AND WFProperties.Value is not null AND
	WFPerforming.TaskState is not null AND
    WFPerforming.ActualStartDate is not null AND
	--WFMainInfo.ExpectedEndDate is not null AND
	WFPerforming.TaskState <> 7 AND
    WFPerformers.PerformerID = @executer AND
    WFMainInfo.CreatedBy is not null AND
	ISNULL(Instances.[Deleted], 0) = 0 AND
	(@author = '00000000-0000-0000-0000-000000000000' OR WFMainInfo.CreatedBy = @author) AND
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
