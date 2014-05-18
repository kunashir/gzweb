BEGIN
	CREATE TABLE #contractProcess_TempTable (InstanceID uniqueidentifier, [Name] nvarchar(544), IsStarter int)

	INSERT INTO #contractProcess_TempTable
	SELECT bp_MainInfo.InstanceID, 
	 	     bp_MainInfo.[Name],
         CASE bp_Variables.ID
         	 WHEN '{2C5FBCE8-9FA7-42CE-9D9B-7D8EDDA2491F}' THEN 1
	   			 ELSE 0
         END as IsStarter
	FROM   [dbo].[dvtable_{0EF6BCCA-7A09-4027-A3A2-D2EEECA1BF4D}] bp_MainInfo WITH (nolock),
		     [dbo].[dvtable_{79F5B1F6-6BD0-499B-9093-232989BDCC6E}] bp_Variables WITH (nolock)
	WHERE  bp_MainInfo.State in (0, 1, 2, 5) -- active processes
		     AND bp_Variables.InstanceID = bp_MainInfo.InstanceID
		     AND 
			   ((bp_Variables.ID = '{2C5FBCE8-9FA7-42CE-9D9B-7D8EDDA2491F}') -- 0.1. process
				OR (bp_Variables.ID = '{EB55BBFD-BDAE-466C-AA31-0EA8F4B0B096}') -- 1. process
				OR (bp_Variables.ID = '{B765BE0E-591E-439A-95A9-71B712A96D31}') -- 1.3. process
				OR (bp_Variables.ID = '{F557A1EE-8587-4E88-A4E5-B0D52BC2F95E}') -- 1.4. process
				OR (bp_Variables.ID = '{CC3AD509-B80A-483F-9A83-E58040C30169}')) -- 1.5. process
		     AND UPPER(CAST(bp_Variables.[Value] as nvarchar(38))) = '{' + UPPER(CAST(@contractID as nvarchar(38))) + '}'

	WHILE @@RowCount > 0
		INSERT INTO #contractProcess_TempTable
		SELECT bp_MainInfo.InstanceID,
	 		     bp_MainInfo.[Name],
           0 as IsStarter
		FROM   [dbo].[dvtable_{10105DC1-8B61-4A76-B719-02D679662606}] bp_ParentFunc WITH (nolock),
			     [dbo].[dvtable_{0EF6BCCA-7A09-4027-A3A2-D2EEECA1BF4D}] bp_MainInfo WITH (nolock),
			     #contractProcess_TempTable bp_Data
		WHERE  bp_ParentFunc.InstanceID = bp_Data.InstanceID
			     AND bp_ParentFunc.TypeID = '{2BF8B01D-3EDF-40C2-8C94-C6F5F3BC82AC}'
			     AND bp_MainInfo.InstanceID = bp_ParentFunc.CardID
			     AND NOT EXISTS
			     (
						 SELECT 1
						 FROM   #contractProcess_TempTable existingBPs
						 WHERE  existingBPs.InstanceID = bp_MainInfo.InstanceID
				   )

	SELECT DISTINCT * FROM #contractProcess_TempTable FOR BROWSE

	DROP TABLE #contractProcess_TempTable
END