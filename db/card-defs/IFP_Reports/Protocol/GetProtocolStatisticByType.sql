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

declare @protocolBoard table(ProtocolBoardID uniqueidentifier)
insert into @protocolBoard
select MainInfo.BoardType from [dbo].[dvtable_{C00F1798-2E00-4493-801A-8A3BC4737FB2}] as MainInfo
where MainInfo.BoardType is not null
group by MainInfo.BoardType

declare @result table(Number int, Board nvarchar(MAX), BoardID uniqueidentifier, CountAll int, CountExecutedAll int, CountExecutedOverdue int, CountExecutingAll int, CountExecutingOverdue int)

declare @Counter int
select @Counter = COUNT(*) from  @protocolBoard

declare @number int
SET @number = 1
declare @item uniqueidentifier
while @Counter !=0         
	begin         
		select @item = ProtocolBoardID from @protocolBoard 
		delete from @protocolBoard where ProtocolBoardID = @item
		
		/*CountAll*/
		declare @countAll int
		select @countAll = COUNT(*) from [dbo].[dvtable_{C00F1798-2E00-4493-801A-8A3BC4737FB2}] as MainInfo
		where MainInfo.BoardType = @item AND MainInfo.RegisterDate >= @datestart AND MainInfo.RegisterDate <= @dateend AND (@chairman is NULL OR MainInfo.Chairman = @chairman) AND (@secretary is NULL OR MainInfo.Secretary = @secretary)
		
		/*CountExecuteAll*/
		declare @countExecutedAll int
		select @countExecutedAll = COUNT(*) from [dbo].[dvtable_{C00F1798-2E00-4493-801A-8A3BC4737FB2}] as MainInfo 
		where MainInfo.BoardType = @item AND MainInfo.State = 3 AND MainInfo.RegisterDate >= @datestart AND MainInfo.RegisterDate <= @dateend AND (@chairman is NULL OR MainInfo.Chairman = @chairman) AND (@secretary is NULL OR MainInfo.Secretary = @secretary)
		
		/*CountExecutedOverdue*/
		declare @countExecutedOverdue int
		declare @tmpExecutedOverdue as table (id uniqueidentifier)
		delete from @tmpExecutedOverdue
		
		insert into @tmpExecutedOverdue select PMainInfo.InstanceID from
		[dbo].[dvtable_{C00F1798-2E00-4493-801A-8A3BC4737FB2}] as PMainInfo
		LEFT JOIN [dbo].[dvtable_{6E71A21C-FA5B-4218-8A17-1F47AEBA4CD5}] as PAssignments ON PMainInfo.InstanceID = PAssignments.InstanceID
		LEFT JOIN [dbo].[dvtable_{E3335F61-DBD9-447B-A539-4BF721FFD7B0}] as AMainInfo ON PAssignments.AssignmentID = AMainInfo.InstanceID and AMainInfo.Type = 1
		LEFT JOIN [dbo].[dvtable_{86AF6157-D65A-4F8D-8F92-3DAAD2910A9B}] as AHistory ON AMainInfo.InstanceID = AHistory.InstanceID
		where PMainInfo.BoardType = @item AND PMainInfo.State = 3 AND PMainInfo.RegisterDate >= @datestart AND PMainInfo.RegisterDate <= @dateend AND 
			  (@chairman is NULL OR PMainInfo.Chairman = @chairman) AND (@secretary is NULL OR PMainInfo.Secretary = @secretary) AND
			  ((AHistory.Decision = 6 and AMainInfo.Deadline is not null and AHistory.Date > AMainInfo.Deadline) or (AMainInfo.State <> 3 and AMainInfo.Deadline is not null and AMainInfo.Deadline < @currentDate))
		group by PMainInfo.InstanceID
		
		select @countExecutedOverdue = COUNT(*) from @tmpExecutedOverdue
		
		/*CountExecutingAll*/
		declare @countExecutingAll int
		select @countExecutingAll = COUNT(*) from [dbo].[dvtable_{C00F1798-2E00-4493-801A-8A3BC4737FB2}] as MainInfo 
		where MainInfo.BoardType = @item AND MainInfo.State = 10 AND MainInfo.RegisterDate >= @datestart AND MainInfo.RegisterDate <= @dateend AND (@chairman is NULL OR MainInfo.Chairman = @chairman) AND (@secretary is NULL OR MainInfo.Secretary = @secretary)
		
		/*CountExecutingOverdue*/
		declare @countExecutingOverdue int
		declare @tmpExecutingOverdue as table (id uniqueidentifier)
		delete from @tmpExecutingOverdue
		
		insert into @tmpExecutingOverdue select PMainInfo.InstanceID from
		[dbo].[dvtable_{C00F1798-2E00-4493-801A-8A3BC4737FB2}] as PMainInfo
		LEFT JOIN [dbo].[dvtable_{6E71A21C-FA5B-4218-8A17-1F47AEBA4CD5}] as PAssignments ON PMainInfo.InstanceID = PAssignments.InstanceID
		LEFT JOIN [dbo].[dvtable_{E3335F61-DBD9-447B-A539-4BF721FFD7B0}] as AMainInfo ON PAssignments.AssignmentID = AMainInfo.InstanceID and AMainInfo.Type = 1
		LEFT JOIN [dbo].[dvtable_{86AF6157-D65A-4F8D-8F92-3DAAD2910A9B}] as AHistory ON AMainInfo.InstanceID = AHistory.InstanceID
		where PMainInfo.BoardType = @item AND PMainInfo.State = 10 AND PMainInfo.RegisterDate >= @datestart AND PMainInfo.RegisterDate <= @dateend AND 
			  (@chairman is NULL OR PMainInfo.Chairman = @chairman) AND (@secretary is NULL OR PMainInfo.Secretary = @secretary) AND
			  ((AHistory.Decision = 6 and AMainInfo.Deadline is not null and AHistory.Date > AMainInfo.Deadline) or (AMainInfo.State <> 3 and AMainInfo.Deadline is not null and AMainInfo.Deadline < @currentDate))
		group by PMainInfo.InstanceID
		
		select @countExecutingOverdue = COUNT(*) from @tmpExecutingOverdue
		
		/**/
		declare @BoardsTypeName as nvarchar(256)
		set @BoardsTypeName = (select top 1 Boards.ProtocolTypeName from [dbo].[dvtable_{8D68EE46-400E-4119-9D41-F2DBCA83ECE0}] as Boards where Boards.RowID = @item)
		insert into @result values (@number, @BoardsTypeName, @item, @countAll, @countExecutedAll, @countExecutedOverdue, @countExecutingAll, @countExecutingOverdue)
		
		SET @number = @number + 1
		SET @Counter = @Counter - 1
	end
	
select * from @result
END