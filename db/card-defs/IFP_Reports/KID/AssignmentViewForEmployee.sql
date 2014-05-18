BEGIN

	declare @table as table ([assignmentID] uniqueidentifier, [assignmentDate] datetime, [assignmentComment] ntext, [assignmentContent] ntext, [assignmentRegDate] datetime)
	declare @vendor_id as uniqueidentifier
	DECLARE vendor_cursor CURSOR FOR 
	 select distinct [InstanceID] from [dbo].[dvtable_{E3335F61-DBD9-447B-A539-4BF721FFD7B0}]
		where ([Author] = @employeeID		-- Сотрудник
			   and [State] in (2, 5, 6)     -- Состояния поручения
			   and [Type] = 1)				-- Тип поручения 'Поручение'
	OPEN vendor_cursor;
	FETCH NEXT FROM vendor_cursor INTO @vendor_id
	while @@fetch_status = 0
	begin
		insert into @table([assignmentID], [assignmentDate], [assignmentComment], [assignmentContent], [assignmentRegDate])
		select [History].[InstanceID], [History].[Date], [History].[Comment], [AssignmentMainInfo].[Content], [AssignmentMainInfo].[RegistrationDate]
		from [dbo].[dvtable_{86AF6157-D65A-4F8D-8F92-3DAAD2910A9B}] [History]
			 left join [dbo].[dvtable_{E3335F61-DBD9-447B-A539-4BF721FFD7B0}] [AssignmentMainInfo]
			 on [History].InstanceID = [AssignmentMainInfo].InstanceID
		where [History].[SysRowTimestamp] =
		(select max([SysRowTimestamp]) from [dbo].[dvtable_{86AF6157-D65A-4F8D-8F92-3DAAD2910A9B}]
		where [InstanceID] = @vendor_id)
		FETCH NEXT FROM vendor_cursor INTO @vendor_id
	end
	CLOSE vendor_cursor;
	DEALLOCATE vendor_cursor;

	select [assignmentID] as AssignmentID, [assignmentDate] as AssignmentDate, [assignmentComment] as CommentText, [assignmentContent] as ContentText, [assignmentRegDate] as AssignmentRegDate
	from @table

	--select RowID as AssignmentID, Date as AssignmentDate, Comment as CommentText from [dvtable_{86AF6157-D65A-4F8D-8F92-3DAAD2910A9B}]
END
