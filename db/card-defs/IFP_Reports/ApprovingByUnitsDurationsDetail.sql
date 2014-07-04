
BEGIN

DECLARE @generalReportData TABLE
(InstanceID uniqueidentifier,
TypeID uniqueidentifier,
StartsAt datetime,
EndsAt datetime,
Department nvarchar(1024))

INSERT INTO @generalReportData
EXEC [dbo].[dvreport_get_data_{8869F514-A335-4e89-BA50-34B2B2B905E9}] @startDate, @endDate

-- OUTDOC
IF @CardTypeId = '{2E729D50-6B61-4186-9D14-44E109FD920B}'
	BEGIN
		SELECT 
		MainInfo.InstanceID,
		MainInfo.RegistrationNumber,
		MainInfo.RegistrationDate,
		Employees.DisplayString as Executer,
		Units.Comments as ExecuterDepartment,
	    '' + (select LastName + ' '
				  + CASE WHEN FirstName IS NULL THEN '' ELSE LEFT(FirstName,1) + '.' END 
				  + CASE WHEN MiddleName IS NULL THEN '' ELSE LEFT(MiddleName,1) + '.' END 
				  + ';' as 'data()' 
					from [dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] emp,
					[dvtable_{C9E2D5D7-DEB2-43EA-84EF-A511507259E3}] signedBy
					WHERE signedBy.SignedByPerson = emp.RowID AND signedBy.InstanceID = MainInfo.InstanceID
					for xml path('')) as SignedBy,
		MainInfo.Topic as Description,
	    '' + (select LastName + ' '
				  + CASE WHEN FirstName IS NULL THEN '' ELSE LEFT(FirstName,1) + '.' END 
				  + CASE WHEN MiddleName IS NULL THEN '' ELSE LEFT(MiddleName,1) + '.' END 
				  + ';' as 'data()' 
					from [dvtable_{1A46BF0F-2D02-4AC9-8866-5ADF245921E8}] emp,
					[dvtable_{8F135BE7-9544-4E7E-937F-2551378D0EBB}] recipients
					WHERE recipients.Recipient = emp.RowID AND recipients.InstanceID = MainInfo.InstanceID
					for xml path('')) as Recipient,
	    '' + (select [Name] + ';' as 'data()' 
					from [dvtable_{C78ABDED-DB1C-4217-AE0D-51A400546923}] dep,
					[dvtable_{8F135BE7-9544-4E7E-937F-2551378D0EBB}] recipients
					WHERE recipients.Organization = dep.RowID AND recipients.InstanceID = MainInfo.InstanceID
					for xml path('')) as Organization,
		MainInfo.State,
		ReportData.StartsAt as ApprovingStartsAt,
		ReportData.EndsAt as ApprovingEndsAt,
		ReportData.Department as ApprovingDepartment
		FROM
		[dvtable_{4C07CA25-41D6-438A-B73E-47FE7650C7BD}] as MainInfo,
		[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as Employees,
		[dvtable_{7473F07F-11ED-4762-9F1E-7FF10808DDD1}] as Units,
		@generalReportData ReportData
		WHERE 
		ReportData.InstanceID = MainInfo.InstanceID AND 
		Employees.RowID = MainInfo.Executer AND 
		Units.RowID = Employees.ParentRowID AND 
		(@byDepartment = 0 OR (ReportData.Department is null AND IsNULL(@depName,'') = '') OR Convert(nvarchar(1024), ReportData.Department) = @depName)
		ORDER BY MainInfo.RegistrationDate
	END

--ORDER
	ELSE IF @CardTypeId = '{56070FE0-BFC6-4CF1-8786-482E4DDFE9B6}'
	BEGIN
		SELECT
		MainInfo.InstanceID,
		MainInfo.RegistrationDate,
		MainInfo.RegistrationNumber,
		Employees.DisplayString as Executer,
		Units.Comments as ExecuterDepartment,
		[dbo].GetEmployeeDisplayStringByID(MainInfo.SignedBy) as SignedBy,
		MainInfo.Subject as Description,
		MainInfo.State,
		ReportData.StartsAt as ApprovingStartsAt,
		ReportData.EndsAt as ApprovingEndsAt,
		ReportData.Department as ApprovingDepartment
		FROM
		[dvtable_{F875C7C6-A280-402D-BC56-36DEE6376EED}] as MainInfo,
		[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as Employees,
		[dvtable_{7473F07F-11ED-4762-9F1E-7FF10808DDD1}] as Units,
		@generalReportData ReportData
		WHERE 
		ReportData.InstanceID = MainInfo.InstanceID AND 
		Employees.RowID = MainInfo.Executer AND 
		Units.RowID = Employees.ParentRowID AND 
		(@byDepartment = 0 OR (ReportData.Department is null AND IsNULL(@depName,'') = '') OR Convert(nvarchar(1024), ReportData.Department) = @depName)
		ORDER BY MainInfo.RegistrationDate
	END


--DIRECTION
	ELSE IF @CardTypeId = '{EB0F2CF0-F80B-4132-80D7-03409ABB3E70}'
	BEGIN
		SELECT
		MainInfo.InstanceID,
		MainInfo.RegistrationDate,
		MainInfo.RegistrationNumber,
		Employees.DisplayString as Executer,
		Units.Comments as ExecuterDepartment,
		[dbo].GetEmployeeDisplayStringByID(MainInfo.SignedBy) as SignedBy,
		MainInfo.Subject as Description,
		MainInfo.State,
		ReportData.StartsAt as ApprovingStartsAt,
		ReportData.EndsAt as ApprovingEndsAt,
		ReportData.Department as ApprovingDepartment
		FROM
		[dvtable_{4130F43C-6DD5-4A5B-971E-AA134F7FB2E5}] as MainInfo,
		[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as Employees,
		[dvtable_{7473F07F-11ED-4762-9F1E-7FF10808DDD1}] as Units,
		@generalReportData ReportData
		WHERE 
		ReportData.InstanceID = MainInfo.InstanceID AND 
		Employees.RowID = MainInfo.Executer AND 
		Units.RowID = Employees.ParentRowID AND 
		(@byDepartment = 0 OR (ReportData.Department is null AND IsNULL(@depName,'') = '') OR Convert(nvarchar(1024), ReportData.Department) = @depName)
		ORDER BY MainInfo.RegistrationDate
	END

--CONTRACT
	ELSE IF @CardTypeId = '{F8EE21FE-FB3D-45AD-B2C9-10C5A224E2D9}'
		BEGIN
			SELECT 
			MainInfo.InstanceID,
			MainInfo.RegistrationNumber,
			MainInfo.RegistrationDate,
			MainInfo.Description,
			Counteragents.Name as Counteragent,
			Employees.DisplayString as Executer,
		    [dbo].GetEmployeeDisplayStringByID(MainInfo.SignedBy) as SignedBy,
			Units.Comments as ExecuterDepartment,
			MainInfo.State,
			ReportData.StartsAt as ApprovingStartsAt,
			ReportData.EndsAt as ApprovingEndsAt,
			ReportData.Department as ApprovingDepartment
			FROM
			[dvtable_{DAA76B4A-98F9-44BA-833C-DD874DB33214}] as MainInfo,
			[dvtable_{C78ABDED-DB1C-4217-AE0D-51A400546923}] as Counteragents,
			[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as Employees,
			[dvtable_{7473F07F-11ED-4762-9F1E-7FF10808DDD1}] as Units,
			@generalReportData ReportData
			WHERE 
			MainInfo.Counteragent = Counteragents.RowID AND
			ReportData.InstanceID = MainInfo.InstanceID AND 
			Employees.RowID = MainInfo.Responsible AND 
			Units.RowID = Employees.ParentRowID AND 
			(@byDepartment = 0 OR (ReportData.Department is null AND IsNULL(@depName,'') = '') OR Convert(nvarchar(1024), ReportData.Department) = @depName)
			ORDER BY MainInfo.RegistrationDate
		END

--MEMORANDUM
	IF @CardTypeId = '{816AE98F-0E9C-4734-B368-642A34948527}'
		BEGIN
			SELECT 
			MainInfo.InstanceID,
			MainInfo.RegistrationNumber,
			MainInfo.RegistrationDate,
			MainInfo.Subject as Description,
			'' + (select LastName + ' '
				  + CASE WHEN FirstName IS NULL THEN '' ELSE LEFT(FirstName,1) + '.' END 
				  + CASE WHEN MiddleName IS NULL THEN '' ELSE LEFT(MiddleName,1) + '.' END 
				  + ';' as 'data()' 
					from [dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] emp,
					[dvtable_{11FFD2EB-A6E5-4303-A0F4-DE23813C7B5C}] recipients
					WHERE recipients.ToWhomPerson = emp.RowID AND recipients.InstanceID = MainInfo.InstanceID
					for xml path('')) as Recipient,
			Employees.DisplayString as Executer,
			Units.Comments as ExecuterDepartment,
			[dbo].GetEmployeeDisplayStringByID(MainInfo.SignedBy) as SignedBy,
			MainInfo.State,
			ReportData.StartsAt as ApprovingStartsAt,
			ReportData.EndsAt as ApprovingEndsAt,
			ReportData.Department as ApprovingDepartment
			FROM
			[dvtable_{B5D96F96-ACA2-4184-9702-2D89B1B3936A}] as MainInfo,
			[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] as Employees,
			[dvtable_{7473F07F-11ED-4762-9F1E-7FF10808DDD1}] as Units,
			@generalReportData ReportData
			WHERE 
			ReportData.InstanceID = MainInfo.InstanceID AND 
			Employees.RowID = MainInfo.Executer AND 
			Units.RowID = Employees.ParentRowID AND 
			(@byDepartment = 0 OR (ReportData.Department is null AND IsNULL(@depName,'') = '') OR Convert(nvarchar(1024), ReportData.Department) = @depName)
			ORDER BY MainInfo.RegistrationDate
		END
END
----
--GO
----
--EXEC  [dbo].[dvreport_get_data_{967540BB-CFD6-4C5F-BE55-C238B2588481}] 1, '{816AE98F-0E9C-4734-B368-642A34948527}', 'КОММЕНТС2', '2000-01-01', '2020-01-01'
--
--GO 
--
--SELECT Name, Comments FROM [dvtable_{7473F07F-11ED-4762-9F1E-7FF10808DDD1}]
