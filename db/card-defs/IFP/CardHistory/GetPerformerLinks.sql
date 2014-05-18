BEGIN

declare @wftasks table (WFTaskID uniqueidentifier)

insert into @wftasks
select CONVERT(uniqueidentifier, WFTasks.Items) from [dbo].[idocfn_split_string](@WFTaskIDs,';') as WFTasks
where WFTasks.Items is not null AND WFTasks.Items != '';

select WFTaskMainInfo.InstanceID as WFTaskID, Instances.InstanceID as CardInstanceID, Instances.[Description] as CardDescription
from @wftasks WFTasks
inner join [dvtable_{7213A125-2CA4-40EE-A671-B52850F45E7D}] WFTaskMainInfo
on WFTasks.WFTaskID = WFTaskMainInfo.InstanceID
inner join [dvtable_{F34ADE10-7932-4767-BD03-67F164A45DE5}] ReferenceListReferences
on WFTaskMainInfo.RefsID = ReferenceListReferences.InstanceID
inner join dvsys_instances as Instances
on ReferenceListReferences.Link = Instances.InstanceID

END

/*

test

exec [dbo].[dvreport_get_data_{F3F8CD77-17CC-4791-B028-850015C16530}] '{87146CB3-FF12-4813-BFD9-5E3456C7F135};{EC469963-4ED6-4DC0-9483-2AE475BBE955}'

*/
