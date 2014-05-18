BEGIN

	DECLARE @date datetime

	SELECT @date = GetDate() - ISNULL(KeepLogTime, 2)
	FROM   [dvtable_{D9287DDE-912D-4D57-BBF8-95549EE697B0}]

	DELETE FROM
		[idoc_MonitoringLog]
	WHERE [Date] < @date

END
