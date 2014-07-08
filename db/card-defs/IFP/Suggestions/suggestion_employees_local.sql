BEGIN

	SET @text = @text + '%'

	SELECT DISTINCT TOP(20)
		employee.RowID,
		employee.DisplayString
	FROM 
		[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as employee WITH (NOLOCK)
		JOIN [dvtable_{7473F07F-11ED-4762-9F1E-7FF10808DDD1}] as parentDepartment WITH (NOLOCK) ON employee.ParentRowID = parentDepartment.RowID
		JOIN [dvtable_{AA743D9A-D013-46D6-AB6B-EA377FFEF619}] as replicationDepartment WITH (NOLOCK) ON parentDepartment.RowID = replicationDepartment.Unit AND replicationDepartment.IsHome = 1
	WHERE
		employee.DisplayString like @text
		and	employee.NotAvailable != 1
	ORDER BY DisplayString
END
