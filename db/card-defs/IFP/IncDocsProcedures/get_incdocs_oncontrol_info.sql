BEGIN

DECLARE @result TABLE
(
Total int,
Finished int,
FinishedOverdue int,
Executing int,
ExecutingOverdue int
)

DECLARE @temp_incdocs TABLE 
(
InstanceID uniqueidentifier,
SignedBy uniqueidentifier,
Recipient uniqueidentifier,
SenderOrg uniqueidentifier,
DocState int,
ControlState int,
Term datetime,
Finished datetime
)

-- ���� ������ ���� "����������"
	IF @recipientID = '00000000-0000-0000-0000-000000000000' AND @reportIndex = 0
	BEGIN
		INSERT INTO @temp_incdocs
		SELECT mainInfo.InstanceID, mainInfo.SignedBy, NULL, 
		counteragents.RowID as SenderOrg, mainInfo.State, mainInfo.ControlState, Term, mainInfo.RemovalFromControl
		FROM [dvtable_{C06228B9-99F8-4B41-950B-8FACDC00A2B7}] as mainInfo,
		[dvtable_{1A46BF0F-2D02-4AC9-8866-5ADF245921E8}] as counteragentEmployees,
		[dvtable_{C78ABDED-DB1C-4217-AE0D-51A400546923}] as counteragents,
		dvsys_Instances
		WHERE
		dvsys_Instances.InstanceID = mainInfo.InstanceID AND
		(dvsys_Instances.Deleted is NULL or dvsys_Instances.Deleted <> 1) AND
		mainInfo.SignedBy = counteragentEmployees.RowID AND  
		counteragentEmployees.ParentRowID = counteragents.RowID AND 
		mainInfo.RegistrationDate >= @beginDate AND
		mainInfo.RegistrationDate <= @endDate
	END
	ELSE IF @reportIndex = 0
	BEGIN
		INSERT INTO @temp_incdocs
		SELECT mainInfo.InstanceID, mainInfo.SignedBy, recipients.Recipient, 
		counteragents.RowID as SenderOrg, mainInfo.State, mainInfo.ControlState, Term, mainInfo.RemovalFromControl
		FROM [dvtable_{C06228B9-99F8-4B41-950B-8FACDC00A2B7}] as mainInfo,
		[dvtable_{1A46BF0F-2D02-4AC9-8866-5ADF245921E8}] as counteragentEmployees,
		[dvtable_{C78ABDED-DB1C-4217-AE0D-51A400546923}] as counteragents,
		[dvtable_{FC138430-DE5D-47D2-BBD6-DA17D4DCF4CD}] as recipients,
		dvsys_Instances
		WHERE
		dvsys_Instances.InstanceID = mainInfo.InstanceID AND
		(dvsys_Instances.Deleted is NULL or dvsys_Instances.Deleted <> 1) AND
		mainInfo.SignedBy = counteragentEmployees.RowID AND  
		counteragentEmployees.ParentRowID = counteragents.RowID AND 
		mainInfo.RegistrationDate >= @beginDate AND
		mainInfo.RegistrationDate <= @endDate AND
		recipients.InstanceID = mainInfo.InstanceID AND
		recipients.Recipient = @recipientID
	END
	IF @recipientID = '00000000-0000-0000-0000-000000000000' AND @reportIndex = 1
	BEGIN
		INSERT INTO @temp_incdocs
		SELECT mainInfo.InstanceID, mainInfo.SignedBy, NULL, 
		counteragents.RowID as SenderOrg, mainInfo.State, mainInfo.ControlState, Term, mainInfo.RemovalFromControl 
		FROM [dvtable_{C06228B9-99F8-4B41-950B-8FACDC00A2B7}] as mainInfo,
		[dvtable_{1A46BF0F-2D02-4AC9-8866-5ADF245921E8}] as counteragentEmployees,
		[dvtable_{C78ABDED-DB1C-4217-AE0D-51A400546923}] as counteragents
		WHERE mainInfo.SignedBy = counteragentEmployees.RowID AND  
		counteragentEmployees.ParentRowID = counteragents.RowID
	END
	ELSE IF @reportIndex = 1
	BEGIN
		INSERT INTO @temp_incdocs
		SELECT mainInfo.InstanceID, mainInfo.SignedBy, recipients.Recipient, 
		counteragents.RowID as SenderOrg, mainInfo.State, mainInfo.ControlState, Term, mainInfo.RemovalFromControl 
		FROM [dvtable_{C06228B9-99F8-4B41-950B-8FACDC00A2B7}] as mainInfo,
		[dvtable_{1A46BF0F-2D02-4AC9-8866-5ADF245921E8}] as counteragentEmployees,
		[dvtable_{C78ABDED-DB1C-4217-AE0D-51A400546923}] as counteragents,
		[dvtable_{FC138430-DE5D-47D2-BBD6-DA17D4DCF4CD}] as recipients
		WHERE mainInfo.SignedBy = counteragentEmployees.RowID AND  
		counteragentEmployees.ParentRowID = counteragents.RowID AND 
		recipients.InstanceID = mainInfo.InstanceID AND
		recipients.Recipient = @recipientID
	END
	
	
	
-- [�������]
-- ���� ������ ���� "���������"
	IF @signedByID <> '00000000-0000-0000-0000-000000000000'
	BEGIN
		DELETE FROM @temp_incdocs WHERE 
		SignedBy <> @signedByID
    END

-- ���� ������ ���� "�����������"
	IF @senderOrgID <> '00000000-0000-0000-0000-000000000000'
	BEGIN
		DELETE FROM @temp_incdocs WHERE 
		SenderOrg <> @senderOrgID
    END

	IF @reportIndex = 0
	BEGIN
		INSERT INTO @result (Total)
		SELECT COUNT(*)  
		FROM @temp_incdocs
		WHERE (ControlState = 1 OR ControlState = 2) AND (DocState = 3 OR DocState = 4)
		UPDATE @result
		SET Finished = (SELECT COUNT(*) 
						FROM @temp_incdocs 
						WHERE DocState = 4 AND ControlState = 2),

		FinishedOverdue = (SELECT COUNT(*) 
						   FROM @temp_incdocs 
						   WHERE DocState = 4 AND ControlState = 2 AND Term is not null AND ((Finished is null AND Term < GETDATE()) OR (Finished is not null AND Term < Finished))),

		Executing = (SELECT COUNT(*) 
					 FROM @temp_incdocs
					 WHERE (DocState = 3 OR DocState = 2) AND (ControlState = 1 OR ControlState = 2)),

		ExecutingOverdue = (SELECT COUNT(*) 
							FROM @temp_incdocs 
							WHERE (DocState = 3 OR DocState = 2) AND (ControlState = 1 OR ControlState = 2) AND Term is not null AND ((Finished is null AND Term < GETDATE()) OR (Finished is not null AND Term < Finished)))
	END 
	ELSE 
	BEGIN
		INSERT INTO @result (Total)
		SELECT COUNT(*)  
		FROM @temp_incdocs
		WHERE (ControlState = 1 OR ControlState = 2) AND (DocState = 2 OR DocState = 3)
		UPDATE @result
		SET Finished = (SELECT COUNT(DISTINCT InstanceID) 
						FROM @temp_incdocs 
						WHERE DocState = 2 AND (ControlState = 1 OR ControlState = 2)),

		FinishedOverdue = (SELECT COUNT(DISTINCT InstanceID) 
						   FROM @temp_incdocs 
						   WHERE DocState = 2 AND (ControlState = 1 OR ControlState = 2) AND Term is not null AND ((Finished is null AND Term < CONVERT(varchar(8), GETDATE(), 112)) OR (Finished is not null AND Term < Finished))),

		Executing = (SELECT COUNT(DISTINCT InstanceID) 
					 FROM @temp_incdocs
					 WHERE DocState = 3 AND (ControlState = 1 OR ControlState = 2)),

		ExecutingOverdue = (SELECT COUNT(DISTINCT InstanceID) 
							FROM @temp_incdocs 
							WHERE DocState = 3 AND (ControlState = 1 OR ControlState = 2) AND Term is not null AND ((Finished is null AND Term < CONVERT(varchar(8), GETDATE(), 112)) OR (Finished is not null AND Term < Finished)))
	END				
SELECT * FROM @result
END