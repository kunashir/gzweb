BEGIN
	select 
		MainInfo.RegistrationDate,
		MainInfo.RegistrationNumber,
		MainInfo.State,
		MainInfo.ListCount,
		MainInfo.InAppendix,
		MainInfo.Registrator,
		MainInfo.CaseID,
		MainInfo.Executer,
		MainInfo.Subject,
		[dbo].[idocfn_get_outdoc_signers](MainInfo.InstanceID) SignedBy
	from [dbo].[dvtable_{4C07CA25-41D6-438A-B73E-47FE7650C7BD}] as MainInfo
	where MainInfo.InstanceID = @outdocId
END