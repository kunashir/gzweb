BEGIN
	select distinct RefEmployees.DisplayString, ISNULL(RepEmployeeSettings.Setting, 0) as Setting, ISNULL(RefPositions.Name, '') as PositionName, RefEmployees.RowID
	from [dbo].[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] RefEmployees
	  LEFT JOIN [dbo].[dvtable_{FCEC4B71-4922-4D42-8B71-508E286F1073}] RepEmployeeSettings ON RepEmployeeSettings.Employee = RefEmployees.RowID
	  LEFT JOIN [dbo].[dvtable_{CFDFE60A-21A8-4010-84E9-9D2DF348508C}] RefPositions ON RefPositions.RowID = RefEmployees.Position
	where RefEmployees.ParentRowID = @deptID
END