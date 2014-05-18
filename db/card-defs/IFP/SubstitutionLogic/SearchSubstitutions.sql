BEGIN
	declare @emptyGuid uniqueidentifier
	set @emptyGuid = '00000000-0000-0000-0000-000000000000'
	declare @startDateIsNull as bit
	declare @endDateIsNull as bit
	declare @plannedStartDateIsNull as bit
	declare @plannedEndDateIsNull as bit
	
	if ((@startDate is null) or (datediff(day, @startDate, '1899.12.30') = 0))
		set @startDateIsNull = 1
	else
		set @startDateIsNull = 0
		
	if ((@endDate is null) or (datediff(day, @endDate, '1899.12.30') = 0))
		set @endDateIsNull = 1
	else
		set @endDateIsNull = 0

	if ((@plannedStartDate is null) or (datediff(day, @plannedStartDate, '1899.12.30') = 0))
		set @plannedStartDateIsNull = 1
	else
		set @plannedStartDateIsNull = 0
		
	if ((@plannedEndDate is null) or (datediff(day, @plannedEndDate, '1899.12.30') = 0))
		set @plannedEndDateIsNull = 1
	else
		set @plannedEndDateIsNull = 0

	select distinct top(1000)
	[dbo].[GetEmployeeFIO](employees.FirstName, employees.MiddleName, employees.LastName) as EmployeeFIO,
	[dbo].[GetEmployeeFIO](substituters.FirstName, substituters.MiddleName, substituters.LastName) as SubstituteFIO,
	substitutions.StartDate as StartDate,
	substitutions.EndDate as EndDate,
	substitutions.PlannedStartDate as PlannedStartDate,
	substitutions.PlannedEndDate as PlannedEndDate
	from [dvtable_{C01049C0-940F-490C-8A0A-4C10E9EDF2F6}] as substitutions
	inner join [dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as employees
	on substitutions.Employee = employees.RowID
	inner join [dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as substituters
	on substitutions.Substitute = substituters.RowID
	where 
	(
		@employeeID is null 
		or @employeeID = @emptyGuid 
		or @employeeID = substitutions.Employee
	)
	and
	(
		@substituteID is null 
		or @substituteID = @emptyGuid 
		or @substituteID = substitutions.Substitute
	)
	and
	(
		@startDateIsNull = 1
		or datediff(day, @startDate, substitutions.StartDate) = 0
	)
	and
	(
		@endDateIsNull = 1
		or datediff(day, @endDate, substitutions.EndDate) = 0
	)
	and
	(
		@plannedStartDateIsNull = 1
		or datediff(day, @plannedStartDate, substitutions.PlannedStartDate) = 0
	)
	and
	(
		@plannedEndDateIsNull = 1
		or datediff(day, @plannedEndDate, substitutions.PlannedEndDate) = 0
	)
	order by substitutions.StartDate desc
	for browse
END

/*

test

exec [dbo].[dvreport_get_data_{B8262FEE-0A6D-47e7-A64B-AEBE5663C62A}] '{00000000-0000-0000-0000-000000000000}', '{00000000-0000-0000-0000-000000000000}', '20100707', '20100707'

*/