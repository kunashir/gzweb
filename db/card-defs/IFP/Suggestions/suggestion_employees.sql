BEGIN

set @text = @text + '%'

declare @result as table (emplID uniqueidentifier,
						  unitID uniqueidentifier,
						  suggestionText nvarchar(125))

insert into @result (emplID, suggestionText, unitID)
select top(100) RowID, DisplayString, ParentRowID 
from [dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as employees
where 
	employees.DisplayString like @text
	and
	NotAvailable != 1


declare @pre_table as table ([unit] uniqueidentifier,
							 [mainUnit] uniqueidentifier,
							 [tempMainUnit] uniqueidentifier,
							 [deptName] nvarchar(125),
							 [filialName] nvarchar(125)                                
)

insert into @pre_table ([unit], [mainUnit], [tempMainUnit], [deptName], [filialName])
select A.[RowID], A.[RowID], A.[RowID], [Name], [Name]
from   [dbo].[dvtable_{7473F07F-11ED-4762-9F1E-7FF10808DDD1}] A

declare @kk as int
set @kk = (select count(*) from @pre_table where [tempMainUnit] is not NULL) +
		  (select count(*) from @pre_table where [tempMainUnit] <> '00000000-0000-0000-0000-000000000000')

while @kk > 0
begin

	update 	@pre_table
	set [mainUnit] = 
	(
		select [ParentTreeRowID] 
		from [dbo].[dvtable_{7473F07F-11ED-4762-9F1E-7FF10808DDD1}] Units
		where Units.RowID = [mainUnit]
	)
	where [tempMainUnit] <> '00000000-0000-0000-0000-000000000000'
		  and [tempMainUnit] is not null

	update @pre_table
	set [deptName] = 
	(
		select [Name] from [dbo].[dvtable_{7473F07F-11ED-4762-9F1E-7FF10808DDD1}] Units
		where Units.RowID = [mainUnit]
	)
	where [tempMainUnit] <> '00000000-0000-0000-0000-000000000000'
		  and [tempMainUnit] is not null

	update 	@pre_table set [tempMainUnit] = 
	(
		select [ParentTreeRowID] 
		from [dbo].[dvtable_{7473F07F-11ED-4762-9F1E-7FF10808DDD1}] Units
		where Units.RowID = [mainUnit]
			  and [mainUnit] <> '00000000-0000-0000-0000-000000000000'
			  and [mainUnit] is not null
	)
	where [tempMainUnit] is not null

	set @kk = (select count(*) from @pre_table where [tempMainUnit] is not NULL and
			   [tempMainUnit] <> '00000000-0000-0000-0000-000000000000')
end

select R.emplID as [RowID], 
	   R.suggestionText + '/' + 
       (CASE WHEN PR.deptName IS NULL THEN '' ELSE PR.deptName + '/' END) + --PR.deptName + '/' + 
       PR.filialName as [DisplayString]
from @result R
	 join @pre_table PR
		on R.unitID = PR.unit

-- OLD LOGIC
--select top(100) RowID, DisplayString 
--from [dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as employees
--where 
--	employees.DisplayString like @text
--	and
--	NotAvailable != 1
	
END
