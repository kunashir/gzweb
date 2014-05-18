BEGIN
	SELECT DISTINCT
		   transferlog.FromEmployee as [From],
           transferlog.ToEmployee as [To],
           transferlog.TransferDate as [Date],
		   transferlog.DueDate as [DueDate],
           transferlog.State as [State]
	FROM   [dbo].[dvtable_{49834B18-D90D-4E87-8118-735A5AB1E998}] transferlog
	WHERE  transferlog.InstanceID = @TransferLogID
	ORDER BY transferlog.TransferDate
    FOR BROWSE
   
END


/*
test code

exec [dvreport_get_data_{D9C6DCC4-D67E-428c-9109-52B5828E458A}] @barcode = N'45-2 тест'
select * from [dvtable_{D766EC2A-EDB4-4153-ADD1-3BB7BCC89D0D}] LNAMainInfo

*/