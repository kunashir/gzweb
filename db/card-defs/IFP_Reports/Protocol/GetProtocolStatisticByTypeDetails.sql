BEGIN

	IF @chairman = '{00000000-0000-0000-0000-000000000000}'
	BEGIN
		SET @chairman = NULL
	END
	
	IF @secretary = '{00000000-0000-0000-0000-000000000000}'
	BEGIN
		SET @secretary = NULL
	END

	declare @currentDate datetime
	SET @currentDate = GETDATE()

	IF @index = 0/*CountAll*/
	BEGIN
		select distinct 
		MainInfo.InstanceID as ID,
		MainInfo.RegistrationNumber as RegistrationNumber, MainInfo.RegisterDate as RegisterDate, 
		(select Boards.ProtocolTypeName from [dbo].[dvtable_{8D68EE46-400E-4119-9D41-F2DBCA83ECE0}] as Boards where Boards.RowID = MainInfo.BoardType) as Board, 
		(select Employees.DisplayString from [dbo].[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as Employees where Employees.RowID = MainInfo.Registrator) as Registrator, 
		(select Employees.DisplayString from [dbo].[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as Employees where Employees.RowID = MainInfo.Chairman) as Chairman, 
		(select Employees.DisplayString from [dbo].[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as Employees where Employees.RowID = MainInfo.Secretary) as Secretary
		from [dbo].[dvtable_{C00F1798-2E00-4493-801A-8A3BC4737FB2}] as MainInfo
		where MainInfo.BoardType = @boardId AND MainInfo.RegisterDate >= @datestart AND MainInfo.RegisterDate <= @dateend AND (@chairman is NULL OR MainInfo.Chairman = @chairman) AND (@secretary is NULL OR MainInfo.Secretary = @secretary)
	END
	ELSE IF @index = 1/*CountExecuteAll*/
	BEGIN
		select distinct 
		MainInfo.InstanceID as ID,
		MainInfo.RegistrationNumber as RegistrationNumber, MainInfo.RegisterDate as RegisterDate, 
		(select Boards.ProtocolTypeName from [dbo].[dvtable_{8D68EE46-400E-4119-9D41-F2DBCA83ECE0}] as Boards where Boards.RowID = MainInfo.BoardType) as Board, 
		(select Employees.DisplayString from [dbo].[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as Employees where Employees.RowID = MainInfo.Registrator) as Registrator, 
		(select Employees.DisplayString from [dbo].[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as Employees where Employees.RowID = MainInfo.Chairman) as Chairman, 
		(select Employees.DisplayString from [dbo].[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as Employees where Employees.RowID = MainInfo.Secretary) as Secretary
		from [dbo].[dvtable_{C00F1798-2E00-4493-801A-8A3BC4737FB2}] as MainInfo
		where MainInfo.BoardType = @boardId AND MainInfo.State = 3 AND MainInfo.RegisterDate >= @datestart AND MainInfo.RegisterDate <= @dateend AND (@chairman is NULL OR MainInfo.Chairman = @chairman) AND (@secretary is NULL OR MainInfo.Secretary = @secretary)
	END
	ELSE IF @index = 2/*CountExecutedOverdue*/
	BEGIN
		select distinct
		PMainInfo.InstanceID as ID,
		PMainInfo.RegistrationNumber as RegistrationNumber, PMainInfo.RegisterDate as RegisterDate, 
		(select Boards.ProtocolTypeName from [dbo].[dvtable_{8D68EE46-400E-4119-9D41-F2DBCA83ECE0}] as Boards where Boards.RowID = PMainInfo.BoardType) as Board, 
		(select Employees.DisplayString from [dbo].[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as Employees where Employees.RowID = PMainInfo.Registrator) as Registrator, 
		(select Employees.DisplayString from [dbo].[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as Employees where Employees.RowID = PMainInfo.Chairman) as Chairman, 
		(select Employees.DisplayString from [dbo].[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as Employees where Employees.RowID = PMainInfo.Secretary) as Secretary
		from 
		[dbo].[dvtable_{C00F1798-2E00-4493-801A-8A3BC4737FB2}] as PMainInfo
		LEFT JOIN [dbo].[dvtable_{6E71A21C-FA5B-4218-8A17-1F47AEBA4CD5}] as PAssignments ON PMainInfo.InstanceID = PAssignments.InstanceID
		LEFT JOIN [dbo].[dvtable_{E3335F61-DBD9-447B-A539-4BF721FFD7B0}] as AMainInfo ON PAssignments.AssignmentID = AMainInfo.InstanceID and AMainInfo.Type = 1
		LEFT JOIN [dbo].[dvtable_{86AF6157-D65A-4F8D-8F92-3DAAD2910A9B}] as AHistory ON AMainInfo.InstanceID = AHistory.InstanceID
		where PMainInfo.BoardType = @boardId AND PMainInfo.State = 3 AND PMainInfo.RegisterDate >= @datestart AND PMainInfo.RegisterDate <= @dateend AND 
			  (@chairman is NULL OR PMainInfo.Chairman = @chairman) AND (@secretary is NULL OR PMainInfo.Secretary = @secretary) AND
			  ((AHistory.Decision = 6 and AMainInfo.Deadline is not null and AHistory.Date > AMainInfo.Deadline) or (AMainInfo.State <> 3 and AMainInfo.Deadline is not null and AMainInfo.Deadline < @currentDate))
	END
	ELSE IF @index = 3/*CountExecutingAll*/
	BEGIN
		select distinct
		MainInfo.InstanceID as ID,
		MainInfo.RegistrationNumber as RegistrationNumber, MainInfo.RegisterDate as RegisterDate, 
		(select Boards.ProtocolTypeName from [dbo].[dvtable_{8D68EE46-400E-4119-9D41-F2DBCA83ECE0}] as Boards where Boards.RowID = MainInfo.BoardType) as Board, 
		(select Employees.DisplayString from [dbo].[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as Employees where Employees.RowID = MainInfo.Registrator) as Registrator, 
		(select Employees.DisplayString from [dbo].[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as Employees where Employees.RowID = MainInfo.Chairman) as Chairman, 
		(select Employees.DisplayString from [dbo].[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as Employees where Employees.RowID = MainInfo.Secretary) as Secretary
		from [dbo].[dvtable_{C00F1798-2E00-4493-801A-8A3BC4737FB2}] as MainInfo
		where MainInfo.BoardType = @boardId AND MainInfo.State = 10 AND MainInfo.RegisterDate >= @datestart AND MainInfo.RegisterDate <= @dateend AND (@chairman is NULL OR MainInfo.Chairman = @chairman) AND (@secretary is NULL OR MainInfo.Secretary = @secretary)
	END
	ELSE IF @index = 4/*CountExecutingOverdue*/
	BEGIN
		select distinct
		PMainInfo.InstanceID as ID,
		PMainInfo.RegistrationNumber as RegistrationNumber, PMainInfo.RegisterDate as RegisterDate, 
		(select Boards.ProtocolTypeName from [dbo].[dvtable_{8D68EE46-400E-4119-9D41-F2DBCA83ECE0}] as Boards where Boards.RowID = PMainInfo.BoardType) as Board, 
		(select Employees.DisplayString from [dbo].[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as Employees where Employees.RowID = PMainInfo.Registrator) as Registrator, 
		(select Employees.DisplayString from [dbo].[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as Employees where Employees.RowID = PMainInfo.Chairman) as Chairman, 
		(select Employees.DisplayString from [dbo].[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as Employees where Employees.RowID = PMainInfo.Secretary) as Secretary
		from 
		[dbo].[dvtable_{C00F1798-2E00-4493-801A-8A3BC4737FB2}] as PMainInfo
		LEFT JOIN [dbo].[dvtable_{6E71A21C-FA5B-4218-8A17-1F47AEBA4CD5}] as PAssignments ON PMainInfo.InstanceID = PAssignments.InstanceID
		LEFT JOIN [dbo].[dvtable_{E3335F61-DBD9-447B-A539-4BF721FFD7B0}] as AMainInfo ON PAssignments.AssignmentID = AMainInfo.InstanceID and AMainInfo.Type = 1
		LEFT JOIN [dbo].[dvtable_{86AF6157-D65A-4F8D-8F92-3DAAD2910A9B}] as AHistory ON AMainInfo.InstanceID = AHistory.InstanceID 
		where PMainInfo.BoardType = @boardId AND PMainInfo.State = 10 AND PMainInfo.RegisterDate >= @datestart AND PMainInfo.RegisterDate <= @dateend AND 
			  (@chairman is NULL OR PMainInfo.Chairman = @chairman) AND (@secretary is NULL OR PMainInfo.Secretary = @secretary) AND
			  ((AHistory.Decision = 6 and AMainInfo.Deadline is not null and AHistory.Date > AMainInfo.Deadline) or (AMainInfo.State <> 3 and AMainInfo.Deadline is not null and AMainInfo.Deadline < @currentDate))
	END

END