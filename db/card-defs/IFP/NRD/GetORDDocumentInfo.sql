BEGIN
	--Find DocId
	declare @realDocID uniqueidentifier
	select TOP(1) @realDocID = NRDConfirmingDocuments.Document from [dvtable_{AF07E3E9-1C40-479B-A998-7511E17F4B95}] as NRDConfirmingDocuments
	where NRDConfirmingDocuments.RowID = @documentID	

	declare @ordCardType uniqueidentifier
	declare @ordDescription nvarchar(512)
	select TOP(1) @ordCardType = [dvsys_instances].CardTypeID, @ordDescription = [dvsys_instances].Description from [dvsys_instances] where [dvsys_instances].InstanceID = @realDocID
	
	IF(@ordCardType = '56070FE0-BFC6-4CF1-8786-482E4DDFE9B6')-- Order
	begin
		SELECT DISTINCT
			@ordDescription as [Description],
			ORDMainInfo.RegistrationDate as [RegistrationDate],
			ORDMainInfo.State as [State],
			1 as [CardType]
		FROM
			[dvtable_{F875C7C6-A280-402D-BC56-36DEE6376EED}] as ORDMainInfo
		where
			ORDMainInfo.InstanceID = @realDocID
			
		FOR BROWSE
	end
	else if(@ordCardType = 'EB0F2CF0-F80B-4132-80D7-03409ABB3E70')--Direction
	begin
		SELECT DISTINCT
			@ordDescription as [Description],
			ORDMainInfo.RegistrationDate as [RegistrationDate],
			ORDMainInfo.State as [State],
			2 as [CardType]
		FROM
			[dvtable_{4130F43C-6DD5-4A5B-971E-AA134F7FB2E5}] as ORDMainInfo
		where
			ORDMainInfo.InstanceID = @realDocID
			
		FOR BROWSE
	end
	else if(@ordCardType = 'F341B47C-70DD-404B-A833-261D3AA550DF')--Directive
	begin
		SELECT DISTINCT
			@ordDescription as [Description],
			ORDMainInfo.RegistrationDate as [RegistrationDate],
			ORDMainInfo.State as [State],
			3 as [CardType]
		FROM
			[dvtable_{086A474C-BDFD-472D-9A35-8EF9E9209A67}] as ORDMainInfo
		where
			ORDMainInfo.InstanceID = @realDocID
			
		FOR BROWSE
	end
	
END