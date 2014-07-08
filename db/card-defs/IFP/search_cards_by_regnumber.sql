BEGIN
		--IDCGPHGB-1650
		set @regNumberText = ltrim(rtrim(@regNumberText))
		if SUBSTRING(@regNumberText, 1, 1) = '='
			set @regNumberText = SUBSTRING(@regNumberText, 2, LEN(@regNumberText) - 1)
		else 
			set @regNumberText = '%' + @regNumberText + '%'
		
		SELECT TOP(50)
		data.CardID as CardID,
		data.RegistrationNumber as RegistrationNumber,
        instances.Description as Description,
		dvsys_security.SecurityDesc /* It's very-very important field. Selecting this field meaning that DV will make a filtering result 
										rows depending on current user access right */
		FROM
		(
			SELECT AssignmentMainInfo.InstanceID as CardID, 
				   AssignmentMainInfo.RegistrationNumber as RegistrationNumber
			FROM   [dvtable_{E3335F61-DBD9-447B-A539-4BF721FFD7B0}] AssignmentMainInfo with (nolock)
			WHERE  AssignmentMainInfo.RegistrationNumber like @regNumberText
			
			UNION

			SELECT ContractMainInfo.InstanceID as CardID,
				   ContractMainInfo.ContractNumber as RegistrationNumber
			FROM   [dvtable_{DAA76B4A-98F9-44BA-833C-DD874DB33214}] ContractMainInfo with (nolock)
			WHERE  ContractMainInfo.ContractNumber like @regNumberText /* using ContractNumber instead of RegistrationNumber (IDCGPHGB-912)*/
			
			UNION

			SELECT ContractPlanMainInfo.InstanceID as CardID,
				   ContractPlanMainInfo.RegistrationNumber as RegistrationNumber
			FROM   [dvtable_{797A212A-0291-42D4-8A0D-CBC77069A9FE}] ContractPlanMainInfo with (nolock)
			WHERE  ContractPlanMainInfo.RegistrationNumber like @regNumberText

			UNION

			SELECT DirectionMainInfo.InstanceID as CardID,
				   DirectionMainInfo.RegistrationNumber as RegistrationNumber
			FROM   [dvtable_{4130F43C-6DD5-4A5B-971E-AA134F7FB2E5}] DirectionMainInfo with (nolock)
			WHERE  DirectionMainInfo.RegistrationNumber like @regNumberText
			
			UNION

			SELECT IncDocMainInfo.InstanceID as CardID,
				   IncDocMainInfo.RegistrationNumber as RegistrationNumber
			FROM   [dvtable_{C06228B9-99F8-4B41-950B-8FACDC00A2B7}] IncDocMainInfo with (nolock)
			WHERE  IncDocMainInfo.RegistrationNumber like @regNumberText
			
			UNION

			SELECT LNAMainInfo.InstanceID as CardID,
				   LNAMainInfo.RegistrationNumber as RegistrationNumber
			FROM   [dvtable_{D766EC2A-EDB4-4153-ADD1-3BB7BCC89D0D}] LNAMainInfo with (nolock)
			WHERE  LNAMainInfo.RegistrationNumber like @regNumberText
			
			UNION

			SELECT MemorandumMainInfo.InstanceID as CardID,
				   MemorandumMainInfo.RegistrationNumber as RegistrationNumber
			FROM   [dvtable_{B5D96F96-ACA2-4184-9702-2D89B1B3936A}] MemorandumMainInfo with (nolock)
			WHERE  MemorandumMainInfo.RegistrationNumber like @regNumberText
			
			UNION

			SELECT OrderMainInfo.InstanceID as CardID,
				   OrderMainInfo.RegistrationNumber as RegistrationNumber
			FROM   [dvtable_{F875C7C6-A280-402D-BC56-36DEE6376EED}] OrderMainInfo with (nolock)
			WHERE  OrderMainInfo.RegistrationNumber like @regNumberText

			UNION

			SELECT OutDocMainInfo.InstanceID as CardID,
				   OutDocMainInfo.RegistrationNumber as RegistrationNumber
			FROM   [dvtable_{4C07CA25-41D6-438A-B73E-47FE7650C7BD}] OutDocMainInfo with (nolock)
			WHERE  OutDocMainInfo.RegistrationNumber like @regNumberText

			UNION

			SELECT ProtocolMainInfo.InstanceID as CardID,
				   ProtocolMainInfo.RegistrationNumber as RegistrationNumber
			FROM   [dvtable_{C00F1798-2E00-4493-801A-8A3BC4737FB2}] ProtocolMainInfo with (nolock)
			WHERE  ProtocolMainInfo.RegistrationNumber like @regNumberText
			
			UNION

			SELECT RegisterMainInfo.InstanceID as CardID,
				   RegisterMainInfo.RegistrationNumber as RegistrationNumber
			FROM   [dvtable_{15A8E7D1-F17C-4114-B9BE-466F507A294D}] RegisterMainInfo with (nolock)
			WHERE  RegisterMainInfo.RegistrationNumber like @regNumberText

			UNION

			SELECT WarrantMainInfo.InstanceID as CardID,
				   WarrantMainInfo.RegistrationNumber as RegistrationNumber
			FROM   [dvtable_{EC83F06E-8131-4437-A573-C86B15A2AF5C}] WarrantMainInfo with (nolock)
			WHERE  WarrantMainInfo.RegistrationNumber like @regNumberText
		) data
		inner join [dvsys_instances] instances
		on instances.InstanceID = data.CardID
		inner join  [dvsys_security]
		on instances.SDID = dvsys_security.ID
		where (instances.Deleted is null or instances.Deleted = 0)
				and instances.Template = 0
END


/*
test queries

exec [dvreport_get_data_{ADE20984-EBCB-487E-9234-6DF05037D11E}] '4'

*/