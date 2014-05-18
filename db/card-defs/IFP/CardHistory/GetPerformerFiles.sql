BEGIN

declare @wftasks table (WFTaskID uniqueidentifier)

insert into @wftasks
select CONVERT(uniqueidentifier, WFTasks.Items) from [dbo].[idocfn_split_string](@WFTaskIDs,';') as WFTasks
where WFTasks.Items is not null AND WFTasks.Items != '';

select WFTaskMainInfo.InstanceID as WFTaskID, FileMainInfo.InstanceID as FileID, FileMainInfo.[FileName] as [FileName]
from @wftasks WFTasks
inner join [dvtable_{7213A125-2CA4-40EE-A671-B52850F45E7D}] WFTaskMainInfo
on WFTasks.WFTaskID = WFTaskMainInfo.InstanceID
inner join [dvtable_{E962AC85-0F53-4439-A1CD-171E46C3EF91}] FileListReferences
on WFTaskMainInfo.PerformerFilesID = FileListReferences.InstanceID
inner join [dvtable_{B4562DF8-AF19-4D0F-85CA-53A311354D39}] as FileMainInfo
on FileListReferences.CardFileID = FileMainInfo.InstanceID

END

/*

test

exec [dbo].[dvreport_get_data_{ED04B8EA-DA54-4599-A571-B708A58E24A0}] '{87146CB3-FF12-4813-BFD9-5E3456C7F135};{EC469963-4ED6-4DC0-9483-2AE475BBE955}'

select * from dbo.dvsys_files where fileid = 'F1ECDC4C-BD51-4043-96A0-3FB7F299573E'

select * from [dvtable_{B4562DF8-AF19-4D0F-85CA-53A311354D39}] CardFileMainInfo
where fileid = '7C933A7D-5E76-4D15-9140-6CD2A3AE2E9A'


select count(*), instanceid from [dvtable_{F831372E-8A76-4ABC-AF15-D86DC5FFBE12}] VersionedFileCardVersions
group by instanceid
order by count(*) desc


select * from [dvtable_{F831372E-8A76-4ABC-AF15-D86DC5FFBE12}] VersionedFileCardVersions
where instanceid = '7C933A7D-5E76-4D15-9140-6CD2A3AE2E9A'
*/