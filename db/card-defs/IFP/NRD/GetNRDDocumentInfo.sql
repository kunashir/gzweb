BEGIN
	--Find DocId
	declare @realDocID uniqueidentifier
	select TOP(1) @realDocID = NRDNRDLinks.NRD from [dvtable_{5F509152-C9C4-4A56-A0EE-4D336E8AEE39}] as NRDNRDLinks
	where NRDNRDLinks.RowID = @documentID	
	
	SELECT DISTINCT
		NRDMainInfo.RowID as [Identifier],
		NRDMainInfo.[Subject] as [Name],
		[dvsys_instances].[Description] as [Description],
		NRDMainInfo.[RegistrationNumber] as[Number],
		(select TOP(1) DocKinds.NRDDocumentKind from [dvtable_{58DD7F37-6042-4CC2-B3C1-6B29F49366BD}] as DocKinds where DocKinds.RowID = NRDMainInfo.DocumentKind) as [DocumentKind]
	FROM
		[dvtable_{9B99D82A-8B4A-429E-A76D-469FDD1F6A86}] as NRDMainInfo
		left join [dvsys_instances] ON NRDMainInfo.[InstanceID] = [dvsys_instances].[InstanceID]
	where
		NRDMainInfo.RowID = @realDocID
		
	FOR BROWSE
	
END