BEGIN 

IF OBJECT_ID('[dbo].[idoc_repl_unit]') IS NOT NULL
	UPDATE [dbo].[idoc_repl_unit] SET Office = @office
	WHERE UnitID = @unit
	
END