BEGIN
	select top(1) substitutions.RowID as SubstitutionID
	from [dvtable_{C01049C0-940F-490C-8A0A-4C10E9EDF2F6}] as substitutions
	where substitutions.Employee = @employeeID
	order by substitutions.StartDate desc
END