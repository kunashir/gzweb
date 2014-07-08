IF NOT OBJECT_ID('[dbo].[dvreport_get_data_{9186E0C2-5810-4ECE-AC72-0E122B105CA7}]') IS NULL
	DROP PROCEDURE [dbo].[dvreport_get_data_{9186E0C2-5810-4ECE-AC72-0E122B105CA7}]

--Delimiter
GO

CREATE PROCEDURE [dbo].[dvreport_get_data_{9186E0C2-5810-4ECE-AC72-0E122B105CA7}]
(@senderOrgID As uniqueidentifier = NULL,
@recipientID As uniqueidentifier = NULL,
@signedByID As uniqueidentifier = NULL,
@startPeriod As datetime = NULL,
@endPeriod As datetime = NULL,
@useConditionForBoth As bit = NULL,
@reportIndex As int = NULL) WITH ENCRYPTION
AS
BEGIN

-- На контроле на начало периода (+ просрочка)
IF @reportIndex = 0 
	BEGIN
		SELECT MainInfo.InstanceID,  
		CASE WHEN ((MainInfo.RemovalFromControl is null or MainInfo.RemovalFromControl > @startPeriod) AND MainInfo.Term is not null AND MainInfo.Term < @startPeriod) THEN 1 ELSE 0 END as IsOverdue
		FROM [dvtable_{C06228B9-99F8-4B41-950B-8FACDC00A2B7}] as MainInfo,
		[dvtable_{1A46BF0F-2D02-4AC9-8866-5ADF245921E8}] as CounteragentEmployees,
		[dvtable_{C78ABDED-DB1C-4217-AE0D-51A400546923}] as Counteragents,
		[dvsys_Instances]
		WHERE 
		/*standart conditions*/
		dvsys_Instances.InstanceID = MainInfo.InstanceID AND
		(dvsys_Instances.Deleted is NULL or dvsys_Instances.Deleted <> 1) AND
		MainInfo.SignedBy = CounteragentEmployees.RowID AND  
		CounteragentEmployees.ParentRowID = counteragents.RowID AND 
		/*specific*/
		MainInfo.ControlState > 0 AND
		(RemovalFromControl is null OR RemovalFromControl > @startPeriod) AND
		MainInfo.RegistrationDate < @startPeriod AND
		(@senderOrgID = '00000000-0000-0000-0000-000000000000' OR Counteragents.RowID = @senderOrgID) AND
		(@signedByID = '00000000-0000-0000-0000-000000000000' OR CounteragentEmployees.RowID = @signedByID) AND
		(@recipientID = '00000000-0000-0000-0000-000000000000' OR EXISTS(SELECT * FROM [dvtable_{FC138430-DE5D-47D2-BBD6-DA17D4DCF4CD}] as Recipients WHERE Recipients.Recipient = @recipientID AND Recipients.InstanceID = MainInfo.InstanceID))	
	END

-- Поставлено на контроле
IF @reportIndex = 1
	BEGIN
		SELECT MainInfo.InstanceID,  
		CASE WHEN 
		MainInfo.Term is not null AND
		(((MainInfo.RemovalFromControl is null or MainInfo.RemovalFromControl > @endPeriod) AND MainInfo.Term < @endPeriod) OR
		(MainInfo.RemovalFromControl is not null AND MainInfo.RemovalFromControl > MainInfo.Term))
		THEN 1 ELSE 0 END as IsOverdue
		FROM [dvtable_{C06228B9-99F8-4B41-950B-8FACDC00A2B7}] as MainInfo,
		[dvtable_{1A46BF0F-2D02-4AC9-8866-5ADF245921E8}] as CounteragentEmployees,
		[dvtable_{C78ABDED-DB1C-4217-AE0D-51A400546923}] as Counteragents,
		[dvsys_Instances]
		WHERE 
		/*standart conditions*/
		dvsys_Instances.InstanceID = MainInfo.InstanceID AND
		(dvsys_Instances.Deleted is NULL or dvsys_Instances.Deleted <> 1) AND
		MainInfo.SignedBy = CounteragentEmployees.RowID AND  
		CounteragentEmployees.ParentRowID = counteragents.RowID AND 
		/*specific*/
		MainInfo.ControlState > 0 AND
		MainInfo.RegistrationDate >= @startPeriod AND 
		MainInfo.RegistrationDate <= @endPeriod AND
		(@senderOrgID = '00000000-0000-0000-0000-000000000000' OR Counteragents.RowID = @senderOrgID) AND
		(@signedByID = '00000000-0000-0000-0000-000000000000' OR CounteragentEmployees.RowID = @signedByID) AND
		(@recipientID = '00000000-0000-0000-0000-000000000000' OR EXISTS(SELECT * FROM [dvtable_{FC138430-DE5D-47D2-BBD6-DA17D4DCF4CD}] as Recipients WHERE Recipients.Recipient = @recipientID AND Recipients.InstanceID = MainInfo.InstanceID))	
	END

-- Снято с контроля
IF @reportIndex = 2
	BEGIN
		SELECT MainInfo.InstanceID,  
		CASE WHEN MainInfo.Term < MainInfo.RemovalFromControl THEN 1 ELSE 0 END as IsOverdue
		FROM [dvtable_{C06228B9-99F8-4B41-950B-8FACDC00A2B7}] as MainInfo,
		[dvtable_{1A46BF0F-2D02-4AC9-8866-5ADF245921E8}] as CounteragentEmployees,
		[dvtable_{C78ABDED-DB1C-4217-AE0D-51A400546923}] as Counteragents,
		[dvsys_Instances]
		WHERE 
		/*standart conditions*/
		MainInfo.RemovalFromControl is not null AND
		dvsys_Instances.InstanceID = MainInfo.InstanceID AND
		(dvsys_Instances.Deleted is NULL or dvsys_Instances.Deleted <> 1) AND
		MainInfo.SignedBy = CounteragentEmployees.RowID AND  
		CounteragentEmployees.ParentRowID = counteragents.RowID AND 
		/*specific*/
		MainInfo.ControlState = 2 AND
		MainInfo.RemovalFromControl >= @startPeriod AND MainInfo.RemovalFromControl <= @endPeriod AND
		(@senderOrgID = '00000000-0000-0000-0000-000000000000' OR Counteragents.RowID = @senderOrgID) AND
		(@signedByID = '00000000-0000-0000-0000-000000000000' OR CounteragentEmployees.RowID = @signedByID) AND
		(@recipientID = '00000000-0000-0000-0000-000000000000' OR EXISTS(SELECT * FROM [dvtable_{FC138430-DE5D-47D2-BBD6-DA17D4DCF4CD}] as Recipients WHERE Recipients.Recipient = @recipientID AND Recipients.InstanceID = MainInfo.InstanceID))	
	END

-- Завершено
IF @reportIndex = 3
	BEGIN
		SELECT MainInfo.InstanceID,  
		CASE WHEN MainInfo.Term < GETDATE() THEN 1 ELSE 0 END as IsOverdue
		FROM [dvtable_{C06228B9-99F8-4B41-950B-8FACDC00A2B7}] as MainInfo,
		[dvtable_{1A46BF0F-2D02-4AC9-8866-5ADF245921E8}] as CounteragentEmployees,
		[dvtable_{C78ABDED-DB1C-4217-AE0D-51A400546923}] as Counteragents,
		[dvsys_Instances]
		WHERE 
		/*standart conditions*/
		dvsys_Instances.InstanceID = MainInfo.InstanceID AND
		(dvsys_Instances.Deleted is NULL or dvsys_Instances.Deleted <> 1) AND
		MainInfo.SignedBy = CounteragentEmployees.RowID AND  
		CounteragentEmployees.ParentRowID = counteragents.RowID AND 
		/*specific*/
		MainInfo.ControlState = 1 AND
		MainInfo.State = 4 AND
		(@useConditionForBoth <> 1 or (@senderOrgID = '00000000-0000-0000-0000-000000000000' OR Counteragents.RowID = @senderOrgID) AND
		(@signedByID = '00000000-0000-0000-0000-000000000000' OR CounteragentEmployees.RowID = @signedByID) AND
		(@recipientID = '00000000-0000-0000-0000-000000000000' OR EXISTS(SELECT * FROM [dvtable_{FC138430-DE5D-47D2-BBD6-DA17D4DCF4CD}] as Recipients WHERE Recipients.Recipient = @recipientID AND Recipients.InstanceID = MainInfo.InstanceID)))
	END

-- Исполняеться
IF @reportIndex = 4
	BEGIN
		SELECT MainInfo.InstanceID,  
		CASE WHEN MainInfo.Term < GETDATE() THEN 1 ELSE 0 END as IsOverdue
		FROM [dvtable_{C06228B9-99F8-4B41-950B-8FACDC00A2B7}] as MainInfo,
		[dvtable_{1A46BF0F-2D02-4AC9-8866-5ADF245921E8}] as CounteragentEmployees,
		[dvtable_{C78ABDED-DB1C-4217-AE0D-51A400546923}] as Counteragents,
		[dvsys_Instances]
		WHERE 
		/*standart conditions*/
		dvsys_Instances.InstanceID = MainInfo.InstanceID AND
		(dvsys_Instances.Deleted is NULL or dvsys_Instances.Deleted <> 1) AND
		MainInfo.SignedBy = CounteragentEmployees.RowID AND  
		CounteragentEmployees.ParentRowID = counteragents.RowID AND 
		/*specific*/
		MainInfo.ControlState = 1 AND
		MainInfo.State = 3 AND
		(@useConditionForBoth <> 1 or (@senderOrgID = '00000000-0000-0000-0000-000000000000' OR Counteragents.RowID = @senderOrgID) AND
		(@signedByID = '00000000-0000-0000-0000-000000000000' OR CounteragentEmployees.RowID = @signedByID) AND
		(@recipientID = '00000000-0000-0000-0000-000000000000' OR EXISTS(SELECT * FROM [dvtable_{FC138430-DE5D-47D2-BBD6-DA17D4DCF4CD}] as Recipients WHERE Recipients.Recipient = @recipientID AND Recipients.InstanceID = MainInfo.InstanceID)))	
	END

-- На рассмотрении
IF @reportIndex = 5
	BEGIN
		SELECT MainInfo.InstanceID,  
		CASE WHEN MainInfo.Term < GETDATE() THEN 1 ELSE 0 END as IsOverdue
		FROM [dvtable_{C06228B9-99F8-4B41-950B-8FACDC00A2B7}] as MainInfo,
		[dvtable_{1A46BF0F-2D02-4AC9-8866-5ADF245921E8}] as CounteragentEmployees,
		[dvtable_{C78ABDED-DB1C-4217-AE0D-51A400546923}] as Counteragents,
		[dvsys_Instances]
		WHERE 
		/*standart conditions*/
		dvsys_Instances.InstanceID = MainInfo.InstanceID AND
		(dvsys_Instances.Deleted is NULL or dvsys_Instances.Deleted <> 1) AND
		MainInfo.SignedBy = CounteragentEmployees.RowID AND  
		CounteragentEmployees.ParentRowID = counteragents.RowID AND 
		/*specific*/
		MainInfo.ControlState = 1 AND
		(MainInfo.State = 1 OR MainInfo.State = 2) AND
		(@useConditionForBoth <> 1 or (@senderOrgID = '00000000-0000-0000-0000-000000000000' OR Counteragents.RowID = @senderOrgID) AND
		(@signedByID = '00000000-0000-0000-0000-000000000000' OR CounteragentEmployees.RowID = @signedByID) AND
		(@recipientID = '00000000-0000-0000-0000-000000000000' OR EXISTS(SELECT * FROM [dvtable_{FC138430-DE5D-47D2-BBD6-DA17D4DCF4CD}] as Recipients WHERE Recipients.Recipient = @recipientID AND Recipients.InstanceID = MainInfo.InstanceID)))
	END
END