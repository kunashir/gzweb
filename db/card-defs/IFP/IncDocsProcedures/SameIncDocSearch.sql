BEGIN

select IncDocMainInfo.InstanceID as InstanceID, dvsys_instances.[Description] as [Digest]
from [dvtable_{C06228B9-99F8-4B41-950B-8FACDC00A2B7}] IncDocMainInfo
inner join dvsys_instances
on IncDocMainInfo.InstanceID = dvsys_instances.InstanceID
left join [dvtable_{1A46BF0F-2D02-4AC9-8866-5ADF245921E8}] PartnerEmployees
on PartnerEmployees.RowID = IncDocMainInfo.SignedByDual

where
IncDocMainInfo.InstanceID != @instanceID
and
(
	LetterDate = @letterDate and 
	LetterNumber = @letterNumber and 
	PartnerEmployees.ParentRowID = @organizationID

	-- Раньше проверялись попарно условия на "или", теперь все три условия вместе
	-- (LetterDate = @letterDate and LetterNumber = @letterNumber) or
	-- (LetterNumber = @letterNumber and PartnerEmployees.ParentRowID = @organizationID)
)

END
/*
test query

exec [dbo].[dvreport_get_data_{F527D27D-30CA-4929-9ABA-9104D28F7A24}] '2e611af5-7fb5-4004-bea5-4e9f5be20389', '20091215', '1', '8d462d09-760d-4109-b482-5ccbbfd7c49a'

*/