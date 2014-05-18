BEGIN
		--IDCGPHGB-1650
		set @outNumberText = ltrim(rtrim(@outNumberText))
		if SUBSTRING(@outNumberText, 1, 1) = '='
			set @outNumberText = SUBSTRING(@outNumberText, 2, LEN(@outNumberText) - 1)
		else 
			set @outNumberText = '%' + @outNumberText + '%'
		
		SELECT TOP(50)
		data.CardID as CardID,
		data.OutNumber as OutNumber,
        instances.Description as Description,
		dvsys_security.SecurityDesc /* It's very-very important field. Selecting this field meaning that DV will make a filtering result 
										rows depending on current user access right */
		FROM
		(
			SELECT IncDocMainInfo.InstanceID as CardID,
				   IncDocMainInfo.LetterNumber as OutNumber
			FROM   [dvtable_{C06228B9-99F8-4B41-950B-8FACDC00A2B7}] IncDocMainInfo with (nolock)
			WHERE  IncDocMainInfo.LetterNumber like @outNumberText
			
			
		) data
		inner join [dvsys_instances] instances
		on instances.InstanceID = data.CardID
		inner join  [dvsys_security]
		on instances.SDID = dvsys_security.ID
		where (instances.Deleted is null or instances.Deleted = 0)
				and instances.Template = 0
END