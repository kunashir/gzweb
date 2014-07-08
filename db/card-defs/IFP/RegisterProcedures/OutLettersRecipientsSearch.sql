BEGIN

/*declare @recipients nvarchar(max)
declare @docNumbers nvarchar(max)

set @recipients = '{E59B9635-6A89-46A5-9A7F-E9B6B962C8DD};{13F8C643-6C1C-456C-9BCC-3631C14787E2}'
set @docNumbers = 'asdf|ge||asgwe| |sggq'

exec [dvreport_get_data_{C202D907-BDE1-4467-B127-2B5DF589CACF}]

*/

declare @recipientsTable table(RecipientID uniqueidentifier)
insert into @recipientsTable
select CONVERT(uniqueidentifier, Recipients.Items) from [dbo].[idocfn_split_string](@recipients,';') as Recipients
where Recipients.Items is not null AND Recipients.Items != ''

declare @docNumberTable table(DocNumber nvarchar(max))
insert into @docNumberTable
select '%' + CONVERT(nvarchar(max), DocNumbers.Items) + '%' from [dbo].[idocfn_split_string](@docNumbers,'|') as DocNumbers
where DocNumbers.Items is not null AND DocNumbers.Items != ''

declare @signeerIdText as nvarchar(38)
set @signeerIdText = '%' + convert(varchar(36), @signeer) + '%'


	SELECT	OutDocRecipients.InstanceID as ParentOutDoc,
			OutDocRecipients.RowID OutDocRecipientRowID,
			OutDocRecipients.Recipient,
			OutDocRecipients.Organization,
			OutDocRecipients.Address,
			OutDocMainInfo.RegistrationDate,
			OutDocMainInfo.RegistrationNumber,
			[dbo].[idocfn_get_outdoc_signers](OutDocMainInfo.InstanceID) as Signers
	FROM [dvtable_{8F135BE7-9544-4E7E-937F-2551378D0EBB}] OutDocRecipients
		INNER JOIN [dvtable_{4C07CA25-41D6-438A-B73E-47FE7650C7BD}] OutDocMainInfo ON OutDocMainInfo.InstanceID = OutDocRecipients.InstanceID
	WHERE
OutDocRecipients.SendingType = @sendingTypeID
		AND
		OutDocMainInfo.State = 6 /* Sending state */
		AND
		(
			@recipientsIsNull = 1
			OR
			exists (select 1 from @recipientsTable as rt where rt.RecipientID = OutDocRecipients.Organization)
		)
		AND
		(
			@recipientEmployeeIsNull = 1
			OR
			OutDocRecipients.Recipient = @recipientEmployee
			OR
			OutDocRecipients.Recipient is null
			OR
			OutDocRecipients.Recipient = '00000000-0000-0000-0000-000000000000'
		)
		AND
		(
			@docNumbersIsNull = 1
			or
			exists (select 1 from @docNumberTable as dnt where ltrim(rtrim(OutDocMainInfo.RegistrationNumber)) like dnt.DocNumber)
		)
		AND
		(
			@docDateFromIsNull = 1
			or
			@docDateFrom <= OutDocMainInfo.RegistrationDate
		)
		AND
		(
			@docDateToIsNull = 1
			or
			@docDateTo >= OutDocMainInfo.RegistrationDate
		)
		AND
		(
			@signeerIsNull = 1
			or
			[dbo].[idocfn_get_outdoc_signers](OutDocMainInfo.InstanceID) like @signeerIdText /* trick, looking for a substring */
		)
		AND
		NOT EXISTS
		(	
			SELECT 1
			FROM [dvtable_{F896B5AC-D438-48CB-AE74-95C3F880483C}] DocumentsToSend
			WHERE OutDocRecipients.RowID = DocumentsToSend.Recipient
		)
		AND
		(
			@forGuidelinesSigning = 0 AND NOT EXISTS (SELECT 1 FROM [dvtable_{C9E2D5D7-DEB2-43EA-84EF-A511507259E3}] as OutDocSigners, 
			[dvtable_{E1EFDB5E-C2AB-4950-820A-4F0C0E301E0F}] as SetupSigners WHERE 
			OutDocRecipients.InstanceID = OutDocSigners.InstanceID AND
			OutDocSigners.SignedByPerson = SetupSigners.OutDocSignedByPerson)
			or
			@forGuidelinesSigning = 1 AND EXISTS (SELECT 1 FROM [dvtable_{C9E2D5D7-DEB2-43EA-84EF-A511507259E3}] as OutDocSigners, 
			[dvtable_{E1EFDB5E-C2AB-4950-820A-4F0C0E301E0F}] as SetupSigners WHERE 
			OutDocRecipients.InstanceID = OutDocSigners.InstanceID AND
			OutDocSigners.SignedByPerson = SetupSigners.OutDocSignedByPerson)
		)
		AND
		(
			(@onlyCentrallySending = 0)
			OR
			(@onlyCentrallySending = 1 AND OutDocMainInfo.SendingKind = 1)
		)
END