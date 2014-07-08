BEGIN
	SET @text = @text + '%'

	SELECT DISTINCT TOP(20)
		RowID,
		DisplayString	
	FROM
	(
		SELECT 
			[Group].RowID,
			[Group].Name as DisplayString
		FROM 
			[dvtable_{5B607FFC-7EA2-47B1-90D4-BB72A0FE7280}] as [Group] WITH (NOLOCK)
		WHERE
			[Group].Name like @text
	) data
	ORDER BY DisplayString
END