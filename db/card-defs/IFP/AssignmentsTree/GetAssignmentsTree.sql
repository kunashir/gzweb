BEGIN

declare @rootAssignmentsIDs table(RootAssignmentID uniqueidentifier)
declare @tree table(AssignmentID uniqueidentifier, ParentAssignmentID uniqueidentifier)

insert into @rootAssignmentsIDs
select CONVERT(uniqueidentifier, RootAssignments.Items) from [dbo].[idocfn_split_string](@rootAssignments,';') as RootAssignments
where RootAssignments.Items is not null AND RootAssignments.Items != '';

declare c cursor for select distinct RootAssignmentID from @rootAssignmentsIDs
open c  

declare @rootAssignmentID uniqueidentifier
fetch next from c into @rootAssignmentID

while @@FETCH_STATUS=0 begin

   insert into @tree
   select AssignmentID, ParentAssignmentID from [dbo].[GetAssignmentSubtree](@rootAssignmentID)

   fetch next from c into @rootAssignmentID
end

close c
deallocate c

select AssignmentID, ParentAssignmentID, 
	[dbo].[GetEmployeeFIO](Employees.FirstName, Employees.MiddleName, Employees.LastName) as AssigneeFIO,
	(select DISTINCT [dbo].[GetEmployeeFIO](Employees.FirstName, Employees.MiddleName, Employees.LastName) 
    from [dvtable_{86AF6157-D65A-4F8D-8F92-3DAAD2910A9B}] as AssignmentHistory
		inner join [dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as Employees on (AssignmentHistory.Executer = Employees.RowID)
	where tree.AssignmentID = AssignmentHistory.InstanceID AND TaskID IS NOT NULL) as ExecuterFIO, 
	AssignmentMainInfo.[State], AssignmentMainInfo.[Type] 


from @tree as tree
	inner join [dvtable_{E3335F61-DBD9-447B-A539-4BF721FFD7B0}] as AssignmentMainInfo 
		on (tree.AssignmentID = AssignmentMainInfo.InstanceID)
	left join [dvtable_{80314B8B-4825-4205-9FE7-F6B294DA9113}] as AssignmentAssignees 
		on (tree.AssignmentID = AssignmentAssignees.InstanceID)
	left join [dvtable_{1E3CE215-62F4-4818-B860-E7C0EEE68254}] as AssignmentForAcquaintanceAssignees 
		on (tree.AssignmentID = AssignmentForAcquaintanceAssignees.InstanceID)
	inner join [dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as Employees 
		on (AssignmentAssignees.Assignee = Employees.RowID or AssignmentForAcquaintanceAssignees.ForAcquaintanceAssignee = Employees.RowID)

	inner join [dvsys_instances_date] as instances_date
		on AssignmentID = instances_date.InstanceID
order by AssignmentMainInfo.[Type], instances_date.CreationDateTime

END
/*

declare @rootAssignments nvarchar(max)
set @rootAssignments = '{97DBF8BD-97F4-4867-AB6D-5587A8B721D2}'
exec [dvreport_get_data_{622D9899-3CB6-48e4-8A85-64E3F3F1B6C8}] @rootAssignments

set @rootAssignments = '{52083880-80B9-4D0B-B93D-3429F32548C2}'
exec [dvreport_get_data_{622D9899-3CB6-48e4-8A85-64E3F3F1B6C8}] @rootAssignments

*/