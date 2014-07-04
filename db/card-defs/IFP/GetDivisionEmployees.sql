BEGIN

	SELECT DISTINCT 
		e.RowID as EmployeeID
	FROM
		[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] e
		JOIN [dvtable_{FCEC4B71-4922-4D42-8B71-508E286F1073}] es ON es.Employee = e.RowID AND es.Setting = 1
	WHERE
		e.ParentRowID = @deptID
	FOR BROWSE
	
END
