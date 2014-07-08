--8C688B6C-5E83-4208-A795-368D067C29EB

BEGIN

	SELECT DISTINCT
		   tasks.TaskID as TaskID, 
		   tasks.TaskState as TaskState,
		   tasks.TaskAuthor as TaskAuthor,
		   tasks.TaskSubject as TaskSubject,
		   CAST(tasks.TaskContents as nvarchar(max)) as TaskContents,
		   tasks.TaskDate as TaskDate,
		   tasks.TaskEndDate as TaskEndDate,
		   --
		   tasks.ToRead as ToRead,
		   tasks.Controller as Controller,
		   tasks.AssignmentState as AssignmentState,
		   tasks.ParentTaskID as ParentTaskID,
		   tasks.AssignmentType as AssignmentType,
		   --
		   CASE
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
			   CAST(outDocMainInfo.Subject as nvarchar(max))
			 WHEN directionMainInfo.InstanceID IS NOT NULL THEN
			   CAST(directionMainInfo.Content as nvarchar(max))
			 WHEN orderMainInfo.InstanceID IS NOT NULL THEN
			   CAST(orderMainInfo.Content as nvarchar(max))
			 WHEN incDocMainInfo.InstanceID IS NOT NULL THEN
			   CAST(incDocMainInfo.Subject as nvarchar(max))
			 WHEN lnaMainInfo.InstanceID IS NOT NULL THEN
			   CAST(lnaMainInfo.Subject as nvarchar(max))
			 WHEN protocolMainInfo.InstanceID IS NOT NULL THEN
			   CAST(protocolMainInfo.Subject as nvarchar(max))
			 WHEN NRDMainInfo.InstanceID IS NOT NULL THEN
			   CAST(NRDMainInfo.Subject as nvarchar(max))
		   END as DocumentText,
		   
		   CASE LEN(tasks.AssignedTo) 
			 WHEN 0 THEN ''
			 ELSE LEFT(tasks.AssignedTo, LEN(tasks.AssignedTo) - 1)
		   END as AssignedTo,
		   
		   CASE WHEN readStatus.UserID IS NULL THEN 1 ELSE 0 END as IsNew,
		   
		   CASE WHEN TaskEndDate IS NOT NULL AND TaskEndDate < GetDate() THEN 1 ELSE 0 END as IsOverdue,
		   --
		   CASE
			 WHEN contractMainInfo.InstanceID IS NOT NULL THEN 
				CASE WHEN contractMainInfo.State = 2 THEN 1 ELSE 0 END
			 WHEN directionMainInfo.InstanceID IS NOT NULL THEN 
				CASE WHEN directionMainInfo.State = 9 THEN 1 ELSE 0 END
			 WHEN directiveMainInfo.InstanceID IS NOT NULL THEN 
				CASE WHEN directiveMainInfo.State = 9 THEN 1 ELSE 0 END
			 WHEN orderMainInfo.InstanceID IS NOT NULL THEN 
				CASE WHEN orderMainInfo.State = 9 THEN 1 ELSE 0 END
			 WHEN outDocMainInfo.InstanceID IS NOT NULL THEN 
				CASE WHEN outDocMainInfo.State = 4 THEN 1 ELSE 0 END
			 WHEN protocolMainInfo.InstanceID IS NOT NULL THEN 
				CASE WHEN protocolMainInfo.State = 7 THEN 1 ELSE 0 END
			 WHEN universalApprovalMainInfo.InstanceID IS NOT NULL THEN 
				CASE WHEN universalApprovalMainInfo.State = 4 THEN 1 ELSE 0 END
			 WHEN memorandumMainInfo.InstanceID IS NOT NULL THEN 
				CASE WHEN memorandumMainInfo.State = 3 THEN 1 ELSE 0 END
			 WHEN NRDMainInfo.InstanceID IS NOT NULL THEN 
				CASE WHEN NRDMainInfo.State = 10 THEN 1 ELSE 0 END
		   END as ToImprove,
		   
		   CASE
		     WHEN contractMainInfo.InstanceID IS NOT NULL THEN 
				CASE WHEN contractMainInfo.State = 1 THEN 1 ELSE 0 END
			 WHEN directionMainInfo.InstanceID IS NOT NULL THEN 
				CASE WHEN directionMainInfo.State = 2 THEN 1 ELSE 0 END
			 WHEN directiveMainInfo.InstanceID IS NOT NULL THEN 
				CASE WHEN directiveMainInfo.State = 2 THEN 1 ELSE 0 END
			 WHEN orderMainInfo.InstanceID IS NOT NULL THEN 
				CASE WHEN orderMainInfo.State = 2 THEN 1 ELSE 0 END
			 WHEN outDocMainInfo.InstanceID IS NOT NULL THEN 
				CASE WHEN outDocMainInfo.State = 2 THEN 1 ELSE 0 END
			 WHEN protocolMainInfo.InstanceID IS NOT NULL THEN 
				CASE WHEN protocolMainInfo.State = 5 THEN 1 ELSE 0 END
			 WHEN universalApprovalMainInfo.InstanceID IS NOT NULL THEN 
				CASE WHEN universalApprovalMainInfo.State = 1 THEN 1 ELSE 0 END
			 WHEN memorandumMainInfo.InstanceID IS NOT NULL THEN 
				CASE WHEN memorandumMainInfo.State = 2 THEN 1 ELSE 0 END
			 WHEN NRDMainInfo.InstanceID IS NOT NULL THEN 
				CASE WHEN NRDMainInfo.State = 2 THEN 1 ELSE 0 END
		   END as ToApprove,
		   
		   CASE
			 WHEN contractMainInfo.InstanceID IS NOT NULL THEN 
				CASE WHEN contractMainInfo.State = 3 THEN 1 ELSE 0 END
			 WHEN directionMainInfo.InstanceID IS NOT NULL THEN 
				CASE WHEN directionMainInfo.State = 4 THEN 1 ELSE 0 END
			 WHEN directiveMainInfo.InstanceID IS NOT NULL THEN 
				CASE WHEN directiveMainInfo.State = 4 THEN 1 ELSE 0 END
			 WHEN orderMainInfo.InstanceID IS NOT NULL THEN 
				CASE WHEN orderMainInfo.State = 4 THEN 1 ELSE 0 END
			 WHEN outDocMainInfo.InstanceID IS NOT NULL THEN 
				CASE WHEN outDocMainInfo.State IN (3, 8) THEN 1 ELSE 0 END
			 WHEN protocolMainInfo.InstanceID IS NOT NULL THEN 
				CASE WHEN protocolMainInfo.State  IN (9, 6) THEN 1 ELSE 0 END
			 WHEN universalApprovalMainInfo.InstanceID IS NOT NULL THEN 
				CASE WHEN universalApprovalMainInfo.State IN (3, 6) THEN 1 ELSE 0 END
			 WHEN memorandumMainInfo.InstanceID IS NOT NULL THEN 
				CASE WHEN memorandumMainInfo.State = 7 THEN 1 ELSE 0 END
		   END as ToSign,
		   
		   CASE
			 WHEN incDocMainInfo.InstanceID IS NOT NULL THEN 
				CASE WHEN incDocMainInfo.State = 2 THEN 1 ELSE 0 END
		   END as IsIncoming,
		   
		   CASE 
			 WHEN NRDMainInfo.InstanceID IS NOT NULL THEN
				CASE WHEN NRDMainInfo.State IN (3, 4, 11) THEN 1 ELSE 0 END
			END AS IsNRDToCert,
		   
		   CASE
			 WHEN memorandumMainInfo.InstanceID IS NOT NULL THEN 
				CASE WHEN memorandumMainInfo.State = 5 THEN 1 ELSE 0 END
		   END as IsMemorandum,
		   
		   CASE
			 WHEN directionMainInfo.InstanceID IS NOT NULL THEN 
				CASE WHEN directionMainInfo.State = 5 THEN 1 ELSE 0 END
			 WHEN directiveMainInfo.InstanceID IS NOT NULL THEN 
				CASE WHEN directiveMainInfo.State = 5 THEN 1 ELSE 0 END
			 WHEN orderMainInfo.InstanceID IS NOT NULL THEN 
				CASE WHEN orderMainInfo.State = 5 THEN 1 ELSE 0 END
			 WHEN memorandumMainInfo.InstanceID IS NOT NULL THEN 
				CASE WHEN memorandumMainInfo.State = 8 THEN 1 ELSE 0 END
		   END as ToRegister,
		   
		   CAST (COALESCE (contractMainInfo.BarcodeNumber, memorandumMainInfo.BarcodeNumber, warrantMainInfo.BarcodeNumber, outDocMainInfo.BarcodeNumber, directionMainInfo.BarcodeNumber, 
		   orderMainInfo.BarcodeNumber, incDocMainInfo.BarcodeNumber, lnaMainInfo.BarcodeNumber, protocolMainInfo.BarcodeNumber, NRDMainInfo.BarcodeNumber) AS NVARCHAR(MAX)) AS Barcode,
		   CAST (COALESCE (contractMainInfo.RegistrationNumber, memorandumMainInfo.RegistrationNumber, warrantMainInfo.RegistrationNumber, outDocMainInfo.RegistrationNumber, directionMainInfo.RegistrationNumber, 
		   orderMainInfo.RegistrationNumber, incDocMainInfo.RegistrationNumber, lnaMainInfo.RegistrationNumber, protocolMainInfo.RegistrationNumber, NRDMainInfo.RegistrationNumber) AS NVARCHAR(MAX)) AS ParentDocRegNumber
		   --		   
	FROM   
		(
		SELECT task_MainInfo.InstanceID as TaskID,
			   task_Performing.[TaskState] as TaskState,
			   author.DisplayString as TaskAuthor,
			   instances.Description as TaskSubject,
			   task_MainInfo.[Comments] as TaskContents,
			   instances_date.[CreationDateTime] as TaskDate,
			   task_MainInfo.[ExpectedEndDate] as TaskEndDate,
			   --
			   task_AddSettings.[ToRead] as ToRead,
			   assignmentMainInfo.Controller as Controller,
			   assignmentMainInfo.State as AssignmentState,
			   assignmentMainInfo.ParentTaskID as ParentTaskID,
			   assignmentMainInfo.Type as AssignmentType,
			   --
			   '' + (select LastName + ' '
				  + CASE WHEN FirstName IS NULL THEN '' ELSE LEFT(FirstName,1) + '.' END 
				  + CASE WHEN MiddleName IS NULL THEN '' ELSE LEFT(MiddleName,1) + '.' END 
				  + ';' as 'data()' 
					from [dbo].[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] emp WITH (NOLOCK) 
				    inner join [dbo].[dvtable_{E3335F61-DBD9-447B-A539-4BF721FFD7B0}] assignmentMainInfo WITH (NOLOCK) 
					ON assignmentMainInfo.ParentTaskID = task_MainInfo.InstanceID 
					inner join [dbo].[dvtable_{80314B8B-4825-4205-9FE7-F6B294DA9113}] assignmentAssignees WITH (NOLOCK) 
					ON assignmentAssignees.Assignee = emp.RowID 
					WHERE assignmentAssignees.InstanceID = assignmentMainInfo.InstanceID 
					for xml path('')) as AssignedTo

		FROM   [dbo].[dvtable_{7213A125-2CA4-40EE-A671-B52850F45E7D}] task_MainInfo WITH (NOLOCK)
			   JOIN [dbo].[dvtable_{D48E6155-C774-4205-AB70-7A67AB69DF22}] task_Performing WITH (NOLOCK) ON task_Performing.InstanceID = task_MainInfo.InstanceID
			   JOIN [dbo].[dvtable_{B9FF9E65-FBDB-4883-A4F8-38D31F8322D6}] task_AddSettings WITH (NOLOCK) ON task_AddSettings.InstanceID = task_MainInfo.InstanceID
			   JOIN [dbo].[dvsys_instances] instances WITH (NOLOCK) ON instances.InstanceID = task_MainInfo.InstanceID
			   LEFT JOIN [dbo].[dvsys_instances_date] instances_date WITH (NOLOCK) ON instances_date.InstanceID = task_MainInfo.InstanceID
			   LEFT JOIN [dbo].[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] author WITH (NOLOCK) ON author.RowID = task_MainInfo.[CreatedBy]
			   LEFT JOIN [dbo].[dvtable_{80314B8B-4825-4205-9FE7-F6B294DA9113}] assignmentAssignees WITH (NOLOCK) ON assignmentAssignees.AssigneeTaskID = task_MainInfo.InstanceID
			   LEFT JOIN [dbo].[dvtable_{E3335F61-DBD9-447B-A539-4BF721FFD7B0}] assignmentMainInfo WITH (NOLOCK) ON assignmentMainInfo.InstanceID = assignmentAssignees.InstanceID
		WHERE  --ISNULL(task_MainInfo.[IsControllerTask], 0) = 0--
			   /*AND*/ task_Performing.TaskState in (2, 3, 4)
			   --AND ISNULL(task_AddSettings.[ToRead], 0) = 0--
			   AND ISNULL(instances.[Deleted], 0) = 0
			   AND EXISTS (SELECT 1 
						   FROM   [dbo].[dvtable_{9D09144D-CAEC-4732-AD4D-EB6A3864714A}] task_Performers WITH (NOLOCK)
						   WHERE  task_Performers.InstanceID = task_MainInfo.InstanceID
								  AND task_Performers.PerformerID = @employeeID)
		) tasks
		
		LEFT JOIN [dbo].[dvtable_{E1ED3A9F-E462-463C-8F63-D1BBFC7DEDED}] taskCardProp WITH (NOLOCK) ON taskCardProp.InstanceID = tasks.TaskID AND taskCardProp.[Name] = 'Карточка' AND taskCardProp.[Value] IS NOT NULL
		LEFT JOIN [dbo].[dvtable_{DAA76B4A-98F9-44BA-833C-DD874DB33214}] contractMainInfo WITH (NOLOCK) ON contractMainInfo.InstanceID = taskCardProp.[Value]
		LEFT JOIN [dbo].[dvtable_{B5D96F96-ACA2-4184-9702-2D89B1B3936A}] memorandumMainInfo WITH (NOLOCK) ON memorandumMainInfo.InstanceID = taskCardProp.[Value]
		LEFT JOIN [dbo].[dvtable_{EC83F06E-8131-4437-A573-C86B15A2AF5C}] warrantMainInfo WITH (NOLOCK) ON warrantMainInfo.InstanceID = taskCardProp.[Value]
		LEFT JOIN [dbo].[dvtable_{4C07CA25-41D6-438A-B73E-47FE7650C7BD}] outDocMainInfo WITH (NOLOCK) ON outDocMainInfo.InstanceID = taskCardProp.[Value]
		LEFT JOIN [dbo].[dvtable_{4130F43C-6DD5-4A5B-971E-AA134F7FB2E5}] directionMainInfo WITH (NOLOCK) ON directionMainInfo.InstanceID = taskCardProp.[Value]
		LEFT JOIN [dbo].[dvtable_{F875C7C6-A280-402D-BC56-36DEE6376EED}] orderMainInfo WITH (NOLOCK) ON orderMainInfo.InstanceID = taskCardProp.[Value]
		LEFT JOIN [dbo].[dvtable_{C06228B9-99F8-4B41-950B-8FACDC00A2B7}] incDocMainInfo WITH (NOLOCK) ON incDocMainInfo.InstanceID = taskCardProp.[Value]
		LEFT JOIN [dbo].[dvtable_{D766EC2A-EDB4-4153-ADD1-3BB7BCC89D0D}] lnaMainInfo WITH (NOLOCK) ON lnaMainInfo.InstanceID = taskCardProp.[Value]
		LEFT JOIN [dbo].[dvtable_{C00F1798-2E00-4493-801A-8A3BC4737FB2}] protocolMainInfo WITH (NOLOCK) ON protocolMainInfo.InstanceID = taskCardProp.[Value]
		LEFT JOIN [dbo].[dvtable_{086A474C-BDFD-472D-9A35-8EF9E9209A67}] directiveMainInfo WITH (NOLOCK) ON directiveMainInfo.InstanceID = taskCardProp.[Value]
		LEFT JOIN [dbo].[dvtable_{633A3831-70E0-4217-9119-7385B953A89B}] universalApprovalMainInfo WITH (NOLOCK) ON universalApprovalMainInfo.InstanceID = taskCardProp.[Value]
		LEFT JOIN [dbo].[dvtable_{9B99D82A-8B4A-429E-A76D-469FDD1F6A86}] NRDMainInfo WITH (NOLOCK) ON NRDMainInfo.InstanceID = taskCardProp.[Value]
		LEFT JOIN [dbo].[dvsys_users] users WITH (NOLOCK) ON users.AccountName = @accountName
		LEFT JOIN [dbo].[dvsys_instances_read] readStatus WITH (NOLOCK) ON readStatus.InstanceID = tasks.TaskID and readStatus.UserID = users.UserID		
	FOR BROWSE

END