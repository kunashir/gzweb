BEGIN

	update [dvsys_instances_date]
	set CreationDateTime = @creationDate
	where InstanceID = @instanceID

	select 0 as Result /* It's needed to return anything from the report to prevent DV internal errors */
END
