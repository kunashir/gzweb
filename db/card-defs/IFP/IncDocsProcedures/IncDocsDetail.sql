IF NOT OBJECT_ID('[dbo].[dvreport_get_data_{506754BE-915C-40A6-BF98-C7F32D6CB436}]') IS NULL
	DROP PROCEDURE [dbo].[dvreport_get_data_{506754BE-915C-40A6-BF98-C7F32D6CB436}]

--Delimiter
GO

CREATE PROCEDURE [dbo].[dvreport_get_data_{506754BE-915C-40A6-BF98-C7F32D6CB436}]
(@guids As ntext)
AS
BEGIN

DECLARE @instances TABLE (ID uniqueidentifier)

insert into @instances
select CONVERT(uniqueidentifier, Cards.Items) from [dbo].[idocfn_split_string](@guids,';') as Cards
where Cards.Items is not null

DECLARE @assignment TABLE (IncDocID uniqueidentifier, TaskID uniqueidentifier, AssigneeID uniqueidentifier, Assignee nvarchar(max), AuthorID uniqueidentifier, Author nvarchar(max), Comments nvarchar(max))

declare @Counter int       
select @Counter = COUNT(*) from  @instances
declare @item uniqueidentifier
	while @Counter !=0         
	begin         
		select @item = ID from @instances 
		delete from @instances where ID = @item
		insert into @assignment
		execute dbo.[GetIncDoc1stBranchTasks] @item
		SET @Counter = @Counter - 1
	end 

insert into @instances
select CONVERT(uniqueidentifier, Cards.Items) from [dbo].[idocfn_split_string](@guids,';') as Cards
where Cards.Items is not null


SELECT 
IncDocs.InstanceID,
IncDocs.DocName,
IncDocs.RegistrationDate,
IncDocs.Recipients,
IncDocs.DocContent,
IncDocs.ControlTerm,
Tasks.Author,
Tasks.Assignee as Executer,
Tasks.Comments,
IncDocs.RemovalFromControl
FROM 
(SELECT 
MainInfo.InstanceID,
/*формируем название документа в виде "Рег. № от Дата регистрации, Орг Отправителя, Подписант"*/
MainInfo.RegistrationNumber + ' от ' + 
convert(varchar, MainInfo.RegistrationDate, 104) + ', ' + ca.Name + ', ' + 
caEmployees.LastName + ' ' + CASE WHEN caEmployees.FirstName IS NULL THEN '' ELSE LEFT(caEmployees.FirstName,1) + '.' END 
+ CASE WHEN caEmployees.MiddleName IS NULL THEN '' ELSE LEFT(caEmployees.MiddleName,1) + '.' END AS DocName,
MainInfo.RegistrationDate,
 /*список получателей*/ 
 '' + (select LastName + ' '
				  + CASE WHEN FirstName IS NULL THEN '' ELSE LEFT(FirstName,1) + '.' END 
				  + CASE WHEN MiddleName IS NULL THEN '' ELSE LEFT(MiddleName,1) + '.' END 
				  + ';' as 'data()' 
					from [dbo].[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] emp 
					inner join [dbo].[dvtable_{FC138430-DE5D-47D2-BBD6-DA17D4DCF4CD}] Recipients 
					ON Recipients.Recipient = emp.RowID 
					WHERE Recipients.InstanceID = MainInfo.InstanceID 
					for xml path('')) as Recipients,

MainInfo.Subject as DocContent,
MainInfo.Term as ControlTerm,
MainInfo.RemovalFromControl
FROM 
[dvtable_{C06228B9-99F8-4B41-950B-8FACDC00A2B7}] as MainInfo,
[dvtable_{1A46BF0F-2D02-4AC9-8866-5ADF245921E8}] as caEmployees,
[dvtable_{C78ABDED-DB1C-4217-AE0D-51A400546923}] as ca,
@instances as IncDocs,
dvsys_Instances
WHERE
dvsys_Instances.InstanceID = MainInfo.InstanceID AND
IncDocs.ID = MainInfo.InstanceID AND
(dvsys_Instances.Deleted is NULL or dvsys_Instances.Deleted <> 1) AND
MainInfo.SignedBy = caEmployees.RowID AND  
caEmployees.ParentRowID = ca.RowID
) as IncDocs
LEFT JOIN @assignment As Tasks ON Tasks.IncDocID = IncDocs.InstanceID  
ORDER BY IncDocs.ControlTerm, IncDocs.InstanceID

END

GO

EXEC [dbo].[dvreport_get_data_{506754BE-915C-40A6-BF98-C7F32D6CB436}] '{7B632DC3-FF52-4171-95AF-97D4D745C4DA};{58C7085C-63D2-412F-A80F-4AE1E3591C62};{E205DAB4-C545-4C9A-998D-7059BD762FCD}'