-------------------------------------------------------------------------------
-- dvreport_get_data_{F89007F6-92B4-4CDE-A813-EB3BA765027A}
-------------------------------------------------------------------------------

BEGIN

	DECLARE @result TABLE(
	InstanceID uniqueidentifier,
	TypeID uniqueidentifier,
	Department nvarchar(1024),
	IsNotApproved bit)
		

	INSERT INTO @result

	--MEMORANDUM
	SELECT history.InstanceID,
	'816AE98F-0E9C-4734-B368-642A34948527' as TypeID,
	CONVERT(nvarchar(1024), Units.Comments) as Department,
	(CASE WHEN history.Resolution = 3 THEN 1 ELSE 0 END) as IsNotApproved
	FROM 
    [dvtable_{2DEC53A1-850A-4AF5-BD07-D6149E4199BE}] as history,
	[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as Employees,
	[dvtable_{7473F07F-11ED-4762-9F1E-7FF10808DDD1}] as Units
	WHERE history.Person = Employees.RowID AND Employees.ParentRowID = Units.RowID AND (history.Resolution in (2,3)) AND
	-- учитываем только те, что подписаны в указанный период
	EXISTS (SELECT * FROM [dvtable_{2DEC53A1-850A-4AF5-BD07-D6149E4199BE}] as ApprovalHistory 
			WHERE Resolution = 5 -- signed
			AND Date >= @startDate 
			AND Date <= @endDate 
			AND ApprovalHistory.InstanceID = history.InstanceID)


	INSERT INTO @result

	--CONTRACT
	SELECT history.InstanceID,
	'F8EE21FE-FB3D-45AD-B2C9-10C5A224E2D9' as TypeID,
	CONVERT(nvarchar(1024), Units.Comments) AS Department,
	(CASE WHEN history.HistoryKind = 2 THEN 1 ELSE 0 END) as IsNotApproved
	FROM [dvtable_{E79A6914-9A7A-467C-93CB-5A2F30BB5C52}] as history,
	[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as Employees,
	[dvtable_{7473F07F-11ED-4762-9F1E-7FF10808DDD1}] as Units
	WHERE history.Person = Employees.RowID AND Employees.ParentRowID = Units.RowID AND (history.HistoryKind in (1,2)) AND
	-- учитываем только те, что подписаны в указанный период
	EXISTS (SELECT * FROM [dvtable_{E79A6914-9A7A-467C-93CB-5A2F30BB5C52}] as ApprovalHistory 
			WHERE HistoryKind = 9 -- signed
			AND Date >= @startDate 
			AND Date <= @endDate 
			AND ApprovalHistory.InstanceID = history.InstanceID)

	INSERT INTO @result

	--ORDER
	SELECT history.InstanceID,
	'56070FE0-BFC6-4CF1-8786-482E4DDFE9B6' as TypeID,
	CONVERT(nvarchar(1024), Units.Comments) AS Department,
	(CASE WHEN history.HistoryKind = 2 THEN 1 ELSE 0 END) as IsNotApproved
	FROM [dvtable_{E3E782CD-8B0E-43C8-BB79-AACF043C1502}] as history,
	[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as Employees,
	[dvtable_{7473F07F-11ED-4762-9F1E-7FF10808DDD1}] as Units
	WHERE history.Person = Employees.RowID AND Employees.ParentRowID = Units.RowID AND (history.HistoryKind in (1,2)) AND
	-- учитываем только те, что подписаны в указанный период
	EXISTS (SELECT * FROM [dvtable_{E3E782CD-8B0E-43C8-BB79-AACF043C1502}] as ApprovalHistory 
			WHERE HistoryKind = 5 -- signed
			AND Date >= @startDate 
			AND Date <= @endDate 
			AND ApprovalHistory.InstanceID = history.InstanceID)

	INSERT INTO @result

	--DIRECTION
	SELECT history.InstanceID,
	'EB0F2CF0-F80B-4132-80D7-03409ABB3E70' as TypeID,
	CONVERT(nvarchar(1024), Units.Comments) AS Department,
	(CASE WHEN history.HistoryKind = 2 THEN 1 ELSE 0 END) as IsNotApproved
	FROM [dvtable_{340ACD6F-6001-4C40-8B9F-55CC74127313}] as history,
	[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as Employees,
	[dvtable_{7473F07F-11ED-4762-9F1E-7FF10808DDD1}] as Units
	WHERE history.Person = Employees.RowID AND Employees.ParentRowID = Units.RowID AND (history.HistoryKind in (1,2)) AND
	-- учитываем только те, что подписаны в указанный период
	EXISTS (SELECT * FROM [dvtable_{340ACD6F-6001-4C40-8B9F-55CC74127313}] as ApprovalHistory 
			WHERE HistoryKind = 5 -- signed
			AND Date >= @startDate 
			AND Date <= @endDate 
			AND ApprovalHistory.InstanceID = history.InstanceID)

	INSERT INTO @result

	--OUTDOC
	SELECT history.InstanceID,
	'2E729D50-6B61-4186-9D14-44E109FD920B' as TypeID,
	CONVERT(nvarchar(1024), Units.Comments) AS Department,
	(CASE WHEN history.Resolution = 3 THEN 1 ELSE 0 END) as IsNotApproved  
	FROM [dvtable_{20FFD567-A851-4E10-8548-6DCCA0FCB020}] as history,
	[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as Employees,
	[dvtable_{7473F07F-11ED-4762-9F1E-7FF10808DDD1}] as Units
	WHERE history.Person = Employees.RowID AND Employees.ParentRowID = Units.RowID AND (history.Resolution in (2,3)) AND
	-- учитываем только те, что подписаны в указанный период
	EXISTS (SELECT * FROM [dvtable_{20FFD567-A851-4E10-8548-6DCCA0FCB020}] as ApprovalHistory 
			WHERE Resolution = 5 -- signed
			AND Date >= @startDate 
			AND Date <= @endDate 
			AND ApprovalHistory.InstanceID = history.InstanceID) AND
	NOT EXISTS(SELECT * FROM [dvtable_{BF8269DB-570A-47AC-98F1-E88E40AF7661}] as Approvals 
	   WHERE Approvals.Decision != 5 AND Approvals.Decision != 2 AND Approvals.InstanceID = history.InstanceID)


	IF @detail = 0 
    BEGIN
		SELECT TypeID, Department,
		(SELECT COUNT(DISTINCT InstanceID) FROM @result AS res WHERE res.TypeID = Result.TypeID AND res.Department = Result.Department) as DocCount,
		(SELECT COUNT(DISTINCT InstanceID) FROM @result AS res WHERE res.TypeID = Result.TypeID AND res.Department = Result.Department AND res.IsNotApproved = 1) as DocWithReturnsCount,
		(SELECT COUNT(*) FROM @result AS res WHERE res.TypeID = Result.TypeID AND res.Department = Result.Department AND res.IsNotApproved = 1) as TotalReturnsCount
		FROM @result as Result
		GROUP BY TypeID, Department
	END
	ELSE 
		SELECT * FROM @result WHERE IsNotApproved = 1 ORDER BY TypeID

END

GO

exec [dbo].[dvreport_get_data_{5B234223-B670-4617-BA91-5B2789D8FD60}] '2000-01-01', '2012-01-01', 0