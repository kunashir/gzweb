BEGIN

	SELECT DISTINCT
		data.InstanceID,
	    data.Subject,
	    data.SenderNumber,
		data.SenderDate,
		CASE 
			WHEN senderUnitStaff.RowID IS NOT NULL THEN senderUnitStaff.[Name] 
			WHEN senderUnitCounteragent.RowID IS NOT NULL THEN senderUnitCounteragent.[Name]
			ELSE ''
		END AS Sender,
		data.RefType,
		data.ID,
		data.[Name]
	FROM
	(
		SELECT
			incDocs.InstanceID as InstanceID, 
			CAST(incDocs.Subject as nvarchar(max)) as Subject, 
			incDocs.LetterNumber as SenderNumber,
			incDocs.LetterDate as SenderDate, 
		    incDocs.SignedBy as SignedBy,
			0 As RefType,
			[file].InstanceID as ID, 
			[file].FileName as [Name]
		FROM
			[dvtable_{C06228B9-99F8-4B41-950B-8FACDC00A2B7}] incDocs WITH (NOLOCK)
			JOIN [dvsys_instances] instances WITH (NOLOCK) ON instances.InstanceID = incDocs.InstanceID
			LEFT JOIN [dvtable_{E962AC85-0F53-4439-A1CD-171E46C3EF91}] files WITH (NOLOCK) ON files.InstanceID = incDocs.FileListID
			LEFT JOIN [dvtable_{B4562DF8-AF19-4D0F-85CA-53A311354D39}] [file] WITH (NOLOCK) ON [file].InstanceID = files.CardFileID
		WHERE  
			ISNULL(instances.Deleted, 0) = 0
			AND ISNULL(instances.Template, 0) = 0
			AND incDocs.[State] = 5

		UNION ALL

		SELECT
			incDocs.InstanceID as InstanceID, 
			CAST(incDocs.Subject as nvarchar(max)) as Subject, 
			incDocs.LetterNumber as SenderNumber,
			incDocs.LetterDate as SenderDate, 
			incDocs.SignedBy as SignedBy,
		    1 As RefType,
			sameIncDocsInstances.InstanceID as [ID],  
			sameIncDocsInstances.Description as [Name]
		FROM   
			[dvtable_{C06228B9-99F8-4B41-950B-8FACDC00A2B7}] incDocs WITH (NOLOCK)
			JOIN [dvsys_instances] instances WITH (NOLOCK) ON instances.InstanceID = incDocs.InstanceID
			JOIN [dvtable_{C06228B9-99F8-4B41-950B-8FACDC00A2B7}] sameIncDocs WITH (NOLOCK) ON sameIncDocs.LetterNumber = incDocs.LetterNumber AND sameIncDocs.LetterDate = incDocs.LetterDate AND sameIncDocs.InstanceID <> incDocs.InstanceID
			JOIN [dvsys_instances] sameIncDocsInstances WITH (NOLOCK) ON sameIncDocsInstances.InstanceID = sameIncDocs.InstanceID AND ISNULL(sameIncDocsInstances.Template, 0) = 0
		WHERE  
			ISNULL(instances.Deleted, 0) = 0
			AND ISNULL(instances.Template, 0) = 0
			AND incDocs.[State] = 5
	) data
	   LEFT JOIN [dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] senderStaff WITH (NOLOCK) ON senderStaff.RowID = data.SignedBy
	   LEFT JOIN [dvtable_{7473F07F-11ED-4762-9F1E-7FF10808DDD1}] senderUnitStaff WITH (NOLOCK) ON senderUnitStaff.RowID = senderStaff.ParentRowID
	   LEFT JOIN [dvtable_{1A46BF0F-2D02-4AC9-8866-5ADF245921E8}] senderCounteragent WITH (NOLOCK) ON senderCounteragent.RowID = data.SignedBy
	   LEFT JOIN [dvtable_{C78ABDED-DB1C-4217-AE0D-51A400546923}] senderUnitCounteragent WITH (NOLOCK) ON senderUnitCounteragent.RowID = senderCounteragent.ParentRowID
	ORDER BY InstanceID
	FOR BROWSE
END