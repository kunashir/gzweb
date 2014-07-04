BEGIN

set @text = '%' + @text + '%'

select top(100) RowID, units.[Name] as DisplayString from [dvtable_{7473F07F-11ED-4762-9F1E-7FF10808DDD1}] as units
where 
	units.[Name] like @text
	and
	NotAvailable != 1
	
END


/*
test queries

exec [dbo].[dvreport_get_data_{E66BB74C-B862-4862-9FC4-BF33441C56F5}] 'i'

*/