BEGIN

	SET @text = '%' + @text + '%'

	SELECT DISTINCT TOP(20)
		RowID,
		DisplayString
	FROM
	(
		SELECT
			company.RowID, 
			company.[Name] as DisplayString 
		FROM
			[dvtable_{C78ABDED-DB1C-4217-AE0D-51A400546923}] as company WITH (NOLOCK)
		WHERE
			company.[Name] like @text
			and company.NotAvailable != 1

		UNION ALL
		
		SELECT
			unit.RowID, 
			unit.[Name] as DisplayString
		from 
			[dvtable_{7473F07F-11ED-4762-9F1E-7FF10808DDD1}] as unit WITH (NOLOCK)
			JOIN [dvtable_{AA743D9A-D013-46D6-AB6B-EA377FFEF619}] as unit_rep WITH (NOLOCK) ON unit_rep.Unit = unit.RowID
		where 
			unit.[Name] like @text
            AND unit.ParentTreeRowID = '00000000-0000-0000-0000-000000000000'
			AND unit.NotAvailable != 1
			AND ISNULL(unit_rep.IsHome, 0) = 0
	) data
	ORDER BY DisplayString

END
