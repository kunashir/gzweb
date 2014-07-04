BEGIN

	INSERT INTO [dbo].[idoc_MonitoringLog]
	(Handler, Date, [Level], [Message])
	VALUES
	(@handler, GetDate(), @level, @message)

	SELECT DISTINCT 1 as Ok FOR BROWSE

END
