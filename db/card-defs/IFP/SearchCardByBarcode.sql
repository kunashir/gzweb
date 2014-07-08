BEGIN
	SELECT DISTINCT
		data.CardID as CardID,
        instances.Description as Description
	FROM
		(
			SELECT AssignmentMainInfo.InstanceID as CardID
			FROM   [dvtable_{E3335F61-DBD9-447B-A539-4BF721FFD7B0}] AssignmentMainInfo
			WHERE  @barcode = RTRIM(LTRIM(AssignmentMainInfo.BarcodeNumber))
			
			UNION ALL

			SELECT ContractMainInfo.InstanceID as CardID
			FROM   [dvtable_{DAA76B4A-98F9-44BA-833C-DD874DB33214}] ContractMainInfo
			WHERE  @barcode = RTRIM(LTRIM(ContractMainInfo.BarcodeNumber))
			
			UNION ALL

			SELECT ContractPlanMainInfo.InstanceID as CardID
			FROM   [dvtable_{797A212A-0291-42D4-8A0D-CBC77069A9FE}] ContractPlanMainInfo
			WHERE  @barcode = RTRIM(LTRIM(ContractPlanMainInfo.BarcodeNumber))

			UNION ALL

			SELECT DirectionMainInfo.InstanceID as CardID
			FROM   [dvtable_{4130F43C-6DD5-4A5B-971E-AA134F7FB2E5}] DirectionMainInfo
			WHERE  @barcode = RTRIM(LTRIM(DirectionMainInfo.BarcodeNumber))
			
			UNION ALL

			SELECT IncDocMainInfo.InstanceID as CardID
			FROM   [dvtable_{C06228B9-99F8-4B41-950B-8FACDC00A2B7}] IncDocMainInfo
			WHERE  @barcode = RTRIM(LTRIM(IncDocMainInfo.BarcodeNumber))
			
			UNION ALL

			SELECT LNAMainInfo.InstanceID as CardID
			FROM   [dvtable_{D766EC2A-EDB4-4153-ADD1-3BB7BCC89D0D}] LNAMainInfo
			WHERE  @barcode = RTRIM(LTRIM(LNAMainInfo.BarcodeNumber))
			
			UNION ALL

			SELECT MemorandumMainInfo.InstanceID as CardID
			FROM   [dvtable_{B5D96F96-ACA2-4184-9702-2D89B1B3936A}] MemorandumMainInfo
			WHERE  @barcode = RTRIM(LTRIM(MemorandumMainInfo.BarcodeNumber))
			
			UNION ALL

			SELECT OrderMainInfo.InstanceID as CardID
			FROM   [dvtable_{F875C7C6-A280-402D-BC56-36DEE6376EED}] OrderMainInfo
			WHERE  @barcode = RTRIM(LTRIM(OrderMainInfo.BarcodeNumber))

			UNION ALL

			SELECT OutDocMainInfo.InstanceID as CardID
			FROM   [dvtable_{4C07CA25-41D6-438A-B73E-47FE7650C7BD}] OutDocMainInfo
			WHERE  @barcode = RTRIM(LTRIM(OutDocMainInfo.BarcodeNumber))

			UNION ALL

			SELECT ProtocolMainInfo.InstanceID as CardID
			FROM   [dvtable_{C00F1798-2E00-4493-801A-8A3BC4737FB2}] ProtocolMainInfo
			WHERE  @barcode = RTRIM(LTRIM(ProtocolMainInfo.BarcodeNumber))
			
			UNION ALL

			SELECT RegisterMainInfo.InstanceID as CardID
			FROM   [dvtable_{15A8E7D1-F17C-4114-B9BE-466F507A294D}] RegisterMainInfo
			WHERE  @barcode = RTRIM(LTRIM(RegisterMainInfo.BarcodeNumber))

			UNION ALL

			SELECT WarrantMainInfo.InstanceID as CardID
			FROM   [dvtable_{EC83F06E-8131-4437-A573-C86B15A2AF5C}] WarrantMainInfo
			WHERE  @barcode = RTRIM(LTRIM(WarrantMainInfo.BarcodeNumber))
		) data,
		[dvsys_instances] instances
	WHERE instances.InstanceID = data.CardID
			and (instances.Deleted is null or instances.Deleted = 0)
			and instances.Template = 0
   
END


/*
test code

exec [dvreport_get_data_{D9C6DCC4-D67E-428c-9109-52B5828E458A}] @barcode = N'45-2 тест'
select * from [dvtable_{D766EC2A-EDB4-4153-ADD1-3BB7BCC89D0D}] LNAMainInfo

*/