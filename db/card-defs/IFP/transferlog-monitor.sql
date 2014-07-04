BEGIN
	SELECT DISTINCT
		   links.SourceCardID as Card,
           log_item.InstanceID as LogCard,
		   log_item.RowID as LogItem
	FROM   [dbo].[dvtable_{49834B18-D90D-4E87-8118-735A5AB1E998}] log_item,
		   [dbo].[dvsys_links] links
	WHERE  log_item.State = 1
		   AND log_item.AssignmentID is NULL
		   AND links.DestinationCardID = log_item.InstanceID
END
