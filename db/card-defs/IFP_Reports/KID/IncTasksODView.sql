BEGIN
	SELECT DISTINCT
		   data.TaskID as TaskID,
           data.TaskState as TaskState,
		   data.TaskKind as TaskKind,
           data.TaskAuthor as TaskAuthor,
		   data.TaskSubject as TaskSubject,
           data.TaskContents as TaskContents,
           data.TaskDate as TaskDate,
           data.TaskEndDate as TaskEndDate,
           data.DocumentText as DocumentText,
           data.DocumentNumber as DocumentNumber,
           data.AssignedTo as AssignedTo,
           data.IsNew as IsNew,
		   data.Control as Control,
           data.IsOverdue as IsOverdue,
           data.IsOverdue as IsOverdue2,
		   ResponsibleDep.Name as DocumentResponsible,
		   CASE
				WHEN partnerCompany.RowID IS NOT NULL THEN
					partnerCompany.[Name]
				ELSE
				   CASE LEN(data.WhereTo)
					 WHEN 0 THEN ''
					 ELSE LEFT(data.WhereTo, LEN(data.WhereTo) - 1)
				   END
		   END as WhereFrom,
           data.TaskActualEndDate as TaskActualEndDate
	FROM
	(
		SELECT DISTINCT
			   tasks.TaskID as TaskID, 
			   tasks.TaskState as TaskState,
			   tasks.TaskAuthor as TaskAuthor,
			   tasks.TaskSubject as TaskSubject,
			   taskKindProp.DisplayValue as TaskKind,
			   CAST(tasks.TaskContents as nvarchar(max)) as TaskContents,
			   tasks.TaskDate as TaskDate,
			   tasks.TaskEndDate as TaskEndDate,
			   tasks.TaskActualEndDate as TaskActualEndDate,
			   CASE
				 WHEN memorandumMainInfo.InstanceID IS NOT NULL THEN
					CASE WHEN memorandumMainInfo.ControlState = 1 THEN 'K' ELSE '' END
				 WHEN incDocMainInfo.InstanceID IS NOT NULL THEN
					CASE WHEN incDocMainInfo.ControlState = 1 THEN 'K' ELSE '' END
			   END as Control,
			   CASE
				 WHEN contractMainInfo.InstanceID IS NOT NULL THEN
				   CAST(contractMainInfo.Description as nvarchar(max))
				 WHEN memorandumMainInfo.InstanceID IS NOT NULL THEN
				   CAST(memorandumMainInfo.Content as nvarchar(max))
				 WHEN warrantMainInfo.InstanceID IS NOT NULL THEN
				   CAST(warrantMainInfo.GrantedPower as nvarchar(max))
				 WHEN outDocMainInfo.InstanceID IS NOT NULL THEN
				   CAST(outDocMainInfo.Topic as nvarchar(max))
				 WHEN directionMainInfo.InstanceID IS NOT NULL THEN
				   CAST(directionMainInfo.Subject as nvarchar(max))
				 WHEN orderMainInfo.InstanceID IS NOT NULL THEN
				   CAST(orderMainInfo.Subject as nvarchar(max))
				 WHEN incDocMainInfo.InstanceID IS NOT NULL THEN
				   CAST(incDocMainInfo.Subject as nvarchar(max))
				 WHEN lnaMainInfo.InstanceID IS NOT NULL THEN
				   CAST(lnaMainInfo.Subject as nvarchar(max))
				 WHEN protocolMainInfo.InstanceID IS NOT NULL THEN
				   CAST(protocolMainInfo.Subject as nvarchar(max))
			   END as DocumentText,
			   CASE
				 WHEN contractMainInfo.InstanceID IS NOT NULL THEN
				   contractMainInfo.Responsible
				 WHEN memorandumMainInfo.InstanceID IS NOT NULL THEN
				   memorandumMainInfo.Executer
				 WHEN warrantMainInfo.InstanceID IS NOT NULL THEN
				   warrantMainInfo.Representative
				 WHEN outDocMainInfo.InstanceID IS NOT NULL THEN
				   outDocMainInfo.Executer
				 WHEN directionMainInfo.InstanceID IS NOT NULL THEN
				   directionMainInfo.Executer
				 WHEN orderMainInfo.InstanceID IS NOT NULL THEN
				   orderMainInfo.Executer
				 WHEN incDocMainInfo.InstanceID IS NOT NULL THEN
				   incDocMainInfo.Registrator
				 WHEN protocolMainInfo.InstanceID IS NOT NULL THEN
				   protocolMainInfo.Chairman
			   END as DocumentResponsible,
			   CASE
				 WHEN contractMainInfo.InstanceID IS NOT NULL THEN
				   CAST(contractMainInfo.RegistrationNumber as nvarchar(max))
				 WHEN memorandumMainInfo.InstanceID IS NOT NULL THEN
				   CAST(memorandumMainInfo.RegistrationNumber as nvarchar(max))
				 WHEN warrantMainInfo.InstanceID IS NOT NULL THEN
				   CAST(warrantMainInfo.RegistrationNumber as nvarchar(max))
				 WHEN outDocMainInfo.InstanceID IS NOT NULL THEN
				   CAST(outDocMainInfo.RegistrationNumber as nvarchar(max))
				 WHEN directionMainInfo.InstanceID IS NOT NULL THEN
				   CAST(directionMainInfo.RegistrationNumber as nvarchar(max))
				 WHEN orderMainInfo.InstanceID IS NOT NULL THEN
				   CAST(orderMainInfo.RegistrationNumber as nvarchar(max))
				 WHEN incDocMainInfo.InstanceID IS NOT NULL THEN
				   CAST(incDocMainInfo.RegistrationNumber as nvarchar(max))
				 WHEN lnaMainInfo.InstanceID IS NOT NULL THEN
				   CAST(lnaMainInfo.RegistrationNumber as nvarchar(max))
				 WHEN protocolMainInfo.InstanceID IS NOT NULL THEN
				   CAST(protocolMainInfo.RegistrationNumber as nvarchar(max))
			   END as DocumentNumber,
			   CASE LEN(tasks.AssignedTo) 
				 WHEN 0 THEN ''
				 ELSE LEFT(tasks.AssignedTo, LEN(tasks.AssignedTo) - 1)
			   END as AssignedTo,
			   CASE WHEN readStatus.UserID IS NULL THEN 1 ELSE 0 END as IsNew,
			   CASE WHEN TaskEndDate IS NOT NULL AND TaskEndDate < GetDate() THEN 1 ELSE 0 END as IsOverdue,
			   CASE 
				 WHEN contractMainInfo.InstanceID IS NOT NULL THEN
				   contractMainInfo.Counteragent
				 WHEN incDocMainInfo.InstanceID IS NOT NULL THEN
				   partnerEmployee.ParentRowID
			   END as PartnerCompanyID,
			   CASE
				WHEN outDocMainInfo.InstanceID IS NOT NULL THEN
				   '' + (select counteragent.[Name] + '; ' as 'data()' 
							from [dbo].[dvtable_{C78ABDED-DB1C-4217-AE0D-51A400546923}] counteragent 
							inner join [dbo].[dvtable_{8F135BE7-9544-4E7E-937F-2551378D0EBB}] outDocRecipient
							ON outDocRecipient.InstanceID = outDocMainInfo.InstanceID AND counteragent.RowID = outDocRecipient.Organization
							for xml path('')) 
				END as WhereTo
			FROM   
			(
			SELECT task_MainInfo.InstanceID as TaskID,
				   task_Performing.[TaskState] as TaskState,
				   author.DisplayString as TaskAuthor,
				   instances.Description as TaskSubject,
				   task_MainInfo.[Comments] as TaskContents,
				   instances_date.[CreationDateTime] as TaskDate,
				   task_MainInfo.[ExpectedEndDate] as TaskEndDate,
				   task_Performing.[ActualEndDate] as TaskActualEndDate,
				   '' + (select LastName + ' '
					  + CASE WHEN FirstName IS NULL THEN '' ELSE LEFT(FirstName,1) + '.' END 
					  + CASE WHEN MiddleName IS NULL THEN '' ELSE LEFT(MiddleName,1) + '.' END 
					  + ';' as 'data()' 
						from [dbo].[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] emp 
						inner join [dbo].[dvtable_{E3335F61-DBD9-447B-A539-4BF721FFD7B0}] assignmentMainInfo 
						ON assignmentMainInfo.ParentTaskID = task_MainInfo.InstanceID 
						inner join [dbo].[dvtable_{80314B8B-4825-4205-9FE7-F6B294DA9113}] assignmentAssignees 
						ON assignmentAssignees.Assignee = emp.RowID 
						WHERE assignmentAssignees.InstanceID = assignmentMainInfo.InstanceID 
						for xml path('')) as AssignedTo

			FROM   [dbo].[dvtable_{7213A125-2CA4-40EE-A671-B52850F45E7D}] task_MainInfo
				   JOIN [dbo].[dvtable_{D48E6155-C774-4205-AB70-7A67AB69DF22}] task_Performing ON task_Performing.InstanceID = task_MainInfo.InstanceID
				   JOIN [dbo].[dvtable_{B9FF9E65-FBDB-4883-A4F8-38D31F8322D6}] task_AddSettings ON task_AddSettings.InstanceID = task_MainInfo.InstanceID
				   JOIN [dbo].[dvsys_instances] instances ON instances.InstanceID = task_MainInfo.InstanceID
				   LEFT JOIN [dbo].[dvsys_instances_date] instances_date ON instances_date.InstanceID = task_MainInfo.InstanceID
				   LEFT JOIN [dbo].[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] author ON author.RowID = task_MainInfo.[CreatedBy]
			WHERE  ISNULL(task_MainInfo.[IsControllerTask], 0) = 0
				   AND task_Performing.TaskState in (2, 3, 4)
				   AND (task_MainInfo.[Comments] NOT LIKE N'%Вам необходимо присвоить регистрационный номер и дату регистрации%' ESCAPE '#')
				   AND (task_MainInfo.[Comments] NOT LIKE N'%Вам необходимо проверить комплектность документов, распечатать документы%' ESCAPE '#')
				   AND (task_MainInfo.[Comments] NOT LIKE N'%Вам необходимо отсканировать подписанное распоряжение%' ESCAPE '#')
				   AND (task_MainInfo.[Comments] NOT LIKE N'%Вам необходимо отсканировать подписанный приказ%' ESCAPE '#')
				   AND ISNULL(task_AddSettings.[ToRead], 0) = 0
				   AND ISNULL(instances.[Deleted], 0) = 0
				   AND EXISTS (SELECT 1 
							   FROM   [dbo].[dvtable_{9D09144D-CAEC-4732-AD4D-EB6A3864714A}] task_Performers
							   WHERE  task_Performers.InstanceID = task_MainInfo.InstanceID
									  AND task_Performers.PerformerID = @employeeID)
			) tasks
			LEFT JOIN [dbo].[dvtable_{E1ED3A9F-E462-463C-8F63-D1BBFC7DEDED}] taskCardProp ON taskCardProp.InstanceID = tasks.TaskID AND taskCardProp.[Name] = 'Карточка' AND taskCardProp.[Value] IS NOT NULL
			LEFT JOIN [dbo].[dvtable_{E1ED3A9F-E462-463C-8F63-D1BBFC7DEDED}] taskKindProp ON taskKindProp.InstanceID = tasks.TaskID AND taskKindProp.[Name] = 'Вид поручения' AND taskKindProp.[Value] IS NOT NULL
			LEFT JOIN [dbo].[dvtable_{DAA76B4A-98F9-44BA-833C-DD874DB33214}] contractMainInfo ON contractMainInfo.InstanceID = taskCardProp.[Value]
			LEFT JOIN [dbo].[dvtable_{B5D96F96-ACA2-4184-9702-2D89B1B3936A}] memorandumMainInfo ON memorandumMainInfo.InstanceID = taskCardProp.[Value]
			LEFT JOIN [dbo].[dvtable_{EC83F06E-8131-4437-A573-C86B15A2AF5C}] warrantMainInfo ON warrantMainInfo.InstanceID = taskCardProp.[Value]
			LEFT JOIN [dbo].[dvtable_{4C07CA25-41D6-438A-B73E-47FE7650C7BD}] outDocMainInfo ON outDocMainInfo.InstanceID = taskCardProp.[Value]
			LEFT JOIN [dbo].[dvtable_{4130F43C-6DD5-4A5B-971E-AA134F7FB2E5}] directionMainInfo ON directionMainInfo.InstanceID = taskCardProp.[Value]
			LEFT JOIN [dbo].[dvtable_{F875C7C6-A280-402D-BC56-36DEE6376EED}] orderMainInfo ON orderMainInfo.InstanceID = taskCardProp.[Value]
			LEFT JOIN [dbo].[dvtable_{C06228B9-99F8-4B41-950B-8FACDC00A2B7}] incDocMainInfo ON incDocMainInfo.InstanceID = taskCardProp.[Value]
			LEFT JOIN [dbo].[dvtable_{D766EC2A-EDB4-4153-ADD1-3BB7BCC89D0D}] lnaMainInfo ON lnaMainInfo.InstanceID = taskCardProp.[Value]
			LEFT JOIN [dbo].[dvtable_{C00F1798-2E00-4493-801A-8A3BC4737FB2}] protocolMainInfo ON protocolMainInfo.InstanceID = taskCardProp.[Value]
			LEFT JOIN [dbo].[dvtable_{1A46BF0F-2D02-4AC9-8866-5ADF245921E8}] partnerEmployee ON partnerEmployee.RowID = incDocMainInfo.SignedBy
			LEFT JOIN [dbo].[dvsys_users] users ON users.AccountName = @accountName
			LEFT JOIN [dbo].[dvsys_instances_read] readStatus ON readStatus.InstanceID = tasks.TaskID and readStatus.UserID = users.UserID
	) data
		LEFT JOIN [dbo].[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] responsible ON responsible.RowID = data.DocumentResponsible
		LEFT JOIN [dbo].[dvtable_{7473F07F-11ED-4762-9F1E-7FF10808DDD1}] responsibleDep ON responsibleDep.RowID = responsible.ParentRowID
		LEFT JOIN [dbo].[dvtable_{C78ABDED-DB1C-4217-AE0D-51A400546923}] partnerCompany ON partnerCompany.RowID = data.PartnerCompanyID

	FOR BROWSE

END