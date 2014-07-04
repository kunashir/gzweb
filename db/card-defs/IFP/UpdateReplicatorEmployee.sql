BEGIN

SET NOCOUNT OFF

update [dbo].[dvtable_{FCEC4B71-4922-4D42-8B71-508E286F1073}]
	set [Setting] = @status
	where [Employee] = @emplID

if (@@rowcount = 0)
begin
	insert into [dbo].[dvtable_{FCEC4B71-4922-4D42-8B71-508E286F1073}] ([Employee], [Setting])
	values (@emplID, @status)
end

select distinct 'Ok' as Result

END