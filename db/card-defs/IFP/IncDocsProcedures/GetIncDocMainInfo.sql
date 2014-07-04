BEGIN


DECLARE @docs TABLE
(
InstanceID uniqueidentifier,
State int,
ControlState int,
RegistrationNumber nvarchar(MAX),
RegistrationDate datetime,
SignedBy uniqueidentifier,
Recipients nvarchar(MAX),
SenderOrg nvarchar(MAX),
SenderOrgID uniqueidentifier,
Subject nvarchar(MAX),
RemovalFromControlDate datetime,
Term datetime	
)

INSERT INTO @docs
SELECT 
mainInfo.InstanceID,
mainInfo.State,
mainInfo.ControlState,
mainInfo.RegistrationNumber,
mainInfo.RegistrationDate,
mainInfo.SignedBy, 
[dbo].[GetIncDocRecipients](mainInfo.InstanceID) as Recipients,
counteragents.Name as SenderOrg, 
counteragents.RowID as SenderOrgID,
mainInfo.Subject,
mainInfo.RemovalFromControl,
mainInfo.Term
FROM [dvtable_{C06228B9-99F8-4B41-950B-8FACDC00A2B7}] as mainInfo,
[dvtable_{1A46BF0F-2D02-4AC9-8866-5ADF245921E8}] as counteragentEmployees,
[dvtable_{C78ABDED-DB1C-4217-AE0D-51A400546923}] as counteragents,
dvsys_Instances
WHERE
dvsys_Instances.InstanceID = mainInfo.InstanceID AND
(dvsys_Instances.Deleted is NULL or dvsys_Instances.Deleted <> 1) AND
mainInfo.SignedBy = counteragentEmployees.RowID AND  
counteragentEmployees.ParentRowID = counteragents.RowID AND
mainInfo.RegistrationDate >= @regBeginDate AND
mainInfo.RegistrationDate <= @regEndDate



-- Filter
	IF @signedByID <> '00000000-0000-0000-0000-000000000000' AND @signedByID is not null
	BEGIN
		DELETE FROM @docs WHERE 
		SignedBy is null or SignedBy <> @signedByID
    END

	IF @senderOrgID <> '00000000-0000-0000-0000-000000000000' AND @senderOrgID is not null
	BEGIN
		DELETE FROM @docs WHERE 
		SenderOrgID is null or SenderOrgID <> @senderOrgID
    END

	IF @state <> -1 AND @state is not null
	BEGIN
		DELETE FROM @docs WHERE 
		State is null or State <> @state
	END

	IF @controlState <> -1 AND @controlState is not null
	BEGIN
		DELETE FROM @docs WHERE
		ControlState is null or ControlState <> @controlState
	END

	IF @overdue is not null and @overdue = 1
	BEGIN
		DELETE FROM @docs WHERE
		Term is null 
        OR (RemovalFromControlDate is null AND Term >= GETDATE()) 
        OR (RemovalFromControlDate is not null AND RemovalFromControlDate <= Term)
	END

	IF @execDateStart is not null AND @execDateStart > Convert(datetime, '18000101')
	BEGIN
		DELETE FROM @docs WHERE
		Term is null OR Term < @execDateStart
	END

	IF @execDateEnd is not null AND @execDateEnd > Convert(datetime, '18000101')
	BEGIN
		DELETE FROM @docs WHERE
		Term is null OR Term > @execDateEnd
	END

	IF @recipientID <> '00000000-0000-0000-0000-000000000000' AND @recipientID is not null
	BEGIN
		DELETE DOCS FROM @docs AS DOCS WHERE 
		NOT EXISTS(SELECT * FROM [dvtable_{FC138430-DE5D-47D2-BBD6-DA17D4DCF4CD}] as Recipients
				WHERE Recipients.InstanceID = DOCS.InstanceID
                AND Recipients.Recipient = @recipientID)
    END


-- output result
SELECT * FROM @docs

END