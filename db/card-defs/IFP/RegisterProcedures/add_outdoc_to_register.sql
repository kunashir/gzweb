BEGIN
	if (not exists 
			(select 1 from [dvtable_{F896B5AC-D438-48CB-AE74-95C3F880483C}] as DocumentsToSend
			where DocumentsToSend.Recipient = @recipientID)
		and exists 
			(select 1 from dvsys_instances where InstanceID = @targetRegister))
	begin
		insert into [dvtable_{F896B5AC-D438-48CB-AE74-95C3F880483C}]
		(RowID, InstanceID, ParentOutDoc, Recipient, RegNumber)
		values (NEWID(), @targetRegister, @parentOutDoc, @recipientID, @regNumber)
		select 1 as Result;
	end
	else
		select 0 as Result;

END