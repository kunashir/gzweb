BEGIN
	SELECT DISTINCT
		data.WarrantKind as WarrantKind,
		CAST(data.CardId as varchar(40)) as CardId
	FROM
	(       
		SELECT 
			1 as WarrantKind,
			MainInfo.InstanceID as CardId
		FROM   
			[dbo].[dvtable_{EC83F06E-8131-4437-A573-C86B15A2AF5C}] MainInfo
		WHERE
			MainInfo.ExpiryDate is not Null
			AND MainInfo.ExpiryDate < @dateTo
			AND MainInfo.State = 1

		UNION ALL

		SELECT
			2 as WarrantKind,
			MainInfo.InstanceID as CardId
		FROM
			[dbo].[dvtable_{EC83F06E-8131-4437-A573-C86B15A2AF5C}] MainInfo               
		WHERE
			MainInfo.ExpiryDate is not Null
            AND ((MainInfo.PreNotificationSent IS NULL) OR (MainInfo.PreNotificationSent = 0))
			AND MainInfo.ExpiryDate < CAST(ROUND(CAST(@dateFrom as float),0,1) as DateTime) + @shift + 1
			AND MainInfo.ExpiryDate >= CAST(ROUND(CAST(@dateFrom as float),0,1) as DateTime) + @shift
	) data
END