BEGIN
	DECLARE @AccountName varchar(64)

	SELECT @AccountName = tUsers.[AccountName]
	FROM [dbo].[dvsys_users] tUsers WITH(NOLOCK)
	WHERE tUsers.[UserID] = @UserID
	
	IF @AccountName = ''
		SELECT '00000000-0000-0000-0000-000000000000', 0
	ELSE
		BEGIN
			DECLARE @EmployeesTable TABLE
			(
				RowID uniqueidentifier NOT NULL,
				Status tinyint,
				DropLock tinyint
			)			
			
			INSERT @EmployeesTable
			(
				RowID,
				Status,
				DropLock
			)
			SELECT tEmployees.[RowID],
					CASE
						-- we don't want to login employees at locked period and discharged without restoration employees
						WHEN (tEmployees.[LockedFrom] IS NULL) AND (tEmployees.[LockedTo] IS NOT NULL) AND (GETDATE() < tEmployees.[LockedTo]) THEN 1
						WHEN (tEmployees.[LockedFrom] IS NOT NULL) AND (tEmployees.[LockedTo] IS NULL) AND (GETDATE() > tEmployees.[LockedFrom]) THEN 1
						WHEN (tEmployees.[LockedFrom] IS NOT NULL) AND (tEmployees.[LockedTo] IS NOT NULL) AND (GETDATE() BETWEEN tEmployees.[LockedFrom] AND tEmployees.[LockedTo]) THEN 1
						
						-- Issue 28454: if locked from date is larger then to date, the employee have access ONLY in this period
						WHEN (tEmployees.[LockedFrom] IS NOT NULL) AND (tEmployees.[LockedTo] IS NOT NULL) AND (tEmployees.[LockedFrom] > tEmployees.[LockedTo]) AND (GETDATE() NOT BETWEEN tEmployees.[LockedTo] AND tEmployees.[LockedFrom]) THEN 1
						WHEN tEmployees.[Status] = 7 THEN 1
						ELSE 0
  					END,
					CASE 
						-- Issue 30666: if the lock period is ended, we should drop values, but not drop values if locked to period is less then loked from by Issue 32080
						WHEN (tEmployees.[LockedFrom] IS NULL) AND (tEmployees.[LockedTo] IS NOT NULL) AND (GETDATE() > tEmployees.[LockedTo]) THEN 1 
						WHEN (tEmployees.[LockedFrom] IS NOT NULL) AND (tEmployees.[LockedTo] IS NOT NULL) AND (GETDATE() > tEmployees.[LockedFrom]) AND (GETDATE() > tEmployees.[LockedTo]) AND (tEmployees.[LockedFrom] < tEmployees.[LockedTo])  THEN 1
						ELSE 0
					END
			FROM [dbo].[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] tEmployees WITH(NOLOCK)
			JOIN [dbo].[dvsys_users] tUsers WITH(NOLOCK) ON UPPER(tEmployees.[AccountName]) = UPPER(tUsers.[AccountName])
			WHERE tUsers.[UserID] = @UserID
			
			IF EXISTS(SELECT t0.RowID FROM @EmployeesTable t0 WHERE t0.DropLock = 1)
			BEGIN
				-- Issue 30666: if the lock period is ended, we should drop values
				UPDATE [dbo].[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] WITH(ROWLOCK)
				SET [LockedFrom] = NULL, [LockedTo] = NULL
				WHERE RowID IN (SELECT t0.RowID FROM @EmployeesTable t0 WHERE t0.DropLock = 1)
			END
			
			-- The account is locked (RowID doesn't have metter)
			SELECT TOP 1 RowID, CASE 
				WHEN EXISTS (SELECT t0.[RowID] FROM @EmployeesTable t0 WHERE Status = 1) THEN 1 
				ELSE 0
				END
			FROM @EmployeesTable

		END
END