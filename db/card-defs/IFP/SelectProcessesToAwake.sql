BEGIN 

	SELECT DISTINCT
		   InstanceID as InstanceID
	FROM
	(
		SELECT processMainInfo.InstanceID
		FROM   [dbo].[dvtable_{0EF6BCCA-7A09-4027-A3A2-D2EEECA1BF4D}] processMainInfo WITH (nolock)
			   JOIN [dbo].[dvtable_{10105DC1-8B61-4A76-B719-02D679662606}] processFunction WITH (nolock) ON processFunction.InstanceID = processMainInfo.InstanceID
			   JOIN [dbo].[dvtable_{97CC73BA-1953-4A70-8460-415BD4BCAAAE}] processFunctionState WITH (nolock) ON processFunctionState.ParentRowID = processFunction.RowID
			   JOIN [dbo].[dvtable_{D48E6155-C774-4205-AB70-7A67AB69DF22}] taskPerforming WITH (nolock) ON taskPerforming.InstanceID = processFunction.CardID
		WHERE  processMainInfo.State = 5
			   AND processFunction.TypeID = 'B3697777-A154-4B4E-8B05-6736CA05708E'
			   AND processFunctionState.State = 7
			   AND taskPerforming.TaskState NOT IN (2, 3, 4, 8, 9, 10, 14)

		UNION ALL

		SELECT processMainInfo.InstanceID
		FROM   [dbo].[dvtable_{0EF6BCCA-7A09-4027-A3A2-D2EEECA1BF4D}] processMainInfo WITH (nolock)
			   JOIN [dbo].[dvtable_{10105DC1-8B61-4A76-B719-02D679662606}] processFunction WITH (nolock) ON processFunction.InstanceID = processMainInfo.InstanceID
			   JOIN [dbo].[dvtable_{97CC73BA-1953-4A70-8460-415BD4BCAAAE}] processFunctionState WITH (nolock) ON processFunctionState.ParentRowID = processFunction.RowID
			   JOIN [dbo].[dvtable_{D48E6155-C774-4205-AB70-7A67AB69DF22}] taskPerforming WITH (nolock) ON taskPerforming.InstanceID = processFunction.WeakCardID
		WHERE  processMainInfo.State = 5
			   AND processFunction.TypeID = 'B3697777-A154-4B4E-8B05-6736CA05708E'
			   AND processFunctionState.State = 8
			   AND taskPerforming.TaskState NOT IN (2, 3, 4, 8, 9, 10, 14)

		UNION ALL      
		      
		SELECT processMainInfo.InstanceID
		FROM   [dbo].[dvtable_{0EF6BCCA-7A09-4027-A3A2-D2EEECA1BF4D}] processMainInfo WITH (nolock)
			   JOIN [dbo].[dvtable_{10105DC1-8B61-4A76-B719-02D679662606}] processFunction WITH (nolock) ON processFunction.InstanceID = processMainInfo.InstanceID
			   JOIN [dbo].[dvtable_{97CC73BA-1953-4A70-8460-415BD4BCAAAE}] processFunctionState WITH (nolock) ON processFunctionState.ParentRowID = processFunction.RowID
			   JOIN [dbo].[dvtable_{0EF6BCCA-7A09-4027-A3A2-D2EEECA1BF4D}] subProcessMainInfo WITH (nolock) ON subProcessMainInfo.InstanceID = processFunction.CardID
		WHERE  processMainInfo.State = 5
			   AND processFunction.TypeID = '2BF8B01D-3EDF-40C2-8C94-C6F5F3BC82AC'
			   AND processFunctionState.State = 7
			   AND subProcessMainInfo.State IN (3, 4)

		UNION ALL      
		      
		SELECT processMainInfo.InstanceID
		FROM   [dbo].[dvtable_{0EF6BCCA-7A09-4027-A3A2-D2EEECA1BF4D}] processMainInfo WITH (nolock)
			   JOIN [dbo].[dvtable_{10105DC1-8B61-4A76-B719-02D679662606}] processFunction WITH (nolock) ON processFunction.InstanceID = processMainInfo.InstanceID
			   JOIN [dbo].[dvtable_{97CC73BA-1953-4A70-8460-415BD4BCAAAE}] processFunctionState WITH (nolock) ON processFunctionState.ParentRowID = processFunction.RowID
			   JOIN [dbo].[dvtable_{0EF6BCCA-7A09-4027-A3A2-D2EEECA1BF4D}] subProcessMainInfo WITH (nolock) ON subProcessMainInfo.InstanceID = processFunction.WeakCardID
		WHERE  processMainInfo.State = 5
			   AND processFunction.TypeID = '2BF8B01D-3EDF-40C2-8C94-C6F5F3BC82AC'
			   AND processFunctionState.State = 8
			   AND subProcessMainInfo.State IN (3, 4)
	) data
	FOR BROWSE

END