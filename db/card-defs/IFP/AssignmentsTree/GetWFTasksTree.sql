BEGIN

-- 1. Парсим строку @WFTasks в таблицу @tasks
declare @tasks table(TaskID uniqueidentifier)

insert into @tasks
select CONVERT(uniqueidentifier, Tasks.Items) from [dbo].[idocfn_split_string](@WFTasks,';') as Tasks
where Tasks.Items is not null AND Tasks.Items != '';

-- 2. Ищем дочерние Поручения первого уровня у каждого WFTask, сохраняем в @rootAssignments
declare @rootAssignments table
(TaskID uniqueidentifier,
AssignmentID uniqueidentifier)

insert into @rootAssignments
select tasks.TaskID, AssignmentMainInfo.InstanceID from @tasks as tasks
inner join 
[dvtable_{BBAA81AA-999D-461B-9B74-2A60A0965555}] as WFTaskChildrenResolutions
on WFTaskChildrenResolutions.InstanceID = tasks.TaskID
inner join [dvtable_{E3335F61-DBD9-447B-A539-4BF721FFD7B0}] as AssignmentMainInfo
on WFTaskChildrenResolutions.ResolutionID = AssignmentMainInfo.InstanceID

-- 3. Загружаем всю ветвь в глубину, сохраняем в @tree
declare @tree table
(
	TaskID uniqueidentifier,
	AssignmentID uniqueidentifier, 
	ParentAssignmentID uniqueidentifier
)

declare c cursor for select TaskID, AssignmentID from @rootAssignments
open c  

declare @taskID uniqueidentifier
declare @rootAssignmentID uniqueidentifier
fetch next from c into @taskID, @rootAssignmentID

while @@FETCH_STATUS=0 begin

   insert into @tree
   select @taskID, AssignmentID, ParentAssignmentID from [dbo].[GetAssignmentSubtree](@rootAssignmentID)

   fetch next from c into @taskID, @rootAssignmentID
end

close c
deallocate c

-- 4. Формируем результат. Для каждого поручения загружаем исполнителя, состояние и тип

select tree.TaskID, tree.AssignmentID, tree.ParentAssignmentID, [dbo].[GetEmployeeFIO](Employees.FirstName, Employees.MiddleName, Employees.LastName) as AssigneeFIO, AssignmentMainInfo.[State], AssignmentMainInfo.[Type] 
from @tree as tree
inner join [dvtable_{E3335F61-DBD9-447B-A539-4BF721FFD7B0}] as AssignmentMainInfo
on tree.AssignmentID = AssignmentMainInfo.InstanceID
inner join [dvtable_{80314B8B-4825-4205-9FE7-F6B294DA9113}] as AssignmentAssignees
on tree.AssignmentID = AssignmentAssignees.InstanceID
inner join [dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as Employees
on AssignmentAssignees.Assignee = Employees.RowID


END

/*
test

exec [dbo].[dvreport_get_data_{630986E2-5636-45cf-BA8F-3FFABECAE6AA}] '{D04FF8BF-794B-4588-83CA-660F6A9E3007}'

*/