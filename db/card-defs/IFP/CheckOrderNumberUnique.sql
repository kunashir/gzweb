BEGIN
-- Приказ
IF @isOrder = 0
	BEGIN
		SELECT InstanceID
		FROM [dvtable_{F875C7C6-A280-402D-BC56-36DEE6376EED}] as MainInfo
		WHERE RegistrationDate is not null AND 
		RegistrationNumber is not null AND
		DATEDIFF(year, RegistrationDate, GETDATE()) = 0 AND
		RegistrationNumber = @regNumber 
	END
-- Распоряжение
IF @isOrder = 1
	BEGIN
		SELECT InstanceID
		FROM [dvtable_{4130F43C-6DD5-4A5B-971E-AA134F7FB2E5}] as MainInfo
		WHERE RegistrationDate is not null AND 
		RegistrationNumber is not null AND
		DATEDIFF(year, RegistrationDate, GETDATE()) = 0 AND
		RegistrationNumber = @regNumber 
	END
-- Указание
IF @isOrder = 2
	BEGIN
		SELECT InstanceID
		FROM [dvtable_{086A474C-BDFD-472D-9A35-8EF9E9209A67}] as MainInfo
		WHERE RegistrationDate is not null AND 
		RegistrationNumber is not null AND
		DATEDIFF(year, RegistrationDate, GETDATE()) = 0 AND
		RegistrationNumber = @regNumber 
	END
END