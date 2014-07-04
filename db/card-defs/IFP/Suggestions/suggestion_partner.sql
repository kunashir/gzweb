BEGIN

set @text = '%' + @text + '%'

select top(100) RowID, companies.[Name] as DisplayString from [dvtable_{C78ABDED-DB1C-4217-AE0D-51A400546923}] as companies
where 
	companies.[Name] like @text
	and
	NotAvailable != 1
	
END


/*
test queries

exec [dbo].[dvreport_get_data_{0F22E4F2-F043-4462-8D1C-F158FF8F4871}] 'i'

*/