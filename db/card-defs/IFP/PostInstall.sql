-------------------------------------------------------------------------------
-- Post-install
-------------------------------------------------------------------------------

-- VERSION 1.46.148

-- ADDING StartNRD Monitoring

--PROCEDURE Start NRD with suitable StartDate
IF NOT OBJECT_ID('[dbo].[idoc_StartNRDwithSuitableStartDate]') IS NULL
	DROP PROCEDURE [dbo].[idoc_StartNRDwithSuitableStartDate]
GO
CREATE PROCEDURE [dbo].[idoc_StartNRDwithSuitableStartDate]
AS
BEGIN
	declare @currentDate datetime
	set @currentDate = GETDATE();
	
	update [dvtable_{9B99D82A-8B4A-429E-A76D-469FDD1F6A86}] set [State] = '6'
	where [State] = '11' and datediff(day, @currentDate, [StartDate]) <= 0	
END

--Delimiter
GO

-- JOB FOR StartNRDwithSuitableStartDate
DECLARE @CurDBName varchar(256)
SELECT @CurDBName = DB_NAME()

DECLARE @JobName varchar(256)
SELECT @JobName = 'idoc_' + @CurDBName + '_StartNRDwithSuitableStartDate'

IF EXISTS(SELECT * FROM msdb.dbo.sysjobs WHERE name = @JobName)
	EXECUTE msdb.dbo.sp_delete_job @job_name=@JobName

-- Create job
EXECUTE msdb.dbo.sp_add_job @job_name=@JobName
EXECUTE msdb.dbo.sp_add_jobstep @job_name=@JobName, @step_id=1, @step_name='StartNRD', @command='execute idoc_StartNRDwithSuitableStartDate', @database_name=@CurDBName
EXECUTE msdb.dbo.sp_add_jobschedule @job_name=@JobName, @name='period_run', @freq_type=4, @freq_interval=1, @freq_subday_type=1, @active_start_time=060000
EXECUTE msdb.dbo.sp_add_jobserver @job_name=@JobName

--Delimiter
GO

-- ADDING Substitutions Monitoring

--PROCEDURE Make Planned Substitutions
IF NOT OBJECT_ID('[dbo].[idoc_MakePlannedSubstitutions]') IS NULL
	DROP PROCEDURE [dbo].[idoc_MakePlannedSubstitutions]
GO
CREATE PROCEDURE [dbo].[idoc_MakePlannedSubstitutions]
AS
BEGIN

	declare @substitutions table(Identifier uniqueidentifier, EmployeeID uniqueidentifier, SubstituteID uniqueidentifier)
	declare @currentDate datetime
	set @currentDate = GETDATE();

	insert into @substitutions
	select Substitutions.RowID as Identifier,
	Substitutions.Employee as EmployeeID,
	Substitutions.Substitute as SubstituteID
	from [dvtable_{C01049C0-940F-490C-8A0A-4C10E9EDF2F6}] as Substitutions
	where datediff(day, @currentDate, Substitutions.PlannedStartDate) <= 0 
	AND (Substitutions.StartDate is NULL OR datediff(day, Substitutions.StartDate, '1899.12.30') = 0)
	
	declare @Counter int
	select @Counter = COUNT(*) from  @substitutions
	
	declare @ItemIdentifier uniqueidentifier
	declare @ItemEmployeeID uniqueidentifier
	declare @ItemSubstituteID uniqueidentifier
	
	while @Counter !=0         
	begin 
		select @ItemIdentifier = Identifier, @ItemEmployeeID = EmployeeID, @ItemSubstituteID = SubstituteID from @substitutions 
		delete from @substitutions where Identifier = @ItemIdentifier
		
		declare @ParentRow uniqueidentifier
		declare @Instance uniqueidentifier
		declare @SDID uniqueidentifier
		select @ParentRow = RowID, @Instance = InstanceID, @SDID = SDID from [dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] where RowID = @ItemEmployeeID
		--Employee Status
		update [dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] set [Status] = 4 where [RowID] = @ItemEmployeeID
		--Employee Deputies
		declare @countDeputiesForSubstitute int
		select @countDeputiesForSubstitute = COUNT(*) from [dvtable_{ED414CB4-B205-4BE4-A2FA-5C0D3347CEB3}] as EmployeeDeputies
		where EmployeeDeputies.DeputyID = @ItemSubstituteID AND EmployeeDeputies.ParentRowID = @ParentRow
		
		delete from [dvtable_{ED414CB4-B205-4BE4-A2FA-5C0D3347CEB3}]
		where [DeputyID] <> @ItemSubstituteID AND [ParentRowID] = @ParentRow
		
		if @countDeputiesForSubstitute = 0
		begin
			insert into [dvtable_{ED414CB4-B205-4BE4-A2FA-5C0D3347CEB3}] ([RowID], [InstanceID], [ParentRowID], [DeputyID], [Performing], [Control], [Order]) values (NEWID(), @Instance, @ParentRow, @ItemSubstituteID, '1', '1', '1')
		end
		--Substitution StartDate
		update [dvtable_{C01049C0-940F-490C-8A0A-4C10E9EDF2F6}] set [StartDate] = @currentDate where [RowID] = @ItemIdentifier
		
		set @Counter = @Counter - 1
	end

END

--Delimiter
GO

--PROCEDURE Remove Planned Substitutions
IF NOT OBJECT_ID('[dbo].[idoc_RemovePlannedSubstitutions]') IS NULL
	DROP PROCEDURE [dbo].[idoc_RemovePlannedSubstitutions]
GO
CREATE PROCEDURE [dbo].[idoc_RemovePlannedSubstitutions]
AS
BEGIN

	declare @substitutions table(Identifier uniqueidentifier, EmployeeID uniqueidentifier, SubstituteID uniqueidentifier)
	declare @currentDate datetime
	set @currentDate = GETDATE();

	insert into @substitutions
	select Substitutions.RowID as Identifier,
	Substitutions.Employee as EmployeeID,
	Substitutions.Substitute as SubstituteID
	from [dvtable_{C01049C0-940F-490C-8A0A-4C10E9EDF2F6}] as Substitutions
	where datediff(day, @currentDate, Substitutions.PlannedEndDate) <= 0 
	AND (Substitutions.EndDate is NULL OR datediff(day, Substitutions.EndDate, '1899.12.30') = 0)
	
	declare @Counter int
	select @Counter = COUNT(*) from  @substitutions
	
	declare @ItemIdentifier uniqueidentifier
	declare @ItemEmployeeID uniqueidentifier
	declare @ItemSubstituteID uniqueidentifier
	
	while @Counter !=0         
	begin 
		select @ItemIdentifier = Identifier, @ItemEmployeeID = EmployeeID, @ItemSubstituteID = SubstituteID from @substitutions 
		delete from @substitutions where Identifier = @ItemIdentifier
		
		declare @ParentRow uniqueidentifier
		declare @Instance uniqueidentifier
		declare @SDID uniqueidentifier
		select @ParentRow = RowID, @Instance = InstanceID, @SDID = SDID from [dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] where RowID = @ItemEmployeeID
		--Employee Status
		update [dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] set [Status] = 0 where [RowID] = @ItemEmployeeID
		--Employee Deputies
		delete from [dvtable_{ED414CB4-B205-4BE4-A2FA-5C0D3347CEB3}]
		where [DeputyID] = @ItemSubstituteID AND [ParentRowID] = @ParentRow
		
		--Substitution EndDate
		update [dvtable_{C01049C0-940F-490C-8A0A-4C10E9EDF2F6}] set [EndDate] = @currentDate where [RowID] = @ItemIdentifier
		
		set @Counter = @Counter - 1
	end

END

--Delimiter
GO

-- JOB FOR SubstitutionsMonitoring
DECLARE @CurDBName varchar(256)
SELECT @CurDBName = DB_NAME()

DECLARE @JobName varchar(256)
SELECT @JobName = 'ido_' + @CurDBName + '_SubstitutionsMonitoring'

IF EXISTS(SELECT * FROM msdb.dbo.sysjobs WHERE name = @JobName)
	EXECUTE msdb.dbo.sp_delete_job @job_name=@JobName

-- Create job
EXECUTE msdb.dbo.sp_add_job @job_name=@JobName
EXECUTE msdb.dbo.sp_add_jobstep @job_name=@JobName, @step_id=1, @step_name='MakeSubstitutions', @command='execute idoc_MakePlannedSubstitutions', @database_name=@CurDBName
EXECUTE msdb.dbo.sp_add_jobstep @job_name=@JobName, @step_id=2, @step_name='RemoveSubstitutions', @command='execute idoc_RemovePlannedSubstitutions', @database_name=@CurDBName
EXECUTE msdb.dbo.sp_add_jobschedule @job_name=@JobName, @name='period_run', @freq_type=4, @freq_interval=1, @freq_subday_type=1, @active_start_time=060000
EXECUTE msdb.dbo.sp_add_jobserver @job_name=@JobName

--Delimiter
GO

-- VERSION 1.30.126
-- TRIGGERS FOR unique partners functional
update [dbo].[dvtable_{C78ABDED-DB1C-4217-AE0D-51A400546923}]
set [UniquePartner] = [RowID]
where [UniquePartner] is NULL

IF NOT OBJECT_ID('[dbo].[dvtrgr_InsertCompanyData]') IS NULL
	DROP TRIGGER [dbo].[dvtrgr_InsertCompanyData]
GO

CREATE TRIGGER [dbo].[dvtrgr_InsertCompanyData] 
   ON  [dbo].[dvtable_{C78ABDED-DB1C-4217-AE0D-51A400546923}] 
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	UPDATE [dvtable_{C78ABDED-DB1C-4217-AE0D-51A400546923}]
    SET    UniquePartner = data.RowID
    FROM   [dvtable_{C78ABDED-DB1C-4217-AE0D-51A400546923}] data,
           inserted ins
	WHERE  data.RowID = ins.RowID

END
GO

IF NOT OBJECT_ID('[dbo].[dvtrgr_InsertDataEmpl]') IS NULL
	DROP TRIGGER [dbo].[dvtrgr_InsertDataEmpl]
GO

create TRIGGER [dbo].[dvtrgr_InsertDataEmpl] 
   ON  [dbo].[dvtable_{1A46BF0F-2D02-4AC9-8866-5ADF245921E8}] 
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	UPDATE [dvtable_{1A46BF0F-2D02-4AC9-8866-5ADF245921E8}]
    SET    UniqueEmpl = data.RowID
    FROM   [dvtable_{1A46BF0F-2D02-4AC9-8866-5ADF245921E8}] data,
           inserted ins
	WHERE  data.RowID = ins.RowID
    -- Insert statements for trigger here

END
GO

-- VERSION 1.28.123
-- TRIGGER FOR Creating replication units records
IF NOT OBJECT_ID('[dvtable_{7473F07F-11ED-4762-9F1E-7FF10808DDD1}_ParentRowIDChange]') IS NULL
	DROP TRIGGER [dvtable_{7473F07F-11ED-4762-9F1E-7FF10808DDD1}_ParentRowIDChange]
GO
CREATE TRIGGER [dvtable_{7473F07F-11ED-4762-9F1E-7FF10808DDD1}_ParentRowIDChange]
   ON [dvtable_{7473F07F-11ED-4762-9F1E-7FF10808DDD1}]
   AFTER INSERT,UPDATE
AS 
BEGIN
	SET NOCOUNT ON

	IF UPDATE(ParentTreeRowID)
	BEGIN
		DECLARE @isHome bit
		DECLARE @mainUnit uniqueidentifier

		SET @isHome = 0

	    SELECT @mainUnit = RowID
		FROM   inserted

	    SELECT @mainUnit = ParentTreeRowID
		FROM   inserted
		WHERE  ParentTreeRowID <> '00000000-0000-0000-0000-000000000000'

		SELECT @isHome = parentRep.IsHome,
               @mainUnit = parentRep.MainUnit
	    FROM   inserted i 
			   JOIN [dvtable_{AA743D9A-D013-46D6-AB6B-EA377FFEF619}] parentRep ON i.ParentTreeRowID = parentRep.Unit

		UPDATE
			[dvtable_{AA743D9A-D013-46D6-AB6B-EA377FFEF619}]
		SET
			IsHome = @isHome,
            MainUnit = @mainUnit
		FROM
			[dvtable_{AA743D9A-D013-46D6-AB6B-EA377FFEF619}] repUnit
			JOIN inserted i ON repUnit.Unit = i.RowID
		
		IF @@RowCount = 0
			INSERT INTO
				[dvtable_{AA743D9A-D013-46D6-AB6B-EA377FFEF619}]
			(RowID, InstanceID, ParentRowID, ParentTreeRowID, ZoneName, Unit, MainUnit, IsHome)
			SELECT
				newid(),
				inst.InstanceID,
				'00000000-0000-0000-0000-000000000000',
				'00000000-0000-0000-0000-000000000000',
				NULL,
				i.RowID,
	            @mainUnit,
				@isHome
			FROM
				inserted i
				JOIN [dvsys_instances] inst ON inst.CardTypeID = '814D0947-1D22-43A1-B5E6-54D83A9D88A1'

	END
END
GO
-- TRIGGER FOR Updating child replication unit records
IF NOT OBJECT_ID('[dvtable_{AA743D9A-D013-46D6-AB6B-EA377FFEF619}_IsHomeChange]') IS NULL
	DROP TRIGGER [dvtable_{AA743D9A-D013-46D6-AB6B-EA377FFEF619}_IsHomeChange]
GO
CREATE TRIGGER [dvtable_{AA743D9A-D013-46D6-AB6B-EA377FFEF619}_IsHomeChange]
   ON [dvtable_{AA743D9A-D013-46D6-AB6B-EA377FFEF619}]
   AFTER INSERT,UPDATE
AS 
BEGIN
	SET NOCOUNT ON

	IF UPDATE(IsHome)
	BEGIN
		DECLARE @topLevel bit

		SET @topLevel = 0

		SELECT @topLevel = 1
	    FROM   inserted i 
			   JOIN [dvtable_{7473F07F-11ED-4762-9F1E-7FF10808DDD1}] unit ON i.Unit = unit.RowID
		WHERE
			   unit.ParentTreeRowID = '00000000-0000-0000-0000-000000000000'

		IF @topLevel = 1
		BEGIN
			DECLARE @units TABLE (UnitID uniqueidentifier, Level int)
			DECLARE @level int
			DECLARE @rowCount int

			INSERT INTO @units
			SELECT 
				unit.RowID,
				0
			FROM
				inserted i
				JOIN [dvtable_{7473F07F-11ED-4762-9F1E-7FF10808DDD1}] unit WITH (NOLOCK) ON unit.RowID = i.Unit

			SET @rowCount = @@RowCount

			SET @level = 0

			WHILE @rowCount > 0
			BEGIN
				INSERT INTO @units
				SELECT
					unit.RowID,
					@level + 1
				FROM
					[dvtable_{7473F07F-11ED-4762-9F1E-7FF10808DDD1}] unit WITH (NOLOCK)
					JOIN @units lUnit ON lUnit.UnitID = unit.ParentTreeRowID AND lUnit.Level = @level

				SET @rowCount = @@RowCount
				SET @level = @level + 1
			END

			UPDATE [dvtable_{AA743D9A-D013-46D6-AB6B-EA377FFEF619}]
			SET    IsHome = i.IsHome
			FROM   inserted i,
				   @units unit,
				   [dvtable_{AA743D9A-D013-46D6-AB6B-EA377FFEF619}] repUnit
			WHERE  repUnit.Unit = unit.UnitID
                   AND unit.Level > 0 
		END
	END
END
GO
-- CREATING Replication unit records for current system
DECLARE @units TABLE (UnitID uniqueidentifier, MainUnit uniqueidentifier, IsHome bit, Level int, RepExists bit)
DECLARE @level int
DECLARE @rowCount int

INSERT INTO @units
SELECT 
	unit.RowID,
	unit.RowID,
    CASE WHEN repUnits.Unit IS NULL THEN 0 ELSE repUnits.IsHome END,
    0,
    CASE WHEN repUnits.Unit IS NULL THEN 0 ELSE 1 END
FROM
	[dvtable_{7473F07F-11ED-4762-9F1E-7FF10808DDD1}] unit WITH (NOLOCK)
	LEFT JOIN [dvtable_{AA743D9A-D013-46D6-AB6B-EA377FFEF619}] repUnits WITH (NOLOCK) ON repUnits.Unit = unit.RowID
WHERE
	unit.ParentTreeRowID = '00000000-0000-0000-0000-000000000000'

SET @rowCount = @@RowCount

SET @level = 0

WHILE @rowCount > 0
BEGIN
	INSERT INTO @units
	SELECT
		unit.RowID,
        lUnit.MainUnit,
		lUnit.IsHome,
		@level + 1,
	    CASE WHEN exUnit.RowID IS NULL THEN 0 ELSE 1 END
	FROM
		[dvtable_{7473F07F-11ED-4762-9F1E-7FF10808DDD1}] unit WITH (NOLOCK)
        JOIN @units lUnit ON lUnit.UnitID = unit.ParentTreeRowID AND lUnit.Level = @level
	    LEFT JOIN [dvtable_{AA743D9A-D013-46D6-AB6B-EA377FFEF619}] exUnit WITH (NOLOCK) ON exUnit.Unit = unit.RowID

	SET @rowCount = @@RowCount

	SET @level = @level + 1
END

INSERT INTO 
	[dvtable_{AA743D9A-D013-46D6-AB6B-EA377FFEF619}]
(RowID, InstanceID, ParentRowID, ParentTreeRowID, ZoneName, Unit, MainUnit, IsHome)
SELECT
	newid(),
	inst.InstanceID,
    '00000000-0000-0000-0000-000000000000',
    '00000000-0000-0000-0000-000000000000',
	NULL,
	u.UnitID,
    u.MainUnit,
	u.IsHome
FROM
	@units u,
    [dvsys_instances] inst
WHERE
	u.RepExists = 0
	AND inst.CardTypeID = '814D0947-1D22-43A1-B5E6-54D83A9D88A1'
GO
-- VERSION 1.27.122
-- PROCEDURE FOR Deleting old monitoring log
IF NOT OBJECT_ID('[dbo].[idoc_Monitoring_DeleteOldLog]') IS NULL
	DROP PROCEDURE [dbo].[idoc_Monitoring_DeleteOldLog]
GO
CREATE PROCEDURE [dbo].[idoc_Monitoring_DeleteOldLog]
AS
BEGIN

	DECLARE @date datetime

	SELECT @date = GetDate() - ISNULL(KeepLogTime, 2)
	FROM   [dvtable_{D9287DDE-912D-4D57-BBF8-95549EE697B0}]

	DELETE FROM
		[idoc_MonitoringLog]
	WHERE [Date] < @date

END
--Delimiter
GO
-- JOB FOR Deleting old monitoring log
DECLARE @CurDBName varchar(256)
SELECT @CurDBName = DB_NAME()

DECLARE @JobName varchar(256)
SELECT @JobName = 'idocjob_' + @CurDBName + '_Monitoring_DeleteOldLog'

IF EXISTS(SELECT * FROM msdb.dbo.sysjobs WHERE name = @JobName)
	EXECUTE msdb.dbo.sp_delete_job @job_name=@JobName

-- Create job
EXECUTE msdb.dbo.sp_add_job @job_name=@JobName
EXECUTE msdb.dbo.sp_add_jobstep @job_name=@JobName, @step_name='Monitoring_DeleteOldLog', @command='execute idoc_Monitoring_DeleteOldLog', @database_name=@CurDBName
EXECUTE msdb.dbo.sp_add_jobschedule @job_name=@JobName, @name='Nightly@2AM', @freq_type=4, @freq_interval=1, @freq_subday_type=1, @active_start_time=030000
EXECUTE msdb.dbo.sp_add_jobserver @job_name=@JobName

--Delimiter
GO
