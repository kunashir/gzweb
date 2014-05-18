BEGIN

declare @managers table(ManagerID uniqueidentifier)
insert into @managers
select CONVERT(uniqueidentifier, Manager.Items) from [dbo].[idocfn_split_string](@managersString,';') as Manager
where Manager.Items is not null


DECLARE @result TABLE
(
TransferLogID uniqueidentifier,
CardID uniqueidentifier,
CardTypeID uniqueidentifier,
RegistrationNumber nvarchar(256), 
RegistrationDate datetime,
Content nvarchar(max), 
TransferDate datetime, 
FromEmployee uniqueidentifier,
Approved bit,
ApprovingDate datetime,
CurrentOwner uniqueidentifier,
OwnerName nvarchar(256),
CurrentOwnerDepartmentName nvarchar(256)
)
		INSERT INTO @result
		SELECT 
		TransferLog.InstanceID,
		TransferMainInfo.ParentCard,
		[dbo].[GetCardTypeByID](TransferMainInfo.ParentCard),
		[dbo].[GetDocumentRegNumb](TransferMainInfo.ParentCard),
		[dbo].[GetDocumentRegDate](TransferMainInfo.ParentCard),
		[dbo].[GetDocumentContent](TransferMainInfo.ParentCard),
		TransferLog.TransferDate,
		TransferLog.FromEmployee,
		0,
		null,
		(SELECT TOP(1) translog.ToEmployee
		 FROM [dvtable_{49834B18-D90D-4E87-8118-735A5AB1E998}] as translog,
		 [dvtable_{5ECEE53E-4533-43BD-829D-EAEB069D0D28}] as maininfo
		 WHERE maininfo.InstanceID = translog.InstanceID AND 
	     maininfo.ParentCard = TransferMainInfo.ParentCard AND translog.State = 2
		 ORDER BY translog.TransferDate DESC) as CurrentOwner, 
		null,
		null
		FROM 
		[dvtable_{49834B18-D90D-4E87-8118-735A5AB1E998}] as TransferLog,
		[dvtable_{5ECEE53E-4533-43BD-829D-EAEB069D0D28}] as TransferMainInfo,
		dvsys_instances, dvsys_security--, @managers as Managers
		WHERE
		TransferLog.InstanceID = TransferMainInfo.InstanceID AND
		dvsys_instances.InstanceID = TransferMainInfo.InstanceID AND
		dvsys_instances.SDID = dvsys_security.ID AND
		TransferMainInfo.ParentCard is not null AND
		TransferLog.ToEmployee is not null AND
		TransferLog.FromEmployee is not null AND
        TransferLog.FromEmployee = @secretary AND EXISTS(SELECT * FROM @managers as Manager WHERE  TransferLog.ToEmployee = Manager.ManagerID) AND
		TransferLog.State = 2


 UPDATE @result
 set 
 OwnerName = [dbo].[GetEmployeeDisplayStringByID](CurrentOwner),
 CurrentOwnerDepartmentName = [dbo].[GetEmployeeDepartment](CurrentOwner)

 UPDATE @result
 set Approved = 1
 WHERE (EXISTS(
	SELECT * FROM @managers as Manager,
	[dvtable_{49834B18-D90D-4E87-8118-735A5AB1E998}] as TransferLog
	WHERE TransferLog.FromEmployee = Manager.ManagerID AND 
	TransferLog.State = 2 AND 
	TransferLog.InstanceID = TransferLogID))

 
UPDATE @result
set ApprovingDate = (SELECT TOP(1) TransferLog.TransferDate 
                     FROM @managers as Manager,
					[dvtable_{49834B18-D90D-4E87-8118-735A5AB1E998}] as TransferLog
					WHERE TransferLog.FromEmployee = Manager.ManagerID AND 
					TransferLog.State = 2 AND 
					TransferLog.InstanceID = TransferLogID
					 ORDER BY TransferLog.TransferDate DESC)
WHERE Approved = 1

IF @onManagerApproving = 1
	BEGIN
		DELETE Result From @result as Result
        WHERE Approved = 1
	END


SELECT * FROM @result WHERE TransferDate >= @transferStart AND TransferDate <= DATEADD(minute, 1, @transferEnd)

END
