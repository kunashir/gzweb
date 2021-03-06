BEGIN
	DECLARE @strAssignmentID as nvarchar(40)

	SET @strAssignmentID = '{' + LOWER(CAST(@assignmentID as nvarchar(38))) + '}'

	SELECT DISTINCT
		   BPID as BPID,
		   BPName as BPName,
       IsStarter As IsStarter
	FROM
		(
			SELECT bp_var.InstanceID as BPID,
		  		   bp_main.[Name] as BPName,
             0 As IsStarter
			FROM   [dbo].[dvtable_{79F5B1F6-6BD0-499B-9093-232989BDCC6E}] bp_var WITH (nolock),
				     [dbo].[dvtable_{0EF6BCCA-7A09-4027-A3A2-D2EEECA1BF4D}] bp_main WITH (nolock)
			WHERE  bp_var.[Name] = 'Задание'
				     AND CHARINDEX('AssignmentTask', CAST([Value] as nvarchar(max))) > 0
				     AND CHARINDEX(@strAssignmentID, LOWER(CAST([Value] as nvarchar(max)))) > 0 
				     AND bp_main.InstanceID = bp_var.InstanceID
				     AND bp_main.State in (0, 1, 2, 5)

			UNION ALL

			SELECT bp_var.InstanceID as BPID,
				     bp_main.[Name] as BPName,
             0 As IsStarter
			FROM   [dbo].[dvtable_{79F5B1F6-6BD0-499B-9093-232989BDCC6E}] bp_var WITH (nolock),
				     [dbo].[dvtable_{0EF6BCCA-7A09-4027-A3A2-D2EEECA1BF4D}] bp_main WITH (nolock)
			WHERE  bp_var.[Name] = 'Задание'
				     AND CHARINDEX('AssignmentControlTask', CAST([Value] as nvarchar(max))) > 0
				     AND CHARINDEX(@strAssignmentID, LOWER(CAST([Value] as nvarchar(max)))) > 0 
				     AND bp_main.InstanceID = bp_var.InstanceID
				     AND bp_main.State in (0, 1, 2, 5)

			UNION ALL

			SELECT bp_var.InstanceID as BPID,
				     bp_main.[Name] as BPName,
             0 As IsStarter
			FROM   [dbo].[dvtable_{79F5B1F6-6BD0-499B-9093-232989BDCC6E}] bp_var WITH (nolock),
				     [dbo].[dvtable_{0EF6BCCA-7A09-4027-A3A2-D2EEECA1BF4D}] bp_main WITH (nolock)
			WHERE  bp_var.[Name] = 'Поручение'
             AND bp_var.ID = '{A4FE1529-FFEB-4546-BBE4-B126E61C990A}'
				     AND @strAssignmentID = LOWER(CAST(bp_var.[Value] as nvarchar(max)))
				     AND bp_main.InstanceID = bp_var.InstanceID
				     AND bp_main.State in (0, 1, 2, 5)

			UNION ALL

			SELECT bp_main.InstanceID as BPID,
				     bp_main.[Name] as BPName,
             1 As IsStarter
			FROM   [dbo].[dvtable_{0EF6BCCA-7A09-4027-A3A2-D2EEECA1BF4D}] bp_main WITH (nolock),
				     [dbo].[dvtable_{79F5B1F6-6BD0-499B-9093-232989BDCC6E}] bp_var WITH (nolock),
             [dbo].[dvtable_{52F01448-151C-4D4B-B18E-E80A06B5A581}] bp_var_values WITH (nolock)
			WHERE  bp_main.State in (0, 1, 2, 5)
             AND bp_var.ID = '{B2B148BF-9F39-4BD3-9A11-DA7645660B61}'
             AND bp_var.InstanceID = bp_main.InstanceID
             AND bp_var_values.ParentRowID = bp_var.RowID
  				   AND @strAssignmentID = '{' + LOWER(CAST(bp_var_values.[Value] as nvarchar(max))) + '}'
	 ) data
	 FOR BROWSE
	 
END