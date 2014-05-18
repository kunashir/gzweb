BEGIN
	SELECT 
		DocumentsToSend.Amount as Amount,
		DocumentsToSend.DocumentNumber as DocumentNumber,
		DocumentsToSend.DocumentType as DocumentType,
		DocumentsToSend.SendingDate as SendingDate,
		DocumentsToSend.SendingNumber as SendingNumber,
		DocumentsToSend.ParentOutDoc as ParentOutDoc,		
		Recipients.Recipient as RecipientEmployee,
		Recipients.Organization as RecipientOrganization,
		Recipients.Address as RecipientAddress,
		[dbo].[idocfn_get_outdoc_signers](DocumentsToSend.InstanceID) as Signers
	FROM [dvtable_{F896B5AC-D438-48CB-AE74-95C3F880483C}] as DocumentsToSend
	INNER JOIN [dvtable_{8F135BE7-9544-4E7E-937F-2551378D0EBB}] as Recipients
		on DocumentsToSend.Recipient = Recipients.RowID
	WHERE
		DocumentsToSend.InstanceID = @registerId
END