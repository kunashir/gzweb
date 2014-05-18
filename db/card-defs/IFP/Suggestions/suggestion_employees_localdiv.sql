BEGIN

	SET @text = @text + '%'

	SELECT DISTINCT TOP(20)
		RowID,
		DisplayString
	FROM
	(
		SELECT 
			employee.RowID,
			employee.DisplayString
		FROM 
			[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as employee WITH (NOLOCK)
			JOIN [dvtable_{7473F07F-11ED-4762-9F1E-7FF10808DDD1}] as parentDepartment WITH (NOLOCK) ON employee.ParentRowID = parentDepartment.RowID
			JOIN [dvtable_{AA743D9A-D013-46D6-AB6B-EA377FFEF619}] as replicationDepartment WITH (NOLOCK) ON parentDepartment.RowID = replicationDepartment.Unit AND replicationDepartment.IsHome = 1
		WHERE
			employee.DisplayString like @text
			and	employee.NotAvailable != 1

		UNION ALL

		SELECT 
			employee.RowID,
			employee.DisplayString + N' / ' + mainDepartment.[Name] as DisplayString
		FROM 
			[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as employee WITH (NOLOCK)
			JOIN [dvtable_{7473F07F-11ED-4762-9F1E-7FF10808DDD1}] as parentDepartment WITH (NOLOCK) ON employee.ParentRowID = parentDepartment.RowID
			JOIN [dvtable_{AA743D9A-D013-46D6-AB6B-EA377FFEF619}] as replicationDepartment WITH (NOLOCK) ON parentDepartment.RowID = replicationDepartment.Unit AND ISNULL(replicationDepartment.IsHome,0) = 0
			JOIN [dvtable_{7473F07F-11ED-4762-9F1E-7FF10808DDD1}] as mainDepartment WITH (NOLOCK) ON mainDepartment.RowID = replicationDepartment.MainUnit
		    JOIN [dvtable_{FCEC4B71-4922-4D42-8B71-508E286F1073}] as employeeSettings WITH (NOLOCK) ON employeeSettings.Employee = employee.RowID and employeeSettings.Setting = 1
		WHERE
			employee.DisplayString like @text
			and	employee.NotAvailable != 1
	) data
	ORDER BY DisplayString

END


/*
test queries

exec [dbo].[dvreport_get_data_{73C4F9AD-BF75-4469-A35B-AC6E9391A286}] 'ã'

*/