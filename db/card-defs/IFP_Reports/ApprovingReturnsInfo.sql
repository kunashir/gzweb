BEGIN

	DECLARE @result TABLE(
	TypeID uniqueidentifier,
	Department nvarchar(1024),
	ReturnsCount int)


	INSERT INTO @result

	--CONTRACT
	SELECT 'F8EE21FE-FB3D-45AD-B2C9-10C5A224E2D9' as TypeID,
	CONVERT(nvarchar(1024), Units.Comments) AS Department,
	(SELECT COUNT(*) FROM [dvtable_{E79A6914-9A7A-467C-93CB-5A2F30BB5C52}] as ApprovalHistory 
	 WHERE ApprovalHistory.InstanceID = MainInfo.InstanceID AND (HistoryKind = 2 OR HistoryKind = 10)) as ReturnsCount        --2 = NotApproved, 10 = NotSigned
	FROM [dvtable_{DAA76B4A-98F9-44BA-833C-DD874DB33214}] as MainInfo,
	[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as Employees,
	[dvtable_{7473F07F-11ED-4762-9F1E-7FF10808DDD1}] as Units
	WHERE MainInfo.Responsible = Employees.RowID AND Employees.ParentRowID = Units.RowID AND
	-- учитываем только те, что подписаны в указанный период
	EXISTS (SELECT * FROM [dvtable_{E79A6914-9A7A-467C-93CB-5A2F30BB5C52}] as ApprovalHistory 
			WHERE HistoryKind = 9 -- signed
			AND Date >= @startDate 
			AND Date <= @endDate 
			AND ApprovalHistory.InstanceID = MainInfo.InstanceID)

	INSERT INTO @result

	--ORDER
	SELECT '56070FE0-BFC6-4CF1-8786-482E4DDFE9B6' as TypeID,
	CONVERT(nvarchar(1024), Units.Comments) AS Department,
	(SELECT COUNT(*) FROM [dvtable_{E3E782CD-8B0E-43C8-BB79-AACF043C1502}] as ApprovalHistory 
	 WHERE ApprovalHistory.InstanceID = MainInfo.InstanceID AND (HistoryKind = 2 OR HistoryKind = 6)) as ReturnsCount     
	FROM [dvtable_{F875C7C6-A280-402D-BC56-36DEE6376EED}] as MainInfo,
	[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as Employees,
	[dvtable_{7473F07F-11ED-4762-9F1E-7FF10808DDD1}] as Units
	WHERE MainInfo.Executer = Employees.RowID AND Employees.ParentRowID = Units.RowID AND
	-- учитываем только те, что подписаны в указанный период
	EXISTS (SELECT * FROM [dvtable_{E3E782CD-8B0E-43C8-BB79-AACF043C1502}] as ApprovalHistory 
			WHERE HistoryKind = 5 -- signed
			AND Date >= @startDate 
			AND Date <= @endDate 
			AND ApprovalHistory.InstanceID = MainInfo.InstanceID)

	INSERT INTO @result

	--DIRECTION
	SELECT 'EB0F2CF0-F80B-4132-80D7-03409ABB3E70' as TypeID,
	CONVERT(nvarchar(1024), Units.Comments) AS Department,
	(SELECT COUNT(*) FROM [dvtable_{340ACD6F-6001-4C40-8B9F-55CC74127313}] as ApprovalHistory 
	 WHERE ApprovalHistory.InstanceID = MainInfo.InstanceID AND (HistoryKind = 2 OR HistoryKind = 6)) as ReturnsCount     
	FROM [dvtable_{4130F43C-6DD5-4A5B-971E-AA134F7FB2E5}] as MainInfo,
	[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as Employees,
	[dvtable_{7473F07F-11ED-4762-9F1E-7FF10808DDD1}] as Units
	WHERE MainInfo.Executer = Employees.RowID AND Employees.ParentRowID = Units.RowID AND
	-- учитываем только те, что подписаны в указанный период
	EXISTS (SELECT * FROM [dvtable_{340ACD6F-6001-4C40-8B9F-55CC74127313}] as ApprovalHistory 
			WHERE HistoryKind = 5 -- signed
			AND Date >= @startDate 
			AND Date <= @endDate 
			AND ApprovalHistory.InstanceID = MainInfo.InstanceID)

	INSERT INTO @result

	--MEMORANDUM
	SELECT '816AE98F-0E9C-4734-B368-642A34948527' as TypeID,
	CONVERT(nvarchar(1024), Units.Comments) AS Department,
	(SELECT COUNT(*) FROM [dvtable_{2DEC53A1-850A-4AF5-BD07-D6149E4199BE}] as ApprovalHistory 
	 WHERE ApprovalHistory.InstanceID = MainInfo.InstanceID AND (Resolution = 3 OR Resolution = 6)) as ReturnsCount     
	FROM [dvtable_{B5D96F96-ACA2-4184-9702-2D89B1B3936A}] as MainInfo,
	[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as Employees,
	[dvtable_{7473F07F-11ED-4762-9F1E-7FF10808DDD1}] as Units
	WHERE MainInfo.Executer = Employees.RowID AND Employees.ParentRowID = Units.RowID AND
	-- учитываем только те, что подписаны в указанный период
	EXISTS (SELECT * FROM [dvtable_{2DEC53A1-850A-4AF5-BD07-D6149E4199BE}] as ApprovalHistory 
			WHERE Resolution = 5 -- signed
			AND Date >= @startDate 
			AND Date <= @endDate 
			AND ApprovalHistory.InstanceID = MainInfo.InstanceID)

	INSERT INTO @result

	--OUTDOC
	SELECT '2E729D50-6B61-4186-9D14-44E109FD920B' as TypeID,
	CONVERT(nvarchar(1024), Units.Comments) AS Department,
	(SELECT COUNT(*) FROM [dvtable_{20FFD567-A851-4E10-8548-6DCCA0FCB020}] as ApprovalHistory 
	 WHERE ApprovalHistory.InstanceID = MainInfo.InstanceID AND (Resolution = 3 OR Resolution = 6)) as ReturnsCount     
	FROM [dvtable_{4C07CA25-41D6-438A-B73E-47FE7650C7BD}] as MainInfo,
	[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as Employees,
	[dvtable_{7473F07F-11ED-4762-9F1E-7FF10808DDD1}] as Units
	WHERE MainInfo.Executer = Employees.RowID AND Employees.ParentRowID = Units.RowID AND
	-- учитываем только те, что подписаны в указанный период
	EXISTS (SELECT * FROM [dvtable_{20FFD567-A851-4E10-8548-6DCCA0FCB020}] as ApprovalHistory 
			WHERE Resolution = 5 -- signed
			AND Date >= @startDate 
			AND Date <= @endDate 
			AND ApprovalHistory.InstanceID = MainInfo.InstanceID) AND
	NOT EXISTS(SELECT * FROM [dvtable_{BF8269DB-570A-47AC-98F1-E88E40AF7661}] as Approvals 
	   WHERE Approvals.Decision != 5 AND Approvals.Decision != 2 AND Approvals.InstanceID = MainInfo.InstanceID)

	SELECT TypeID, Department,
	COUNT(*) As DocCount, -- число подписанных документов за период
	--число документов хотя бы с одним возвратом
	(SELECT COUNT(*) FROM @result as Docs WHERE Result.TypeID = Docs.TypeID AND (IsNULL(Result.Department, '') = '' AND (IsNULL(Docs.Department, '') = '') OR Result.Department = Docs.Department) AND Docs.ReturnsCount > 0) as DocWithReturnsCount,
	--суммарное кол-во возвратов
	SUM(ReturnsCount) as TotalReturnsCount 
	FROM @result as Result
	GROUP BY TypeID, Department


END
--
--GO
--
--exec [dbo].[dvreport_get_data_{F89007F6-92B4-4CDE-A813-EB3BA765027A}] '2000-01-01', '2012-01-01'