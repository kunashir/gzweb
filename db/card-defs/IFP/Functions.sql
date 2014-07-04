-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------

IF NOT OBJECT_ID('[dbo].[GetIncDoc1stBranchTasks]') IS NULL
	DROP PROCEDURE [dbo].[GetIncDoc1stBranchTasks]

--Delimiter
GO
-- get all incoming document 1st branch tasks 
CREATE PROCEDURE [dbo].[GetIncDoc1stBranchTasks]
(@incDocID uniqueidentifier) with encryption
AS
BEGIN

DECLARE @tasks TABLE (TaskID uniqueidentifier)

DECLARE @task as uniqueidentifier
SET @task = (SELECT TOP(1) history.TaskID FROM 
			[dvtable_{86AF6157-D65A-4F8D-8F92-3DAAD2910A9B}] as history, 
			[dvtable_{AD95E7FB-592C-4CAA-BBDF-25F32F0B2987}] as IncDocResolutions
			WHERE IncDocResolutions.ResolutionID = history.InstanceID AND 
			@incDocID = IncDocResolutions.InstanceID)


WHILE @task is not null
	BEGIN
		DECLARE @assignmentId uniqueidentifier
		SET @assignmentId = (SELECT TOP(1) history.InstanceID FROM 
							[dvtable_{86AF6157-D65A-4F8D-8F92-3DAAD2910A9B}] as history, 
							[dvtable_{BBAA81AA-999D-461B-9B74-2A60A0965555}] as ChilderenResolutions
							WHERE ChilderenResolutions.InstanceID = @task AND
							history.InstanceID = ChilderenResolutions.ResolutionID AND 
							history.InstanceID is not null)		
		SET @task = (SELECT TOP(1) history.TaskID FROM 
					[dvtable_{86AF6157-D65A-4F8D-8F92-3DAAD2910A9B}] as history
					WHERE history.InstanceID = @assignmentId)
		INSERT INTO @tasks
		VALUES(@assignmentId)
	END

SELECT
@incDocID,
Tasks.TaskID, 
assignees.Assignee as ExecuterID,
assigneesEmp.LastName + ' ' + CASE WHEN assigneesEmp.FirstName IS NULL THEN '' ELSE LEFT(assigneesEmp.FirstName,1) + '.' END 
			   + CASE WHEN assigneesEmp.MiddleName IS NULL THEN '' ELSE LEFT(assigneesEmp.MiddleName,1) + '.' END as Executer,
maininfo.Author as AuthorID,
authors.LastName + ' ' + CASE WHEN authors.FirstName IS NULL THEN '' ELSE LEFT(authors.FirstName,1) + '.' END 
			   + CASE WHEN authors.MiddleName IS NULL THEN '' ELSE LEFT(authors.MiddleName,1) + '.' END as Author,
(SELECT TOP(1) taskHistory.Comment 
 FROM [dvtable_{86AF6157-D65A-4F8D-8F92-3DAAD2910A9B}] as taskHistory 
 WHERE Tasks.TaskID = taskHistory.InstanceID AND taskHistory.Comment is not null
 ORDER BY Decision DESC) as Comments
FROM @tasks as Tasks
LEFT JOIN [dvtable_{E3335F61-DBD9-447B-A539-4BF721FFD7B0}] as maininfo ON maininfo.InstanceID = Tasks.TaskID
LEFT JOIN [dvtable_{80314B8B-4825-4205-9FE7-F6B294DA9113}] as assignees ON assignees.InstanceID = Tasks.TaskID
LEFT JOIN [dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as assigneesEmp ON assignees.Assignee = assigneesEmp.RowID
LEFT JOIN [dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as authors ON maininfo.Author = authors.RowID
WHERE Tasks.TaskID is not null AND assignees.Assignee is not null AND maininfo.Author is not null
END

go

if not object_id('[dbo].[GetContractCurrentOwner]') IS NULL
	drop function [dbo].[GetContractCurrentOwner]
go

-- 
create function [dbo].[GetContractCurrentOwner]
(@instanceId uniqueidentifier)
returns nvarchar(max) with encryption
as
begin
	declare @employee nvarchar(max)
	set @employee = null;	
	
	

	
	set @employee = (SELECT TOP(1) Employees.DisplayString 
    from [dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as Employees,
    [dvtable_{E79A6914-9A7A-467C-93CB-5A2F30BB5C52}] as History
	where Employees.RowID = History.Person AND History.InstanceID = @instanceId
	ORDER BY History.Date Desc)
	return @employee
end

GO

if not object_id('[dbo].[GetOutDocSigners]') IS NULL
	drop function [dbo].[GetOutDocSigners]
go

/* Список подписантов исходящего */
create function [dbo].[GetOutDocSigners]
(@outdocId uniqueidentifier)
returns nvarchar(max) with encryption
as
begin
	declare @signers nvarchar(max)
	set @signers = '';
	select @signers = @signers + Employees.DisplayString + '; ' 
		from [dbo].[dvtable_{C9E2D5D7-DEB2-43EA-84EF-A511507259E3}] as SignedByPersons,
			 [dbo].[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as Employees
		where SignedByPersons.instanceid = @outdocId AND
			  Employees.RowID = SignedByPersons.SignedByPerson
	return @signers
end

go 
if not object_id('[dbo].[GetIncDocRecipients]') IS NULL
	drop function [dbo].[GetIncDocRecipients]
go

/* Список получателей входящего */
create function [dbo].[GetIncDocRecipients]
(@incdocId uniqueidentifier)
returns nvarchar(MAX) with encryption
as
begin
	declare @recipients nvarchar(MAX)
	set @recipients = '';
	select @recipients = @recipients + convert(varchar(36), Employees.DisplayString) + '; ' 
		from [dbo].[dvtable_{FC138430-DE5D-47D2-BBD6-DA17D4DCF4CD}] as Recipients,
			 [dbo].[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as Employees
		where Recipients.instanceid = @incdocId AND
			  Employees.RowID = Recipients.Recipient
	return @recipients
end
GO

if not object_id('[dbo].[GetCardTypeByID]') IS NULL
	drop function [dbo].[GetCardTypeByID]
go

-- Тип карточки по идентификатору её экземпляра
create function [dbo].[GetCardTypeByID]
(@instance uniqueidentifier)
returns uniqueidentifier with encryption
as
begin
	declare @cardTypeId uniqueidentifier
	set @cardTypeId = null;	

	select @cardTypeId = CardTypeID from dvsys_instances
	where InstanceID = @instance
	return @cardTypeId
end

go

if not object_id('[dbo].[GetEmployeeDisplayStringByID]') IS NULL
	drop function [dbo].[GetEmployeeDisplayStringByID]
go

-- Фио сотрудника по его идентификатору
create function [dbo].[GetEmployeeDisplayStringByID]
(@rowid uniqueidentifier)
returns nvarchar(max) with encryption
as
begin
	declare @employee nvarchar(max)
	set @employee = null;	

	select @employee = Employees.DisplayString from [dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as Employees
	where RowID = @rowid
	return @employee
end

GO

if not object_id('[dbo].[IsDepartmentManagedByEmployee]') IS NULL
	drop function [dbo].[IsDepartmentManagedByEmployee]
go

-- Подразделением руководит данный сотрудник ?
create function [dbo].[IsDepartmentManagedByEmployee]
(@department uniqueidentifier, @employee uniqueidentifier)
returns bit with encryption
as
begin
	declare @result bit
	set @result = 0;	
	select @result = 1 from [dvtable_{7473F07F-11ED-4762-9F1E-7FF10808DDD1}] as Units
	where Units.RowID = @department AND Units.Manager = @employee
	return @result
end

GO

IF object_id('[dbo].[GetDepartmentTree]') IS NOT NULL
	DROP PROCEDURE [dbo].[GetDepartmentTree]
GO

-- Вывод всех дочерних организации относительно данной
CREATE PROCEDURE [GetDepartmentTree]
(
@topDepartmentID uniqueidentifier
) with encryption
AS
BEGIN
DECLARE @level int
DECLARE @count int

DECLARE @tempTable TABLE (DepartmentID uniqueidentifier, [Level] int, RootDepartmentID uniqueidentifier)

INSERT INTO @tempTable
(DepartmentID, [Level],RootDepartmentID)
VALUES
(@topDepartmentID, 0, @topDepartmentID)
SET @count = 1
SET @level = 0
WHILE @count > 0
	BEGIN
		INSERT INTO @tempTable
		(DepartmentID, [Level],RootDepartmentID )
		(
			SELECT subDepartments.RowID,
				   @level + 1,
					@topDepartmentID
			FROM  @tempTable departments,
				  [dbo].[dvtable_{7473F07F-11ED-4762-9F1E-7FF10808DDD1}] subDepartments
			WHERE departments.[Level] = @level
				  AND subDepartments.ParentTreeRowID = departments.DepartmentID
		)
		SELECT @count = COUNT(*)
		FROM   @tempTable
		WHERE  [Level] = @level + 1
		SET @level = @level + 1
	END
SELECT *
FROM   @tempTable
ORDER BY [Level]
END

GO

if not object_id('[dbo].[GetAssignmentFinishDate]') IS NULL
	drop function [dbo].[GetAssignmentFinishDate]
go
/* Дата завершения поручения */
create function [dbo].[GetAssignmentFinishDate]
(
@assignment uniqueidentifier,
@executer uniqueidentifier
)
returns datetime with encryption
as
begin
	declare @finishdate datetime
	set @finishdate = NULL;
	declare @result table (Date datetime)
	insert into @result
	select top(1) Date from [dvtable_{86AF6157-D65A-4F8D-8F92-3DAAD2910A9B}] as AssignmentHistory,
	[dvtable_{E3335F61-DBD9-447B-A539-4BF721FFD7B0}] as AssignmentMainInfo
	where AssignmentHistory.InstanceID = @assignment AND
	AssignmentMainInfo.InstanceID = @assignment AND
    (AssignmentMainInfo.State = 3 OR AssignmentMainInfo.State = 7)
	order by Date desc
	select @finishdate = Date from @result
	return @finishdate
end

go

if not object_id('[dbo].[GetEmployeeDisplayString]') IS NULL
	drop function [dbo].[GetEmployeeDisplayString]
go

-- Фио сотрудника по его идентификатору
create function [dbo].[GetEmployeeDisplayString]
(@rowid uniqueidentifier)
returns nvarchar(max) with encryption
as
begin
	declare @employee nvarchar(max)
	set @employee = null;	

	select @employee = Employees.DisplayString from [dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as Employees
	where RowID = @rowid
	return @employee
end

GO


if not object_id('[dbo].[GetEmployeeDepartment]') IS NULL
	drop function [dbo].[GetEmployeeDepartment]
go

-- подразделение сотрудника
create function [dbo].[GetEmployeeDepartment]
(@rowid uniqueidentifier)
returns nvarchar(max) with encryption
as
begin
	declare @dep nvarchar(max)
	set @dep = null;	
	select @dep = Units.Name from [dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as Employees,
	[dvtable_{7473F07F-11ED-4762-9F1E-7FF10808DDD1}] as Units
	where Employees.RowID = @rowid AND Employees.ParentRowID = Units.RowID
	return @dep
end
GO

if not object_id('[dbo].[GetEmployeePosition]') IS NULL
	drop function [dbo].[GetEmployeePosition]
go

-- должность сотрудника
create function [dbo].[GetEmployeePosition]
(@rowid uniqueidentifier)
returns nvarchar(max) with encryption
as
begin
	declare @position nvarchar(max)
	set @position = null;	
	select @position = Position.Name from [dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as Employees,
	[dvtable_{CFDFE60A-21A8-4010-84E9-9D2DF348508C}] as Position
	where Employees.RowID = @rowid AND Position.RowID = Employees.Position
	return @position
end

GO

if not object_id('[dbo].[GetEmployeeDepartmentID]') IS NULL
	drop function [dbo].[GetEmployeeDepartmentID]
go

-- id подразделения сотрудника
create function [dbo].[GetEmployeeDepartmentID]
(@rowid uniqueidentifier)
returns nvarchar(max) with encryption
as
begin
	declare @dep uniqueidentifier
	set @dep = null;	
	select @dep = Units.RowID from [dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as Employees,
	[dvtable_{7473F07F-11ED-4762-9F1E-7FF10808DDD1}] as Units
	where Employees.RowID = @rowid AND Employees.ParentRowID = Units.RowID
	return @dep
end
GO


if not object_id('[dbo].[GetDepartmentEmployeesCount]') IS NULL
	drop function [dbo].[GetDepartmentEmployeesCount]
go

-- кол-во сотрудников в подразделении
create function [dbo].[GetDepartmentEmployeesCount]
(@department uniqueidentifier)
returns int with encryption
as
begin
	declare @dep int
	set @dep = 0;	
	select @dep = Count(*) from [dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as Employees
	where Employees.ParentRowID = @department
	return @dep
end
GO


if not object_id('[dbo].[GetDocumentContent]') IS NULL
	drop function [dbo].[GetDocumentContent]
go

/* Содержание документа */
create function [dbo].[GetDocumentContent]
(@cardid uniqueidentifier)
returns nvarchar(max) with encryption
as
begin
	declare @content nvarchar(max)
	declare @regdate datetime
	declare @regnumb nvarchar(max)

	set @content = ''

declare @cardtype uniqueidentifier
set @cardtype = [dbo].[GetCardTypeByID](@cardid)

IF @cardtype = 'F8EE21FE-FB3D-45AD-B2C9-10C5A224E2D9'
	BEGIN
		select @content = ContractMainInfo.Description
		FROM [dvtable_{DAA76B4A-98F9-44BA-833C-DD874DB33214}] as ContractMainInfo WHERE 
		ContractMainInfo.InstanceID = @cardid
	END

IF @cardtype = 'EB0F2CF0-F80B-4132-80D7-03409ABB3E70'
	BEGIN
		select @content = DirectionMainInfo.Subject
		FROM [dvtable_{4130F43C-6DD5-4A5B-971E-AA134F7FB2E5}] as DirectionMainInfo WHERE 
		DirectionMainInfo.InstanceID = @cardid
	END

IF @cardtype = 'EF453635-DE18-427C-8B60-486BFA656D4D'
	BEGIN
		select @content = ProtocolMainInfo.Subject
		FROM [dvtable_{C00F1798-2E00-4493-801A-8A3BC4737FB2}] as ProtocolMainInfo WHERE 
		ProtocolMainInfo.InstanceID = @cardid
	END
	
IF @cardtype = '56070FE0-BFC6-4CF1-8786-482E4DDFE9B6'
	BEGIN
		select @content = OrderMainInfo.Subject
		FROM [dvtable_{F875C7C6-A280-402D-BC56-36DEE6376EED}] as OrderMainInfo WHERE 
		OrderMainInfo.InstanceID = @cardid
	END

IF @cardtype = '094DEF0A-2CA1-41D8-81B6-70F586FDDE56'
	BEGIN
		select @content = IncDocMainInfo.Subject
		FROM [dvtable_{C06228B9-99F8-4B41-950B-8FACDC00A2B7}] as IncDocMainInfo WHERE 
		IncDocMainInfo.InstanceID = @cardid
	END

IF @cardtype = '816AE98F-0E9C-4734-B368-642A34948527'
	BEGIN
		select @content = MemorandumMainInfo.Subject
		FROM [dvtable_{B5D96F96-ACA2-4184-9702-2D89B1B3936A}] as MemorandumMainInfo WHERE 
		MemorandumMainInfo.InstanceID = @cardid
	END

IF @cardtype = '2E729D50-6B61-4186-9D14-44E109FD920B'
	BEGIN
		select @content = OutDocMainInfo.Topic
		FROM [dvtable_{4C07CA25-41D6-438A-B73E-47FE7650C7BD}] as OutDocMainInfo WHERE 
		OutDocMainInfo.InstanceID = @cardid
	END
	
IF @cardtype = '7F3ACEC5-5650-4EDA-B29E-104AADFC7A73'
	BEGIN
		select @content = WarrantMainInfo.Note
		FROM [dvtable_{EC83F06E-8131-4437-A573-C86B15A2AF5C}] as WarrantMainInfo WHERE 
		WarrantMainInfo.InstanceID = @cardid
	END
	
	
	return @content
end

GO

if not object_id('[dbo].[GetDocumentRegNumb]') IS NULL
	drop function [dbo].[GetDocumentRegNumb]
GO
/* Регистрационный номер документа */
create function [dbo].[GetDocumentRegNumb]
(@cardid uniqueidentifier)
returns nvarchar(max) with encryption
as
begin
	declare @regnumb nvarchar(max)
	set @regnumb = null

declare @cardtype uniqueidentifier
set @cardtype = [dbo].[GetCardTypeByID](@cardid)

IF @cardtype = 'F8EE21FE-FB3D-45AD-B2C9-10C5A224E2D9'
	BEGIN
		select @regnumb = ContractMainInfo.RegistrationNumber
		FROM [dvtable_{DAA76B4A-98F9-44BA-833C-DD874DB33214}] as ContractMainInfo WHERE 
		ContractMainInfo.InstanceID = @cardid
	END

IF @cardtype = 'EB0F2CF0-F80B-4132-80D7-03409ABB3E70'
	BEGIN
		select @regnumb = DirectionMainInfo.RegistrationNumber
		FROM [dvtable_{4130F43C-6DD5-4A5B-971E-AA134F7FB2E5}] as DirectionMainInfo WHERE 
		DirectionMainInfo.InstanceID = @cardid
	END
	
IF @cardtype = 'EF453635-DE18-427C-8B60-486BFA656D4D'
	BEGIN
		select @regnumb = ProtocolMainInfo.RegistrationNumber
		FROM [dvtable_{C00F1798-2E00-4493-801A-8A3BC4737FB2}] as ProtocolMainInfo WHERE 
		ProtocolMainInfo.InstanceID = @cardid
	END
	
IF @cardtype = '56070FE0-BFC6-4CF1-8786-482E4DDFE9B6'
	BEGIN
		select @regnumb = OrderMainInfo.RegistrationNumber
		FROM [dvtable_{F875C7C6-A280-402D-BC56-36DEE6376EED}] as OrderMainInfo WHERE 
		OrderMainInfo.InstanceID = @cardid
	END

IF @cardtype = '094DEF0A-2CA1-41D8-81B6-70F586FDDE56'
	BEGIN
		select @regnumb = IncDocMainInfo.RegistrationNumber
		FROM [dvtable_{C06228B9-99F8-4B41-950B-8FACDC00A2B7}] as IncDocMainInfo WHERE 
		IncDocMainInfo.InstanceID = @cardid
	END

IF @cardtype = '816AE98F-0E9C-4734-B368-642A34948527'
	BEGIN
		select @regnumb = MemorandumMainInfo.RegistrationNumber
		FROM [dvtable_{B5D96F96-ACA2-4184-9702-2D89B1B3936A}] as MemorandumMainInfo WHERE 
		MemorandumMainInfo.InstanceID = @cardid
	END
	
IF @cardtype = '2E729D50-6B61-4186-9D14-44E109FD920B'
	BEGIN
		select @regnumb = OutDocMainInfo.RegistrationNumber
		FROM [dvtable_{4C07CA25-41D6-438A-B73E-47FE7650C7BD}] as OutDocMainInfo WHERE 
		OutDocMainInfo.InstanceID = @cardid
	END
	
IF @cardtype = '7F3ACEC5-5650-4EDA-B29E-104AADFC7A73'
	BEGIN
		select @regnumb = WarrantMainInfo.RegistrationNumber
		FROM [dvtable_{EC83F06E-8131-4437-A573-C86B15A2AF5C}] as WarrantMainInfo WHERE 
		WarrantMainInfo.InstanceID = @cardid
	END
	
	return @regnumb
end

GO 
if not object_id('[dbo].[GetDocumentRegDate]') IS NULL
	drop function [dbo].[GetDocumentRegDate]
go

/* рег. дата документа */
create function [dbo].[GetDocumentRegDate]
(@cardid uniqueidentifier)
returns datetime with encryption
as
begin
	declare @regdate datetime
	set @regdate = null

declare @cardtype uniqueidentifier
set @cardtype = [dbo].[GetCardTypeByID](@cardid)

IF @cardtype = 'F8EE21FE-FB3D-45AD-B2C9-10C5A224E2D9'
	BEGIN
		select @regdate = ContractMainInfo.RegistrationDate
		FROM [dvtable_{DAA76B4A-98F9-44BA-833C-DD874DB33214}] as ContractMainInfo WHERE 
		ContractMainInfo.InstanceID = @cardid
	END

IF @cardtype = 'EB0F2CF0-F80B-4132-80D7-03409ABB3E70'
	BEGIN
		select @regdate = DirectionMainInfo.RegistrationDate
		FROM [dvtable_{4130F43C-6DD5-4A5B-971E-AA134F7FB2E5}] as DirectionMainInfo WHERE 
		DirectionMainInfo.InstanceID = @cardid
	END

IF @cardtype = 'EF453635-DE18-427C-8B60-486BFA656D4D'
	BEGIN
		select @regdate = ProtocolMainInfo.RegisterDate -- :(
		FROM [dvtable_{C00F1798-2E00-4493-801A-8A3BC4737FB2}] as ProtocolMainInfo WHERE 
		ProtocolMainInfo.InstanceID = @cardid
	END

IF @cardtype = '56070FE0-BFC6-4CF1-8786-482E4DDFE9B6'
	BEGIN
		select @regdate = OrderMainInfo.RegistrationDate
		FROM [dvtable_{F875C7C6-A280-402D-BC56-36DEE6376EED}] as OrderMainInfo WHERE 
		OrderMainInfo.InstanceID = @cardid
	END

IF @cardtype = '094DEF0A-2CA1-41D8-81B6-70F586FDDE56'
	BEGIN
		select @regdate = IncDocMainInfo.RegistrationDate
		FROM [dvtable_{C06228B9-99F8-4B41-950B-8FACDC00A2B7}] as IncDocMainInfo WHERE 
		IncDocMainInfo.InstanceID = @cardid
	END

IF @cardtype = '816AE98F-0E9C-4734-B368-642A34948527'
	BEGIN
		select @regdate = MemorandumMainInfo.RegistrationDate
		FROM [dvtable_{B5D96F96-ACA2-4184-9702-2D89B1B3936A}] as MemorandumMainInfo WHERE 
		MemorandumMainInfo.InstanceID = @cardid
	END
	
IF @cardtype = '2E729D50-6B61-4186-9D14-44E109FD920B'
	BEGIN
		select @regdate = OutDocMainInfo.RegistrationDate
		FROM [dvtable_{4C07CA25-41D6-438A-B73E-47FE7650C7BD}] as OutDocMainInfo WHERE 
		OutDocMainInfo.InstanceID = @cardid
	END
	
IF @cardtype = '7F3ACEC5-5650-4EDA-B29E-104AADFC7A73'
	BEGIN
		select @regdate = WarrantMainInfo.RegistrationDate
		FROM [dvtable_{EC83F06E-8131-4437-A573-C86B15A2AF5C}] as WarrantMainInfo WHERE 
		WarrantMainInfo.InstanceID = @cardid
	END
	
	return @regdate
end

go

if not object_id('[dbo].[IsManager]') IS NULL
	drop function [dbo].[IsManager]
go

-- Текущий сотрудник - руководитель?
create function [dbo].[IsManager]
(@employee uniqueidentifier)
returns bit with encryption
as
begin
	if @employee is null
		return 0

	declare @result bit
	set @result = 0
	declare @rowsCount int
	set @rowsCount = 0
	select @rowsCount = Count(*) from [dvtable_{7473F07F-11ED-4762-9F1E-7FF10808DDD1}] WHERE Manager = @employee AND RowID is not null
	if @rowsCount > 0
		begin
			set @result = 1
		end
	return @result
end
GO



if not object_id('[dbo].[GetEmployeeFIO]') is null
	drop function [dbo].[GetEmployeeFIO]
go

create function [dbo].[GetEmployeeFIO]
(	@FirstName nvarchar(255),
	@MiddleName nvarchar(255),
	@LastName nvarchar(255)
)
returns nvarchar(255)
as
begin

return @LastName 
+ ' ' + CASE WHEN @FirstName IS NULL THEN '' ELSE LEFT(@FirstName,1) + '.' END 
+ CASE WHEN @MiddleName IS NULL THEN '' ELSE LEFT(@MiddleName,1) + '.' END

end
go
/*

test

select [dbo].[GetEmployeeFIO]('FirstName', 'MiddleName', 'LastName')
select [dbo].[GetEmployeeFIO]('FirstName', '', 'LastName')
select [dbo].[GetEmployeeFIO]('FirstName', null, 'LastName')

*/



if not object_id('[dbo].[GetAssignmentSubtree]') is null
	drop function [dbo].[GetAssignmentSubtree]
go

create function [dbo].[GetAssignmentSubtree]
(@rootAssignmentID uniqueidentifier)
returns @subtree table
(
	AssignmentID uniqueidentifier,
	ParentAssignmentID uniqueidentifier
)
as
begin
	with AssignmentTree (AssignmentID, ParentAssignmentID)
	as
	(
		select @rootAssignmentID, null--Текущая вершина

		union all

		select WFTaskChildrenResolution.ResolutionID, @rootAssignmentID from 
		[dvtable_{86AF6157-D65A-4F8D-8F92-3DAAD2910A9B}] as AssignmentHistory
		inner join [dvtable_{BBAA81AA-999D-461B-9B74-2A60A0965555}] WFTaskChildrenResolution
		on WFTaskChildrenResolution.InstanceID = AssignmentHistory.TaskID
		where AssignmentHistory.InstanceID = @rootAssignmentID
		
		union all 
		
		select WFTaskChildrenResolution.ResolutionID, AssignmentHistory.InstanceID from 
		[dvtable_{86AF6157-D65A-4F8D-8F92-3DAAD2910A9B}] as AssignmentHistory
		inner join [dvtable_{BBAA81AA-999D-461B-9B74-2A60A0965555}] WFTaskChildrenResolution
		on WFTaskChildrenResolution.InstanceID = AssignmentHistory.TaskID
		inner join AssignmentTree
		on AssignmentTree.AssignmentID = AssignmentHistory.InstanceID

		union all
		-- insert linked assignments as children if current assignment was reassigned
		SELECT LinkedAssignment.Assignment,
		--(CASE WHEN AssignmentID is null THEN @rootAssignmentID ELSE AssignmentID END) as Parent
		NULL AS Parent --same level as original
		FROM AssignmentTree, 
		[dvtable_{E3335F61-DBD9-447B-A539-4BF721FFD7B0}] as MainInfo,
		[dvtable_{851B69BD-3F36-4BD9-A5F7-9B80FFEA0791}] as LinkedAssignment
		WHERE
		AssignmentID = MainInfo.InstanceID AND LinkedAssignment.InstanceID = MainInfo.InstanceID AND 
		State = 4 /*recalled*/ 
	)

	insert into @subtree
	select @rootAssignmentID, null /* adding root node */
	union
	select distinct AssignmentID, ParentAssignmentID from AssignmentTree /* adding child nodes */

	return
end

go

if not object_id('[dbo].[idocfn_get_outdoc_signers]') IS NULL
	drop function [dbo].[idocfn_get_outdoc_signers]
go
create function [dbo].[idocfn_get_outdoc_signers]
(@outdocId uniqueidentifier)
returns nvarchar(2000)
as
begin
	declare @signers nvarchar(2000)
	set @signers = '';
	select @signers = @signers + '{' + convert(varchar(36), SignedByPerson) + '}' 
		from [dbo].[dvtable_{C9E2D5D7-DEB2-43EA-84EF-A511507259E3}] as SignedByPersons
		where SignedByPersons.instanceid = @outdocId
	return @signers
end
go

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[idocfn_split_string]') and xtype in (N'FN', N'IF', N'TF')) 
drop function [dbo].[idocfn_split_string] 
go

CREATE FUNCTION dbo.[idocfn_split_string]
(@Str nvarchar(4000), @Delimiter char(1)) 
RETURNS @Results TABLE (Items nvarchar(4000)) 
AS BEGIN     
	DECLARE @Counter int     
	DECLARE @Slice nvarchar(4000)     
	SELECT @Counter = 1     

	IF @Str IS NULL RETURN     
	WHILE @Counter !=0         
	BEGIN           
		SELECT @Counter = CHARINDEX(@Delimiter,@Str)          
		IF @Counter !=0           
			SELECT @Slice = LEFT(@Str,@Counter - 1)          
		ELSE           
			SELECT @Slice = @Str          

		INSERT INTO @Results(Items) VALUES(@Slice)          
		SELECT @Str = RIGHT(@Str,LEN(@Str) - @Counter)          
		IF LEN(@Str) = 0 
			BREAK     
		END     
RETURN END

go
-- получение просрочки через Бизнес-календарь
IF NOT OBJECT_ID('[dbo].[idocfn_get_workdaydiff]') IS NULL
	DROP FUNCTION [dbo].[idocfn_get_workdaydiff]
GO
CREATE FUNCTION [dbo].[idocfn_get_workdaydiff]
(@userID uniqueidentifier,
 @dateFrom datetime,
 @dateTo datetime)
RETURNS int
AS
BEGIN
	DECLARE @calendarID uniqueidentifier
	DECLARE @depID uniqueidentifier
	DECLARE @outDay int
	DECLARE @year int

	SELECT @calendarID = CalendarID,
		   @depID = ParentRowID
	FROM   [dbo].[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}]
	WHERE  RowID = @userID

	WHILE (@calendarID is NULL) and (@depID is not NULL) and (@depID <> '{00000000-0000-0000-0000-000000000000}')
	BEGIN
		SELECT @calendarID = CalendarID,
			   @depID = ParentTreeRowID
		FROM   [dbo].[dvtable_{7473F07F-11ED-4762-9F1E-7FF10808DDD1}]
		WHERE  RowID = @depID
	END

	IF Year(@dateFrom) = Year(@dateTo)
		SET @outDay = (DATEPART(dy, @dateTo) - DATEPART(dy, @dateFrom)) / 7 * 2
	ELSE
	BEGIN
		SET @year = Year(@dateFrom)
		
		SET @outDay = (DATEPART(dy, '12.31.' + CAST(@year as nvarchar)) - DATEPART(dy, @dateFrom)) / 7 * 2
		SET @year = @year + 1
		
		WHILE @year < Year(@dateTo)
			SET @outDay = @outDay + (DATEPART(dy, '12.31.' + CAST(@year as nvarchar)) - (DATEPART(dy, '01.01.' + CAST(@year as nvarchar)))) / 7 * 2
			
		SET @outDay = @outDay + (DATEPART(dy, @dateTo) - (DATEPART(dy, '01.01.' + CAST(@year as nvarchar)))) / 7 * 2
	END

	DECLARE @dateFromWD int
	DECLARE @dateToWD int

	SET @dateFromWD = (DATEPART(dw, @dateFrom) + @@DateFirst - 2) % 7
	SET @dateToWD = (DATEPART(dw, @dateTo) + @@DateFirst - 2) % 7

	IF @dateFromWD < 5
	BEGIN
		IF @dateToWD = 5
			SET @outDay = @outDay + 1
		ELSE
		IF @dateToWD = 6
			SET @outDay = @outDay + 2
		ELSE
		IF @dateToWD < @dateFromWD
			SET @outDay = @outDay + 2
	END
	ELSE
	IF @dateFromWD = 5
	BEGIN
		IF @dateToWD < 5
			SET @outDay = @outDay + 2
		ELSE
		IF @dateToWD = 6
			SET @outDay = @outDay + 1
	END
	ELSE
	IF @dateFromWD = 6
	BEGIN
		IF @dateToWD < 6
			SET @outDay = @outDay + 1
	END

	IF (@calendarID is not NULL)
	BEGIN
		SET @year = Year(@dateFrom)

		WHILE @year <= Year(@dateTo)
		BEGIN
			SELECT @outDay = @outDay - COUNT(*)
			FROM   [dbo].[dvtable_{D8B0DEB3-FAE7-4C06-8728-B495985183C9}] years,
				   [dbo].[dvtable_{F12C1136-B351-4037-9DC9-21C042A238AF}] days
			WHERE  years.InstanceID = @calendarID
				   AND years.[Year] = @year
				   AND days.ParentRowID = years.RowID
				   AND days.DayNumber > CASE WHEN @year = Year(@dateFrom) THEN DatePart(dy, @dateFrom) ELSE 1 END
				   AND days.DayNumber <= CASE WHEN @year = Year(@dateTo) THEN DatePart(dy, @dateTo) ELSE DatePart(dy, '12.31.' + CAST(@year as nvarchar)) END
				   AND days.[Type] = 0
				   AND (((DATEPART(dw, '01.01.2009') + @@DateFirst + days.DayNumber - 3) % 7) >= 5)

			SELECT @outDay = @outDay + COUNT(*)
			FROM   [dbo].[dvtable_{D8B0DEB3-FAE7-4C06-8728-B495985183C9}] years,
				   [dbo].[dvtable_{F12C1136-B351-4037-9DC9-21C042A238AF}] days
			WHERE  years.InstanceID = @calendarID
				   AND years.[Year] = @year
				   AND days.ParentRowID = years.RowID
				   AND days.DayNumber > CASE WHEN @year = Year(@dateFrom) THEN DatePart(dy, @dateFrom) ELSE 1 END
				   AND days.DayNumber <= CASE WHEN @year = Year(@dateTo) THEN DatePart(dy, @dateTo) ELSE DatePart(dy, '12.31.' + CAST(@year as nvarchar)) END
				   AND ((days.[Type] = 1) or (days.[Type] = 2))
				   AND (((DATEPART(dw, '01.01.2009') + @@DateFirst + days.DayNumber - 3) % 7) < 5)
			
			SET @year = @year + 1
		END
	END

	RETURN DATEDIFF(day, @dateFrom, @dateTo) - @outDay
END
go