BEGIN 

IF OBJECT_ID('[dbo].[idoc_repl_unit]') IS NOT NULL
	SELECT ReplUnits.UnitID AS UnitID, ReplUnits.Office AS Office, Units.Name AS Name, Units.ParentTreeRowID AS ParentUnitID
	FROM [dbo].[idoc_repl_unit] AS ReplUnits
	JOIN [dbo].[dvtable_{7473f07f-11ed-4762-9f1e-7ff10808ddd1}] AS Units
	ON Units.RowID = ReplUnits.UnitID
	
END