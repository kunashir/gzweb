BEGIN

	DECLARE @timestamp as timestamp
	DECLARE @total as int

	SET @timestamp = CAST(CAST(@timestampFrom as bigint) as timestamp)
	
	SELECT @total = COUNT(*)
	FROM   [idoc_MonitoringLog] WITH (NOLOCK)
	
	SELECT DISTINCT
		@total as Total,
		Handler as Handler,
		Date as Date,
		[Level] as [Level],
		CAST([Message] as nvarchar(max)) as [Message],
		CAST(CAST([Timestamp] as bigint) as float) as [Timestamp]
	FROM idoc_MonitoringLog WITH (NOLOCK)
	WHERE [Timestamp] > @timestamp
	ORDER BY [Timestamp] ASC
	FOR BROWSE

END
