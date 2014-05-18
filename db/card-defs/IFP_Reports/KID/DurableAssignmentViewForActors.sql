BEGIN

select [DocID] as [DocumentID]
      ,[DocRegDate] as [DocumentRegDate]
      --,[DocNumber] as [DocumentNumber]
      ,[DocContent] as [DocumentContent]
      ,[DocAuthor] as [DocumentAuthor]
      ,[DocDeadline] as [DocumentDeadline]
      ,[DocLastReport] as [DocumentLastReport]
      ,[LastReportDate] as [LastReportDate]
      ,[DocPerformer] as [DocumentPowerPerformer]
      ,([DocPerformer] +
	case when [DocCoperformers] is null then ''
	else case LEN([DocCoperformers]) when 0 then ','
		else ', ' + left([DocCoperformers], LEN([DocCoperformers]) - 2)
		end
	end) as [DocumentPerformers]
      ,[DocDescription] as [DocumentDescription]
	  ,[DocAssigneeProtocolItem] as [AssigneeDocItem]
	  ,(case when [ParentDocumentCard] is null then ('Поручение №' + CAST([DocNumber] as nvarchar) + ' от ' + convert(nvarchar, [DocRegDate], 104))
		else ('Протокол №' + (select [RegistrationNumber] + ' от ' + convert(nvarchar, [SessionDate], 104) from [dbo].[dvtable_{C00F1798-2E00-4493-801A-8A3BC4737FB2}] where [InstanceID] = [ParentDocumentCard]))
		end) as [DocumentNumber]
	  , [Percentage] as Percentage
	  , Reason as Reason 
from
(
   select  [InstanceID] as [DocID]
       ,[RegistrationDate] as [DocRegDate]
	   ,[RegistrationNumber] as [DocNumber]
	   ,[ParentDocument] as [ParentDocumentCard]
	   ,[Content] as [DocContent]
	   ,(select [DisplayString] from [dbo].[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] RefStaff where RefStaff.[RowID] = [Author]) as [DocAuthor]
	   ,(select [DisplayString] from [dbo].[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] RefStaff where RefStaff.[RowID] = [Performer]) as [DocPerformer]
	   ,[Deadline] as [DocDeadline]
	   ,[CurrentReport] as [DocLastReport]
	   ,[ReportUpdateDate] as [LastReportDate]
	   ,( select RefStaff.[DisplayString] + ', '  --as 'data ()' 
		  from [dbo].[dvtable_{15AE16C0-B562-4311-94DD-2E14C6542F5A}] Coperformers 
				left join [dbo].[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] RefStaff 
				on Coperformers.[Coperformer] = RefStaff.[RowID] 
		  where Coperformers.[InstanceID] = DurationAssignmentTable.[InstanceID] 
		  for xml path('') 
		) as [DocCoperformers]
	   , (select SYS.[Description] from [dbo].[dvsys_instances] SYS where SYS.[InstanceID] = DurationAssignmentTable.[InstanceID]) as [DocDescription] 
	   , [AssigneeDocItem] as [DocAssigneeProtocolItem]
	   , [Percentage] as Percentage
	   , Reason as Reason
	   
	from   [dbo].[dvtable_{99CD2DFC-9B28-48C6-AB65-19C0F3D9CCF3}] DurationAssignmentTable
	where  [State] = '1'
	and ((@actorID = [Author]) or (@actorID = [Controller]))
) Data

END
