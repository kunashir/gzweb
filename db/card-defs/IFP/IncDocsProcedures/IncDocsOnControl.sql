IF NOT OBJECT_ID('[dbo].[dvreport_get_data_{A435DF62-AB87-41AE-88D3-D3F7CDCA4C29}]') IS NULL
	DROP PROCEDURE [dbo].[dvreport_get_data_{A435DF62-AB87-41AE-88D3-D3F7CDCA4C29}]

--Delimiter
GO

CREATE PROCEDURE [dbo].[dvreport_get_data_{A435DF62-AB87-41AE-88D3-D3F7CDCA4C29}]
(@sender As uniqueidentifier = NULL,
@signedBy As uniqueidentifier = NULL,
@executer As uniqueidentifier = NULL,
@author As uniqueidentifier = NULL,
@recipient As uniqueidentifier = NULL,
@dateStart As datetime = NULL,
@dateEnd As datetime = NULL,
@removalFromControl As bit = NULL) WITH ENCRYPTION
AS
BEGIN



DECLARE @incdocs TABLE
(
	InstanceID uniqueidentifier,
	DocName nvarchar(max),
	RegistrationDate datetime,
	Recipients nvarchar(max),
	DocContent nvarchar(max),
	ControlTerm datetime,
	RemovalFromControl datetime,
	ControlState int,
	--Author nvarchar(max),
	--AuthorID uniqueidentifier,
	--Executer nvarchar(max),
	--ExecuterID uniqueidentifier,
	Comments nvarchar(max),
	IncDocIsOverdue int
)

INSERT INTO @incdocs
SELECT 
	IncDocs.InstanceID,
	IncDocs.DocName,
	IncDocs.RegistrationDate,
	IncDocs.Recipients,
	IncDocs.DocContent,
	IncDocs.ControlTerm,
	IncDocs.RemovalFromControl,
	IncDocs.ControlState,
	IncDocs.Comments,
	CASE WHEN ((@removalFromControl = 1 AND IncDocs.RemovalFromControl is not null AND IncDocs.RemovalFromControl > IncDocs.ControlTerm) 
	OR (@removalFromControl = 0 AND @dateStart > IncDocs.ControlTerm)) THEN 1 ELSE 0 END as IncDocIsOverdue   --((MainInfo.Finished is null or MainInfo.Finished > @startPeriod) AND MainInfo.Term is not null AND MainInfo.Term < @startPeriod) THEN 1 ELSE 0 END as IsOverdue
FROM 
(
SELECT 
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
MainInfo.RemovalFromControl,
MainInfo.ControlState, 
MainInfo.Report as Comments
FROM 
[dvtable_{C06228B9-99F8-4B41-950B-8FACDC00A2B7}] as MainInfo,
[dvtable_{1A46BF0F-2D02-4AC9-8866-5ADF245921E8}] as caEmployees,
[dvtable_{C78ABDED-DB1C-4217-AE0D-51A400546923}] as ca,
dvsys_Instances
WHERE
dvsys_Instances.InstanceID = MainInfo.InstanceID AND
(dvsys_Instances.Deleted is NULL or dvsys_Instances.Deleted <> 1) AND
MainInfo.SignedBy = caEmployees.RowID AND  
caEmployees.ParentRowID = ca.RowID AND
(@sender = '00000000-0000-0000-0000-000000000000' OR ca.RowID = @sender) AND
(@signedBy = '00000000-0000-0000-0000-000000000000' OR caEmployees.RowID = @signedBy) AND
(@recipient = '00000000-0000-0000-0000-000000000000' OR EXISTS(SELECT * FROM [dvtable_{FC138430-DE5D-47D2-BBD6-DA17D4DCF4CD}] as Recipients WHERE Recipients.Recipient = @recipient AND Recipients.InstanceID = MainInfo.InstanceID))	
) as IncDocs
WHERE 
((@removalFromControl = 1 AND IncDocs.RemovalFromControl is not null AND IncDocs.RemovalFromControl >= @dateStart AND IncDocs.RemovalFromControl <= @dateEnd)
OR (@removalFromControl = 0 AND ControlState = 1 AND IncDocs.RegistrationDate <= @dateStart AND (RemovalFromControl is null or RemovalFromControl > @dateStart)))
ORDER BY IncDocs.ControlTerm, IncDocs.InstanceID


DECLARE @instances TABLE (ID uniqueidentifier)

INSERT INTO @instances
SELECT DISTINCT InstanceID FROM @incdocs

DECLARE @assignment TABLE (IncDocID uniqueidentifier, TaskID uniqueidentifier, ExecuterID uniqueidentifier, Executer nvarchar(max), AuthorID uniqueidentifier, Author nvarchar(max), Commentaries nvarchar(max))

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

SELECT * FROM @incdocs As IncDocs
LEFT JOIN @assignment as Tasks ON Tasks.IncDocID = IncDocs.InstanceID
WHERE 
(@executer = '00000000-0000-0000-0000-000000000000' OR 
 EXISTS (SELECT * FROM @incdocs as docs WHERE docs.InstanceID = IncDocs.InstanceID AND Tasks.ExecuterID = @executer)) AND
(@author = '00000000-0000-0000-0000-000000000000' OR 
 EXISTS (SELECT * FROM @incdocs as docs WHERE docs.InstanceID = IncDocs.InstanceID AND Tasks.AuthorID = @author))

END