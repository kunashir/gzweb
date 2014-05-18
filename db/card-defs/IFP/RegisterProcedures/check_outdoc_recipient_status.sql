BEGIN
/* 

Returns:
0 - Recipient is free
1 - Recipient is belong to any register
2 - Recipient is belong to specified register only
3 - Recipient is belong not only to the specified register

*/
	if not exists (select 1 from [dvtable_{F896B5AC-D438-48CB-AE74-95C3F880483C}] RegisterDocumentsToSend 
			where Recipient = @outDocRecipientRowID)
	begin
		select 0 as Result;
		return;
	end

	if (@considerRegisterID = 1)
	begin
		if exists (select 1 from [dvtable_{F896B5AC-D438-48CB-AE74-95C3F880483C}] RegisterDocumentsToSend 
			where Recipient = @outDocRecipientRowID and InstanceID != @registerID)
		begin
			select 3 as Result
			return
		end
		else
		begin
			select 2 as Result
			return
		end
	end
	else
	begin
		select 1 as Result
		return
	end
END

/*

Test queries

*/