BEGIN

	SELECT DISTINCT
		   CASE COUNT(*)
				WHEN 0 THEN 1
				ELSE 0
		   END as CanStop
	FROM   [dbo].[dvtable_{10105DC1-8B61-4A76-B719-02D679662606}] processFunction
		   JOIN [dbo].[dvtable_{97CC73BA-1953-4A70-8460-415BD4BCAAAE}] functionState ON functionState.ParentRowID = processFunction.RowID
	WHERE  processFunction.InstanceID = @processID
		   AND processFunction.RowID <> @functionID
		   AND functionState.State IN (1,2)
	FOR BROWSE

END