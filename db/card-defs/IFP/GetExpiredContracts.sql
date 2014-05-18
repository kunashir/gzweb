BEGIN

	SELECT DISTINCT
           contractMainInfo.InstanceID
	FROM   [dbo].[dvtable_{DAA76B4A-98F9-44BA-833C-DD874DB33214}] contractMainInfo
	WHERE  contractMainInfo.State = 11 -- active
		   AND contractMainInfo.ContractTerm is not null
		   AND contractMainInfo.ContractTerm < @dateTo
    FOR BROWSE

END
