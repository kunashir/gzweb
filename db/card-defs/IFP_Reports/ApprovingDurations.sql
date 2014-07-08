-------------------------------------------------------------------------------
-- dvreport_get_data_{EB5F2448-894F-4FA7-B20D-DCAE1E1A1548}
-------------------------------------------------------------------------------

BEGIN

DECLARE @result TABLE (
InstanceID uniqueidentifier,
TypeID uniqueidentifier,
ExecuterID uniqueidentifier,
StartsAt datetime,
EndsAt datetime,
RangeType int)
--согласование договора

DECLARE @docs TABLE (
InstanceID uniqueidentifier,
TypeID uniqueidentifier,
ExecuterID uniqueidentifier)


/*
-- ДОГОВОР --
INSERT INTO @docs
SELECT 
MainInfo.InstanceID,
'F8EE21FE-FB3D-45AD-B2C9-10C5A224E2D9',
MainInfo.Responsible
FROM 
[dvtable_{DAA76B4A-98F9-44BA-833C-DD874DB33214}] as MainInfo
WHERE
	EXISTS (SELECT * FROM [dvtable_{E79A6914-9A7A-467C-93CB-5A2F30BB5C52}] as ApprovalHistory 
			WHERE HistoryKind = 9 -- signed
			AND Date >= @startDate 
			AND Date <= @endDate 
			AND ApprovalHistory.InstanceID = MainInfo.InstanceID)
			
INSERT INTO @result
SELECT 
Documents.InstanceID,
Documents.TypeID,
Documents.ExecuterID,
(SELECT TOP(1) StartDate FROM [dvtable_{2B9AB001-ABED-4D62-88AC-E7DA49ED59B5}] as Approvals 
  WHERE Approvals.Decision = 0 AND Approvals.InstanceID = Documents.InstanceID 
  ORDER BY Approvals.StartDate ASC) as StartsAt,
(SELECT TOP(1) ApprovingDate FROM [dvtable_{2B9AB001-ABED-4D62-88AC-E7DA49ED59B5}] as Approvals 
  WHERE Approvals.Decision = 0 AND Approvals.InstanceID = Documents.InstanceID 
  ORDER BY Approvals.ApprovingDate DESC) as EndsAt,
0 as RangeType
FROM @docs AS Documents

UNION SELECT 
Documents.InstanceID,
Documents.TypeID,
Documents.ExecuterID,
(SELECT TOP(1) ApprovingDate FROM [dvtable_{2B9AB001-ABED-4D62-88AC-E7DA49ED59B5}] as Approvals 
  WHERE Approvals.Decision = 0 AND Approvals.InstanceID = Documents.InstanceID 
  ORDER BY Approvals.ApprovingDate DESC) as StartsAt,
(SELECT TOP(1) StartDate FROM [dvtable_{2B9AB001-ABED-4D62-88AC-E7DA49ED59B5}] as Approvals 
  WHERE Approvals.Decision = 2 AND Approvals.InstanceID = Documents.InstanceID 
  ORDER BY Approvals.StartDate ASC) as EndsAt,
1 as RangeType
FROM @docs AS Documents

UNION SELECT 
Documents.InstanceID,
Documents.TypeID,
Documents.ExecuterID,
(SELECT TOP(1) StartDate FROM [dvtable_{2B9AB001-ABED-4D62-88AC-E7DA49ED59B5}] as Approvals 
  WHERE Approvals.Decision = 2 AND Approvals.InstanceID = Documents.InstanceID 
  ORDER BY Approvals.StartDate ASC) as StartsAt,
(SELECT TOP(1) ApprovingDate FROM [dvtable_{2B9AB001-ABED-4D62-88AC-E7DA49ED59B5}] as Approvals 
  WHERE Approvals.Decision = 2 AND Approvals.InstanceID = Documents.InstanceID 
  ORDER BY Approvals.ApprovingDate DESC) as EndsAt,
2 as RangeType
FROM @docs AS Documents
*/

-- ПРИКАЗ --
DELETE FROM @docs
INSERT INTO @docs
SELECT 
MainInfo.InstanceID,
'56070FE0-BFC6-4CF1-8786-482E4DDFE9B6',
MainInfo.Executer
FROM 
[dvtable_{F875C7C6-A280-402D-BC56-36DEE6376EED}] as MainInfo
WHERE
	EXISTS (SELECT * FROM [dvtable_{E3E782CD-8B0E-43C8-BB79-AACF043C1502}] as ApprovalHistory 
			WHERE HistoryKind = 5 -- signed
			AND Date >= @startDate 
			AND Date <= @endDate 
			AND ApprovalHistory.InstanceID = MainInfo.InstanceID)


INSERT INTO @result
SELECT 
Documents.InstanceID,
Documents.TypeID,
Documents.ExecuterID,
(SELECT TOP(1) StartDate FROM [dvtable_{F0DC8EDD-1F37-4B6A-ABF3-BD527808B304}] as Approvals 
  WHERE Approvals.Decision = 0 AND Approvals.InstanceID = Documents.InstanceID 
  ORDER BY Approvals.StartDate ASC) as StartsAt,
(SELECT TOP(1) ApprovingDate FROM [dvtable_{F0DC8EDD-1F37-4B6A-ABF3-BD527808B304}] as Approvals 
  WHERE Approvals.Decision = 0 AND Approvals.InstanceID = Documents.InstanceID 
  ORDER BY Approvals.ApprovingDate DESC) as EndsAt,
0 as RangeType
FROM @docs AS Documents

UNION SELECT 
Documents.InstanceID,
Documents.TypeID,
Documents.ExecuterID,
(SELECT TOP(1) ApprovingDate FROM [dvtable_{F0DC8EDD-1F37-4B6A-ABF3-BD527808B304}] as Approvals 
  WHERE Approvals.Decision = 0 AND Approvals.InstanceID = Documents.InstanceID 
  ORDER BY Approvals.ApprovingDate DESC) as StartsAt,
(SELECT TOP(1) StartDate FROM [dvtable_{F0DC8EDD-1F37-4B6A-ABF3-BD527808B304}] as Approvals 
  WHERE Approvals.Decision = 2 AND Approvals.InstanceID = Documents.InstanceID 
  ORDER BY Approvals.StartDate ASC) as EndsAt,
1 as RangeType
FROM @docs AS Documents

UNION SELECT 
Documents.InstanceID,
Documents.TypeID,
Documents.ExecuterID,
(SELECT TOP(1) StartDate FROM [dvtable_{F0DC8EDD-1F37-4B6A-ABF3-BD527808B304}] as Approvals 
  WHERE Approvals.Decision = 2 AND Approvals.InstanceID = Documents.InstanceID 
  ORDER BY Approvals.StartDate ASC) as StartsAt,
(SELECT TOP(1) ApprovingDate FROM [dvtable_{F0DC8EDD-1F37-4B6A-ABF3-BD527808B304}] as Approvals 
  WHERE Approvals.Decision = 2 AND Approvals.InstanceID = Documents.InstanceID 
  ORDER BY Approvals.ApprovingDate DESC) as EndsAt,
2 as RangeType
FROM @docs AS Documents


-- РАСПОРЯЖЕНИЕ --
DELETE FROM @docs
INSERT INTO @docs
SELECT 
MainInfo.InstanceID,
'EB0F2CF0-F80B-4132-80D7-03409ABB3E70',
MainInfo.Executer
FROM 
[dvtable_{4130F43C-6DD5-4A5B-971E-AA134F7FB2E5}] as MainInfo
WHERE
	EXISTS (SELECT * FROM [dvtable_{340ACD6F-6001-4C40-8B9F-55CC74127313}] as ApprovalHistory 
			WHERE HistoryKind = 5 -- signed
			AND Date >= @startDate 
			AND Date <= @endDate 
			AND ApprovalHistory.InstanceID = MainInfo.InstanceID)




INSERT INTO @result
SELECT 
Documents.InstanceID,
Documents.TypeID,
Documents.ExecuterID,
(SELECT TOP(1) StartDate FROM [dvtable_{2E9C5799-3AE7-4164-BC9C-DE18C4CCAF71}] as Approvals 
  WHERE Approvals.Decision = 0 AND Approvals.InstanceID = Documents.InstanceID 
  ORDER BY Approvals.StartDate ASC) as StartsAt,
(SELECT TOP(1) ApprovingDate FROM [dvtable_{2E9C5799-3AE7-4164-BC9C-DE18C4CCAF71}] as Approvals 
  WHERE Approvals.Decision = 0 AND Approvals.InstanceID = Documents.InstanceID 
  ORDER BY Approvals.ApprovingDate DESC) as EndsAt,
0 as RangeType
FROM @docs AS Documents

UNION SELECT 
Documents.InstanceID,
Documents.TypeID,
Documents.ExecuterID,
(SELECT TOP(1) ApprovingDate FROM [dvtable_{2E9C5799-3AE7-4164-BC9C-DE18C4CCAF71}] as Approvals 
  WHERE Approvals.Decision = 0 AND Approvals.InstanceID = Documents.InstanceID 
  ORDER BY Approvals.ApprovingDate DESC) as StartsAt,
(SELECT TOP(1) StartDate FROM [dvtable_{2E9C5799-3AE7-4164-BC9C-DE18C4CCAF71}] as Approvals 
  WHERE Approvals.Decision = 2 AND Approvals.InstanceID = Documents.InstanceID 
  ORDER BY Approvals.StartDate ASC) as EndsAt,
1 as RangeType
FROM @docs AS Documents

UNION SELECT 
Documents.InstanceID,
Documents.TypeID,
Documents.ExecuterID,
(SELECT TOP(1) StartDate FROM [dvtable_{2E9C5799-3AE7-4164-BC9C-DE18C4CCAF71}] as Approvals 
  WHERE Approvals.Decision = 2 AND Approvals.InstanceID = Documents.InstanceID 
  ORDER BY Approvals.StartDate ASC) as StartsAt,
(SELECT TOP(1) ApprovingDate FROM [dvtable_{2E9C5799-3AE7-4164-BC9C-DE18C4CCAF71}] as Approvals 
  WHERE Approvals.Decision = 2 AND Approvals.InstanceID = Documents.InstanceID 
  ORDER BY Approvals.ApprovingDate DESC) as EndsAt,
2 as RangeType
FROM @docs AS Documents


-- СЛУЖЕБНАЯ ЗАПИСКА --
DELETE FROM @docs
INSERT INTO @docs
SELECT 
MainInfo.InstanceID,
'816AE98F-0E9C-4734-B368-642A34948527',
MainInfo.Executer
FROM 
[dvtable_{B5D96F96-ACA2-4184-9702-2D89B1B3936A}] as MainInfo
WHERE
	EXISTS (SELECT * FROM [dvtable_{2DEC53A1-850A-4AF5-BD07-D6149E4199BE}] as ApprovalHistory 
			WHERE Resolution = 5 -- signed
			AND Date >= @startDate 
			AND Date <= @endDate 
			AND ApprovalHistory.InstanceID = MainInfo.InstanceID)


INSERT INTO @result
SELECT 
Documents.InstanceID,
Documents.TypeID,
Documents.ExecuterID,
(SELECT TOP(1) StartDate FROM [dvtable_{076F7B28-2E5D-4A9E-835C-6A8D83B82168}] as Approvals 
  WHERE Approvals.Decision = 2 AND Approvals.InstanceID = Documents.InstanceID 
  ORDER BY Approvals.StartDate ASC) as StartsAt,
(SELECT TOP(1) ApprovingDate FROM [dvtable_{076F7B28-2E5D-4A9E-835C-6A8D83B82168}] as Approvals 
  WHERE Approvals.Decision = 2 AND Approvals.InstanceID = Documents.InstanceID 
  ORDER BY Approvals.ApprovingDate DESC) as EndsAt,
0 as RangeType
FROM @docs AS Documents

UNION SELECT 
Documents.InstanceID,
Documents.TypeID,
Documents.ExecuterID,
(SELECT TOP(1) ApprovingDate FROM [dvtable_{076F7B28-2E5D-4A9E-835C-6A8D83B82168}] as Approvals 
  WHERE Approvals.Decision = 2 AND Approvals.InstanceID = Documents.InstanceID 
  ORDER BY Approvals.ApprovingDate DESC) as StartsAt,
(SELECT TOP(1) StartDate FROM [dvtable_{076F7B28-2E5D-4A9E-835C-6A8D83B82168}] as Approvals 
  WHERE Approvals.Decision = 5 AND Approvals.InstanceID = Documents.InstanceID 
  ORDER BY Approvals.StartDate ASC) as EndsAt,
1 as RangeType
FROM @docs AS Documents

UNION SELECT 
Documents.InstanceID,
Documents.TypeID,
Documents.ExecuterID,
(SELECT TOP(1) StartDate FROM [dvtable_{076F7B28-2E5D-4A9E-835C-6A8D83B82168}] as Approvals 
  WHERE Approvals.Decision = 5 AND Approvals.InstanceID = Documents.InstanceID 
  ORDER BY Approvals.StartDate ASC) as StartsAt,
(SELECT TOP(1) ApprovingDate FROM [dvtable_{076F7B28-2E5D-4A9E-835C-6A8D83B82168}] as Approvals 
  WHERE Approvals.Decision = 5 AND Approvals.InstanceID = Documents.InstanceID 
  ORDER BY Approvals.ApprovingDate DESC) as EndsAt,
2 as RangeType
FROM @docs AS Documents


-- ИСХОДЯЩИЙ --
DELETE FROM @docs
INSERT INTO @docs
SELECT 
MainInfo.InstanceID,
'2E729D50-6B61-4186-9D14-44E109FD920B',
MainInfo.Executer
FROM 
[dvtable_{4C07CA25-41D6-438A-B73E-47FE7650C7BD}] as MainInfo
WHERE
	EXISTS (SELECT * FROM [dvtable_{20FFD567-A851-4E10-8548-6DCCA0FCB020}] as ApprovalHistory 
			WHERE Resolution = 5 -- signed
			AND Date >= @startDate 
			AND Date <= @endDate 
			AND ApprovalHistory.InstanceID = MainInfo.InstanceID) AND
	NOT EXISTS(SELECT * FROM [dvtable_{BF8269DB-570A-47AC-98F1-E88E40AF7661}] as Approvals 
	   WHERE Approvals.Decision != 5 AND Approvals.Decision != 2 AND Approvals.InstanceID = MainInfo.InstanceID)

INSERT INTO @result
SELECT 
Documents.InstanceID,
Documents.TypeID,
Documents.ExecuterID,
(SELECT TOP(1) StartDate FROM [dvtable_{BF8269DB-570A-47AC-98F1-E88E40AF7661}] as Approvals 
  WHERE Approvals.Decision = 2 AND Approvals.InstanceID = Documents.InstanceID 
  ORDER BY Approvals.StartDate ASC) as StartsAt,
(SELECT TOP(1) ApprovingDate FROM [dvtable_{BF8269DB-570A-47AC-98F1-E88E40AF7661}] as Approvals 
  WHERE Approvals.Decision = 2 AND Approvals.InstanceID = Documents.InstanceID 
  ORDER BY Approvals.ApprovingDate DESC) as EndsAt,
0 as RangeType
FROM @docs AS Documents

UNION SELECT 
Documents.InstanceID,
Documents.TypeID,
Documents.ExecuterID,
(SELECT TOP(1) ApprovingDate FROM [dvtable_{BF8269DB-570A-47AC-98F1-E88E40AF7661}] as Approvals 
  WHERE Approvals.Decision = 2 AND Approvals.InstanceID = Documents.InstanceID 
  ORDER BY Approvals.ApprovingDate DESC) as StartsAt,
(SELECT TOP(1) StartDate FROM [dvtable_{BF8269DB-570A-47AC-98F1-E88E40AF7661}] as Approvals 
  WHERE Approvals.Decision = 5 AND Approvals.InstanceID = Documents.InstanceID 
  ORDER BY Approvals.StartDate ASC) as EndsAt,
1 as RangeType
FROM @docs AS Documents

UNION SELECT 
Documents.InstanceID,
Documents.TypeID,
Documents.ExecuterID,
(SELECT TOP(1) StartDate FROM [dvtable_{BF8269DB-570A-47AC-98F1-E88E40AF7661}] as Approvals 
  WHERE Approvals.Decision = 5 AND Approvals.InstanceID = Documents.InstanceID 
  ORDER BY Approvals.StartDate ASC) as StartsAt,
(SELECT TOP(1) ApprovingDate FROM [dvtable_{BF8269DB-570A-47AC-98F1-E88E40AF7661}] as Approvals 
  WHERE Approvals.Decision = 5 AND Approvals.InstanceID = Documents.InstanceID 
  ORDER BY Approvals.ApprovingDate DESC) as EndsAt,
2 as RangeType
FROM @docs AS Documents

SELECT 
Result.InstanceID,
TypeID,
StartsAt,
EndsAt,
RangeType,
CONVERT(nvarchar(1024), Units.Comments) As Department
FROM @result as Result,
[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as Employees,
[dvtable_{7473F07F-11ED-4762-9F1E-7FF10808DDD1}] as Units
WHERE Employees.RowID = Result.ExecuterID AND Employees.ParentRowID = Units.RowID
ORDER BY TypeID ASC

END

--GO

--exec [dbo].[dvreport_get_data_{EB5F2448-894F-4FA7-B20D-DCAE1E1A1548}] '2000-01-01', '2012-01-01'
