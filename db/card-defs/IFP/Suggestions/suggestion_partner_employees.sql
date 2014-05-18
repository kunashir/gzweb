BEGIN

set @text = @text + '%'

select top(100) partner_employees.RowID as RowID, partner_employees.LastName 
+ isnull(' ' + cast( FirstName as char(1) ) + '.', '')
+ isnull(' ' + cast( MiddleName as char(1) ) + '.', '')
+ N' / ' + partners.[Name] as DisplayString 
from [dvtable_{1A46BF0F-2D02-4AC9-8866-5ADF245921E8}] as partner_employees
inner join [dvtable_{C78ABDED-DB1C-4217-AE0D-51A400546923}] as partners
on partner_employees.ParentRowID = partners.RowID
where 
	partner_employees.LastName like @text
	and
	partner_employees.NotAvailable != 1
	
END


/*
test queries

exec [dbo].[dvreport_get_data_{73C4F9AD-BF75-4469-A35B-AC6E9391A286}] 'ã'

*/