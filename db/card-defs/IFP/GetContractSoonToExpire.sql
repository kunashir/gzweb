BEGIN

	SELECT DISTINCT
           contractMainInfo.InstanceID
	FROM   [dbo].[dvtable_{DAA76B4A-98F9-44BA-833C-DD874DB33214}] contractMainInfo,
		   [dbo].[dvtable_{DBED195F-6235-4404-B7B2-D86148DC1180}] contractSetup
	WHERE  contractMainInfo.State = 11 -- active
		   AND contractMainInfo.ContractTerm is not null
		   AND contractSetup.ContractExpiryNotifyDays is not null
		   AND contractSetup.ContractExpiryNotifyDays > 0
		   AND contractMainInfo.ContractTerm - contractSetup.ContractExpiryNotifyDays >= @dateFrom
		   AND contractMainInfo.ContractTerm - contractSetup.ContractExpiryNotifyDays < @dateTo
    FOR BROWSE

END
