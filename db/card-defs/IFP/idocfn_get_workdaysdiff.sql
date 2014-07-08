IF NOT OBJECT_ID('[dbo].[idocfn_get_workdaydiff]') IS NULL
	DROP FUNCTION [dbo].[idocfn_get_workdaydiff]
GO
CREATE FUNCTION [dbo].[idocfn_get_workdaydiff]
(@userID uniqueidentifier,
 @dateFrom datetime,
 @dateTo datetime)
RETURNS int
AS
BEGIN
	DECLARE @calendarID uniqueidentifier
	DECLARE @depID uniqueidentifier
	DECLARE @outDay int
	DECLARE @year int

	SELECT @calendarID = CalendarID,
		   @depID = ParentRowID
	FROM   [dbo].[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}]
	WHERE  RowID = @userID

	WHILE (@calendarID is NULL) and (@depID is not NULL) and (@depID <> '{00000000-0000-0000-0000-000000000000}')
	BEGIN
		SELECT @calendarID = CalendarID,
			   @depID = ParentTreeRowID
		FROM   [dbo].[dvtable_{7473F07F-11ED-4762-9F1E-7FF10808DDD1}]
		WHERE  RowID = @depID
	END

	IF Year(@dateFrom) = Year(@dateTo)
		SET @outDay = (DATEPART(dy, @dateTo) - DATEPART(dy, @dateFrom)) / 7 * 2
	ELSE
	BEGIN
		SET @year = Year(@dateFrom)
		
		SET @outDay = (DATEPART(dy, '12.31.' + CAST(@year as nvarchar)) - DATEPART(dy, @dateFrom)) / 7 * 2
		SET @year = @year + 1
		
		WHILE @year < Year(@dateTo)
			SET @outDay = @outDay + (DATEPART(dy, '12.31.' + CAST(@year as nvarchar)) - (DATEPART(dy, '01.01.' + CAST(@year as nvarchar)))) / 7 * 2
			
		SET @outDay = @outDay + (DATEPART(dy, @dateTo) - (DATEPART(dy, '01.01.' + CAST(@year as nvarchar)))) / 7 * 2
	END

	DECLARE @dateFromWD int
	DECLARE @dateToWD int

	SET @dateFromWD = (DATEPART(dw, @dateFrom) + @@DateFirst - 2) % 7
	SET @dateToWD = (DATEPART(dw, @dateTo) + @@DateFirst - 2) % 7

	IF @dateFromWD < 5
	BEGIN
		IF @dateToWD = 5
			SET @outDay = @outDay + 1
		ELSE
		IF @dateToWD = 6
			SET @outDay = @outDay + 2
		ELSE
		IF @dateToWD < @dateFromWD
			SET @outDay = @outDay + 2
	END
	ELSE
	IF @dateFromWD = 5
	BEGIN
		IF @dateToWD < 5
			SET @outDay = @outDay + 2
		ELSE
		IF @dateToWD = 6
			SET @outDay = @outDay + 1
	END
	ELSE
	IF @dateFromWD = 6
	BEGIN
		IF @dateToWD < 6
			SET @outDay = @outDay + 1
	END

	IF (@calendarID is not NULL)
	BEGIN
		SET @year = Year(@dateFrom)

		WHILE @year <= Year(@dateTo)
		BEGIN
			SELECT @outDay = @outDay - COUNT(*)
			FROM   [dbo].[dvtable_{D8B0DEB3-FAE7-4C06-8728-B495985183C9}] years,
				   [dbo].[dvtable_{F12C1136-B351-4037-9DC9-21C042A238AF}] days
			WHERE  years.InstanceID = @calendarID
				   AND years.[Year] = @year
				   AND days.ParentRowID = years.RowID
				   AND days.DayNumber > CASE WHEN @year = Year(@dateFrom) THEN DatePart(dy, @dateFrom) ELSE 1 END
				   AND days.DayNumber <= CASE WHEN @year = Year(@dateTo) THEN DatePart(dy, @dateTo) ELSE DatePart(dy, '12.31.' + CAST(@year as nvarchar)) END
				   AND days.[Type] = 0
				   AND (((DATEPART(dw, '01.01.2009') + @@DateFirst + days.DayNumber - 3) % 7) >= 5)

			SELECT @outDay = @outDay + COUNT(*)
			FROM   [dbo].[dvtable_{D8B0DEB3-FAE7-4C06-8728-B495985183C9}] years,
				   [dbo].[dvtable_{F12C1136-B351-4037-9DC9-21C042A238AF}] days
			WHERE  years.InstanceID = @calendarID
				   AND years.[Year] = @year
				   AND days.ParentRowID = years.RowID
				   AND days.DayNumber > CASE WHEN @year = Year(@dateFrom) THEN DatePart(dy, @dateFrom) ELSE 1 END
				   AND days.DayNumber <= CASE WHEN @year = Year(@dateTo) THEN DatePart(dy, @dateTo) ELSE DatePart(dy, '12.31.' + CAST(@year as nvarchar)) END
				   AND ((days.[Type] = 1) or (days.[Type] = 2))
				   AND (((DATEPART(dw, '01.01.2009') + @@DateFirst + days.DayNumber - 3) % 7) < 5)
			
			SET @year = @year + 1
		END
	END

	RETURN DATEDIFF(day, @dateFrom, @dateTo) - @outDay
END