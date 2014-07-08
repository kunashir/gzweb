BEGIN
IF object_id('[dbo].[#temp_departmentslist]') IS NOT NULL
 DROP TABLE [dbo].[#temp_departmentslist]

DECLARE @result TABLE (DepartmentID uniqueidentifier, Level int, RootDepartmentID uniqueidentifier) INSERT INTO @result exec GetDepartmentTree @rootDepartment

SELECT
Employees.RowID as EmployeeID,
Employees.DisplayString as EmployeeName,
[dbo].[GetEmployeeDepartment](Employees.RowID) as Department,
[dbo].[GetEmployeeDepartmentID](Employees.RowID) as DepartmentID,
[dbo].[GetDepartmentEmployeesCount](DepartmentID) as DepartmentEmplCount, Result.Level as DepartmentLevel,
[dbo].[GetEmployeePosition](Employees.RowID) as Position, 
[dbo].[IsDepartmentManagedByEmployee](DepartmentID, Employees.RowID) as IsManager 
FROM @result as Result, 
[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as Employees 
WHERE Employees.ParentRowID = Result.DepartmentID AND 
Employees.RowID IS NOT NULL AND 
DepartmentID is not null 
ORDER BY Level, IsManager DESC, Employees.DisplayString 
END