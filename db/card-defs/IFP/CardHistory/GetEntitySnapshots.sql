BEGIN

select snapshots.RowID as SnapshotID,
snapshots.[Date]  as SnapshotDate,
vfc_main_info.Name + ' (в. ' + CAST(vfc_versions.VersionNumber as nvarchar(10)) + ')' as [FileName],
vfc_versions.FileID as FileID
from [dvtable_{AEBAE081-FE0A-4B24-8F3E-440CEC7DFB22}] snapshots
inner join [dvtable_{D9C5B470-F1AA-4090-9D93-86D24A9C15B5}] versions
on snapshots.RowID = versions.ParentRowID
inner join [dvtable_{F831372E-8A76-4ABC-AF15-D86DC5FFBE12}] vfc_versions
on versions.FileVersion = vfc_versions.RowID
inner join [dvtable_{2FDE03C2-FF87-4E42-A8C2-7CED181977FB}] vfc_main_info
on vfc_versions.InstanceID = vfc_main_info.InstanceID

where snapshots.EntityID = @entityID


END