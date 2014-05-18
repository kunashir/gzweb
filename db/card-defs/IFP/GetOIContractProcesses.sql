BEGIN

	CREATE TABLE #changeOI_TempTable (InstanceID uniqueidentifier, [Name] nvarchar(544))

	INSERT INTO #changeOI_TempTable
	SELECT bp_MainInfo.InstanceID, 
		     bp_MainInfo.[Name]
	FROM   [dbo].[dvtable_{0EF6BCCA-7A09-4027-A3A2-D2EEECA1BF4D}] bp_MainInfo WITH (nolock),
		     [dbo].[dvtable_{79F5B1F6-6BD0-499B-9093-232989BDCC6E}] bp_Variables WITH (nolock)
	WHERE  bp_MainInfo.State in (0, 1, 2, 5) -- active processes
	  	   AND bp_Variables.InstanceID = bp_MainInfo.InstanceID
		     AND bp_Variables.ID = '{16D7B2BE-A866-46D4-8FE8-E874FE4C107D}' -- filtering by certain variable
		     AND UPPER(CAST(bp_Variables.[Value] as nvarchar(38))) = '{' + UPPER(CAST(@contractID as nvarchar(38))) + '}'

  WHILE @@RowCount > 0
	
	INSERT INTO #changeOI_TempTable
		SELECT bp_MainInfo.InstanceID,
			     bp_MainInfo.[Name]
		FROM   [dbo].[dvtable_{10105DC1-8B61-4A76-B719-02D679662606}] bp_ParentFunc WITH (nolock),
			     [dbo].[dvtable_{0EF6BCCA-7A09-4027-A3A2-D2EEECA1BF4D}] bp_MainInfo WITH (nolock),
			     #changeOI_TempTable bp_Data
		WHERE  bp_ParentFunc.InstanceID = bp_Data.InstanceID
			     AND bp_ParentFunc.TypeID = '{2BF8B01D-3EDF-40C2-8C94-C6F5F3BC82AC}'
			     AND bp_MainInfo.InstanceID = bp_ParentFunc.CardID
           AND NOT EXISTS
               (
                  SELECT 1
                  FROM   #changeOI_TempTable existingProcess
                  WHERE  existingProcess.InstanceID = bp_MainInfo.InstanceID
                )

 	SELECT DISTINCT
		   InstanceID,
       [Name]
    FROM #changeOI_TempTable 
    FOR BROWSE

	DROP TABLE #changeOI_TempTable
END