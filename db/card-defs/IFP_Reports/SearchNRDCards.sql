BEGIN

DECLARE @sqlCommand nvarchar(max)

SET @sqlCommand = 
'
 SELECT DISTINCT
	InstanceID,
        DocumentKind,
        RegistrationNumber,
	CASE LEN(Categories)
		WHEN 0 THEN ''''
        	ELSE LEFT(Categories, LEN(Categories) - 1)
        END as Categories,
        State,
	Subject
FROM
(			
SELECT DISTINCT 
        MAININFO.InstanceID, 
        [DocumentKind], 
        [RegistrationNumber], 
        CONVERT(nvarchar(max),MAININFO.Comment) as Comment, 
        '''' + (select [Name] + '','' as ''data()'' from [dbo].[dvtable_{C0C45423-D1DC-4F18-A983-0029F93805CA}] nrdCategory inner join [dbo].[dvtable_{899C1470-9ADF-4D33-8E69-9944EB44DBE7}] category ON category.RowID = nrdCategory.[Category] WHERE nrdCategory.InstanceID = MainInfo.InstanceID for xml path('''')) as Categories,
        [State],
	[Subject] 
 FROM
 [dbo].[dvtable_{9B99D82A-8B4A-429E-A76D-469FDD1F6A86}] MAININFO
 LEFT JOIN [dbo].[dvtable_{C0C45423-D1DC-4F18-A983-0029F93805CA}] CATEGORIES
 ON MAININFO.[InstanceID] = CATEGORIES.[InstanceID]
 JOIN [dvsys_instances] SYS
 ON MAININFO.[InstanceID] = SYS.[InstanceID]
 WHERE ' + @conditionList + ' AND ISNULL(SYS.[Deleted], 0) = 0
) data
 FOR BROWSE'

EXEC (@sqlCommand)

END

