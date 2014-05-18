BEGIN

DECLARE @outdos TABLE 
(
RegNum nvarchar(256),
RegDate datetime,
Subject ntext,
SignedBy nvarchar(1024),
Executer nvarchar(256),
ExecuterID uniqueidentifier,
SentDate datetime,
RecipientOrg nvarchar(256),
RecipientOrgID uniqueidentifier,
Recipient nvarchar(256),
RecipientID uniqueidentifier,
SendingType nvarchar(256),
SendingTypeID uniqueidentifier,
RegistryNumber nvarchar(256),
RegistryNumberID uniqueidentifier,
State int,
InstanceID uniqueidentifier
)

INSERT INTO @outdos
SELECT 
MainInfo.RegistrationNumber, 
MainInfo.RegistrationDate, 
MainInfo.Topic, 
[dbo].[GetOutDocSigners](MainInfo.InstanceID) as SignedBy,
Employees.DisplayString,
Employees.RowID,
Recipients.SentDate, 
Counteragents.Name as RecipientOrg,
Counteragents.RowID as RecipientOrgID,
CounteragentEmployees.LastName as Recipient,
CounteragentEmployees.RowID as RecipientID,
(SELECT TOP(1) OutDocSendingTypes.OutDocSendingType as SendingType
				   FROM [dvtable_{432E82D0-D10C-48D6-BA02-58820644A4A7}] as OutDocSendingTypes 
				   WHERE OutDocSendingTypes.RowID = Recipients.SendingType) as SendingType,
Recipients.SendingType,
(SELECT TOP(1) RegistryMainInfo.RegistrationNumber
				   FROM [dvtable_{15A8E7D1-F17C-4114-B9BE-466F507A294D}] as RegistryMainInfo
				   WHERE RegistryMainInfo.InstanceID = Recipients.ParentRegister) as RegistryNumber,
Recipients.ParentRegister,
MainInfo.State as State,
MainInfo.InstanceID
FROM 
[dvtable_{4C07CA25-41D6-438A-B73E-47FE7650C7BD}] as MainInfo,
[dvtable_{8F135BE7-9544-4E7E-937F-2551378D0EBB}] as Recipients,
[dvtable_{C78ABDED-DB1C-4217-AE0D-51A400546923}] as Counteragents,
[dvtable_{1A46BF0F-2D02-4AC9-8866-5ADF245921E8}] as CounteragentEmployees,
[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as Employees
WHERE
MainInfo.InstanceID = Recipients.InstanceID AND
MainInfo.Executer = Employees.RowID AND
Recipients.Recipient = CounteragentEmployees.RowID AND
Counteragents.RowID = CounteragentEmployees.ParentRowID AND
MainInfo.RegistrationDate >= @regDateBegin AND
MainInfo.RegistrationDate <= @regDateEnd

-- Filter
	IF @state = 1
	BEGIN
		DELETE FROM @outdos WHERE
		--SentDate is not null
		State = 7
	END

	IF @state = 0 
	BEGIN
		DELETE FROM @outdos WHERE
		--SentDate is null OR SentDate < @sentDateBegin OR SentDate > @sentDateEnd
		State <> 7
	END

	IF @recipient <> '00000000-0000-0000-0000-000000000000' AND @recipient is not null
	BEGIN
		DELETE FROM @outdos WHERE 
		RecipientID is null or RecipientID <> @recipient
    END

	IF @recipientOrg <> '00000000-0000-0000-0000-000000000000' AND @recipientOrg is not null
	BEGIN
		DELETE FROM @outdos WHERE 
		RecipientOrgID is null or RecipientOrgID <> @recipientOrg
    END

	IF @executer <> '00000000-0000-0000-0000-000000000000' AND @executer is not null
	BEGIN
		DELETE FROM @outdos WHERE 
		ExecuterID is null or ExecuterID <> @executer
    END

	IF @sendingType <> '00000000-0000-0000-0000-000000000000' AND @sendingType is not null
	BEGIN
		DELETE FROM @outdos WHERE 
		SendingTypeID is null or SendingTypeID <> @sendingType
    END

	IF @signedBy <> '00000000-0000-0000-0000-000000000000' AND @signedBy is not null
	BEGIN
		DELETE OutDocs FROM @outdos AS OutDocs WHERE 
		NOT EXISTS(SELECT * FROM [dvtable_{C9E2D5D7-DEB2-43EA-84EF-A511507259E3}] as SignedByPersons
				WHERE SignedByPersons.InstanceID = OutDocs.InstanceID
                AND SignedByPersons.SignedByPerson = @signedBy)
    END

SELECT * FROM @outdos ORDER BY RegDate Desc
END