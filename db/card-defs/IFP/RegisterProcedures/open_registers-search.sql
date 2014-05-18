BEGIN

	SELECT 
		MainInfo.InstanceID as RegisterID,
		MainInfo.RegistrationNumber as RegNumber,
		RegisterDates.CreationDateTime as CreationDate
	FROM [dvtable_{15A8E7D1-F17C-4114-B9BE-466F507A294D}] as MainInfo
	INNER JOIN dbo.dvsys_instances_date as RegisterDates on RegisterDates.InstanceID = MainInfo.InstanceID
	WHERE
		MainInfo.State in (1) /* Registered */
		AND MainInfo.SendingType = @sendingTypeId
END