BEGIN
declare @dynamicQuery nvarchar(max)
set @dynamicQuery = '
declare @total int
set @total = 0
declare @registered int
set @registered = 0
select @total = Count(*) from [dvtable_{' + @sectionID + '}],
dvsys_instances_date,
dvsys_instances WHERE 
dvsys_instances_date.InstanceID = [dvtable_{' + @sectionID + '}].InstanceID AND 
dvsys_instances.InstanceID = dvsys_instances_date.InstanceID AND
(dvsys_instances.Template is null or dvsys_instances.Template = 0) AND
dvsys_instances_date.CreationDateTime is not null AND
dvsys_instances_date.CreationDateTime >= ''' + @regDateStart + ''' AND 
dvsys_instances_date.CreationDateTime <= ''' + @regDateEnd + '''

select @registered = Count(*) from [dvtable_{' + @sectionID + '}] as MainInfo, dvsys_instances
where MainInfo.InstanceID = dvsys_instances.InstanceID AND
(dvsys_instances.Template is null or dvsys_instances.Template = 0) AND 
' + @regDateFieldName + ' is not null AND 
' + @regDateFieldName + ' >= ''' + @regDateStart + ''' AND ' + @regDateFieldName + ' <= ''' + @regDateEnd + '''
select @total as Total, @registered as Registered'
exec(@dynamicQuery)
END