BEGIN

DECLARE @result TABLE
(
InstanceID uniqueidentifier,
RegDate datetime,
SendingType uniqueidentifier,
RecipientID uniqueidentifier,
RecipientOrgID uniqueidentifier,
ExecuterID uniqueidentifier,
SentDate datetime,
DocumentNumber nvarchar(256),
DocumentType int,
AmountOfExpenditure float
)

INSERT INTO @result
SELECT 
MainInfo.InstanceID,
MainInfo.RegistrationDate,
Recipients.SendingType,
Recipients.Recipient,
Recipients.Organization,
MainInfo.Executer,
Recipients.SentDate,
Recipients.DocumentNumber,
Recipients.DocumentType,
Recipients.Amount
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
MainInfo.RegistrationDate is not null AND
MainInfo.RegistrationDate >= @regDateBegin AND
MainInfo.RegistrationDate <= @regDateEnd AND
Recipients.SentDate is not null AND
Recipients.SentDate >= @sentDateBegin AND
Recipients.SentDate <= @sentDateEnd AND
Recipients.SendingType is not null AND
Recipients.SendingType = @sendingType AND 
Recipients.DocumentType is not null AND
Recipients.Amount is not null

-- Filter
	IF @recipient <> '00000000-0000-0000-0000-000000000000' AND @recipient is not null
	BEGIN
		DELETE FROM @result WHERE 
		RecipientID is null or RecipientID <> @recipient
    END

	IF @recipientOrg <> '00000000-0000-0000-0000-000000000000' AND @recipientOrg is not null
	BEGIN
		DELETE FROM @result WHERE 
		RecipientOrgID is null or RecipientOrgID <> @recipientOrg
    END

	IF @executer <> '00000000-0000-0000-0000-000000000000' AND @executer is not null
	BEGIN
		DELETE FROM @result WHERE 
		ExecuterID is null or ExecuterID <> @executer
    END

	IF @signedBy <> '00000000-0000-0000-0000-000000000000' AND @signedBy is not null
	BEGIN
		DELETE Result FROM @result as Result WHERE 
		NOT EXISTS(SELECT * FROM [dvtable_{C9E2D5D7-DEB2-43EA-84EF-A511507259E3}] as SignedByPersons
				WHERE SignedByPersons.InstanceID = Result.InstanceID
                AND SignedByPersons.SignedByPerson = @signedBy)
    END

SELECT * FROM @result ORDER BY SentDate ASC, DocumentNumber ASC
END