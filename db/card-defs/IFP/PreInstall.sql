-------------------------------------------------------------------------------
-- Pre-install
-------------------------------------------------------------------------------

-- VERSION 1.47.150
-- E-mail уведомления исполнителя и соисполнителей о неисполненных длительных поручениях определенного автора

IF NOT OBJECT_ID('[dbo].[IDoc_DurableAssignmentNotification]') IS NULL
	DROP PROCEDURE [dbo].[IDoc_DurableAssignmentNotification]

GO

CREATE PROCEDURE [dbo].[IDoc_DurableAssignmentNotification] 
(
	@author as uniqueidentifier	
)
AS
BEGIN
	if OBJECT_ID('[dbo].[dvtable_{D4196376-3B30-4DE4-A67D-AFC3754DB131}]') IS NULL
		return

	insert into [dbo].[dvtable_{D4196376-3B30-4DE4-A67D-AFC3754DB131}] 
	([RowID], [InstanceID], [ParentRowID], [ParentTreeRowID], [Data], [MailTo], [Subject], [Body])
	(
		select NEWID(), NEWID(), '00000000-0000-0000-0000-000000000000', '00000000-0000-0000-0000-000000000000', GETDATE(), [EMailAddress], 
		'Неисполненные длительные поручения', 
		cast(
			'У Вас есть незавершенные поручения автора ''' 
			+ ltrim(rtrim((select DisplayString from [dbo].[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] where @author = RowID))) 
			+ '''. Количество поручений: ' + cast(count(*) as nvarchar)
			+ '. Пожалуйста, перейдите к отчету по поручениям в вашей личной папке и внесите информацию по исполнению.'
			as nvarchar(max))
		from
		(
			-- Выборка исполнителей поручений автора, которые еще не выполнены
			select DurableAssignmentMainInfo.[InstanceID] as 'CardID', RefStaff.[Email] as [EMailAddress]
			from [dbo].[dvtable_{99CD2DFC-9B28-48C6-AB65-19C0F3D9CCF3}] DurableAssignmentMainInfo
					join [dbo].[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] RefStaff
					on DurableAssignmentMainInfo.[Performer] = RefStaff.[RowID]
			where DurableAssignmentMainInfo.[Author] = @author
				  and DurableAssignmentMainInfo.[State] not in (0, 3, 4)
				  and RefStaff.[Email] is not null
			union 

			-- Выборка соисполнителей поручений автора, которые еще не выполнены
			select DurableAssignmentMainInfo.[InstanceID] as 'CardID', RefStaff.[Email] as [EMailAddress]
			from [dbo].[dvtable_{99CD2DFC-9B28-48C6-AB65-19C0F3D9CCF3}] DurableAssignmentMainInfo
				 join [dbo].[dvtable_{15AE16C0-B562-4311-94DD-2E14C6542F5A}] DurableAssignmentCoperformers
				 on DurableAssignmentMainInfo.[RowID] = DurableAssignmentCoperformers.[ParentRowID]    
					join [dbo].[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] RefStaff
					on DurableAssignmentCoperformers.[Coperformer] = RefStaff.[RowID]     
			where DurableAssignmentMainInfo.[Author] = @author
				  and DurableAssignmentMainInfo.[State] not in (0, 3, 4)
				  and RefStaff.[Email] is not null

		) as Data
		group by [EMailAddress]
	)
END
--Delimiter
GO

-- JOB FOR DurableAssignmentNotification
DECLARE @CurDBName varchar(256)
SELECT @CurDBName = DB_NAME()

DECLARE @JobName varchar(256)
SELECT @JobName = 'idocjob_' + @CurDBName + '_DurableAssignmentNotification'

IF EXISTS(SELECT * FROM msdb.dbo.sysjobs WHERE name = @JobName)
	EXECUTE msdb.dbo.sp_delete_job @job_name=@JobName

-- Create job
EXECUTE msdb.dbo.sp_add_job @job_name=@JobName
EXECUTE msdb.dbo.sp_add_jobstep @job_name=@JobName, @step_id=1, @step_name='DurableAssignmentNotification', @command='execute IDoc_DurableAssignmentNotification', @database_name=@CurDBName
EXECUTE msdb.dbo.sp_add_jobschedule @job_name=@JobName, @name='period_run', @freq_type=4, @freq_interval=1, @freq_subday_type=1, @active_start_time=060000
EXECUTE msdb.dbo.sp_add_jobserver @job_name=@JobName
--Delimiter
GO

-- VERSION 1.27.122
-- DROPPING OLD MONITORING LOG TABLE
IF NOT OBJECT_ID('[dbo].[dvtable_{F5A2EBBE-4252-42AC-BFAB-7C39557916FC}]') IS NULL
	DROP TABLE [dbo].[dvtable_{F5A2EBBE-4252-42AC-BFAB-7C39557916FC}]
GO
-- CREATING MonitoringLog Table
IF OBJECT_ID('[dbo].[idoc_MonitoringLog]') IS NULL
BEGIN
	CREATE TABLE [dbo].[idoc_MonitoringLog](
		[Handler] [uniqueidentifier] NULL,
		[Date] [datetime] NOT NULL,
		[Level] [int] NOT NULL,
		[Message] [ntext] COLLATE Cyrillic_General_CI_AS NULL,
	    [Timestamp] [Timestamp] NOT NULL
	) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

	IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[idoc_MonitoringLog]') AND name = N'IX_idoc_MonitoringLog_Date')
		DROP INDEX [IX_idoc_MonitoringLog_Date] ON [dbo].[idoc_MonitoringLog] WITH ( ONLINE = OFF )

	CREATE NONCLUSTERED INDEX [IX_idoc_MonitoringLog_Date] ON [dbo].[idoc_MonitoringLog] 
	(
		[Date] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

	IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[idoc_MonitoringLog]') AND name = N'IX_idoc_MonitoringLog_Level')
		DROP INDEX [IX_idoc_MonitoringLog_Level] ON [dbo].[idoc_MonitoringLog] WITH ( ONLINE = OFF )

	CREATE NONCLUSTERED INDEX [IX_idoc_MonitoringLog_Level] ON [dbo].[idoc_MonitoringLog] 
	(
		[Level] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
END
GO
-- ASSIGNING WFTaskUI for WFTask card
UPDATE [dvsys_carddefs]
SET    ControlInfo = 'clsid:{C07B3200-5E57-4301-BF75-154AFA01D80A}'
WHERE  Alias = 'WorkflowTask'
GO
