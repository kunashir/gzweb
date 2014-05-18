-- AccountName varchar(64)
BEGIN
	-- populate info abount all security object type
	DECLARE @EmployeeObjectType as int
	DECLARE @DepartmentObjectType as int
	DECLARE @GroupObjectType as int
	DECLARE @RoleObjectType as int
	
	SET @EmployeeObjectType = 0
	SET @DepartmentObjectType = 1
	SET @GroupObjectType = 2
	SET @RoleObjectType = 3
	
	-- declare table and collect data about all employee managers
	DECLARE @UsersTable TABLE
	(
		ID uniqueidentifier NOT NULL,
		ObjectType int NOT NULL,
		AccountSID varchar(256),
		AccountName varchar(64)
	)
	
	-- insert user own data
	INSERT @UsersTable
	(
		ID,
		ObjectType,
		AccountSID,
		AccountName
	)
	SELECT tEmployees.[RowID], @EmployeeObjectType, tEmployees.[AccountSID], @AccountName
	FROM  [dbo].[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] tEmployees WITH(NOLOCK)
	WHERE tEmployees.[AccountName] = @AccountName AND tEmployees.[IsDefault] = 1
	
	-- insert user's managers (at this step the user is only one, so join table)

	-- Issue 29816: check whether the system settings allow to use the managers' access rights
	-- mamager's access rights select behavior
	-- 0 = Deny
	-- 1 = Allow
	-- 2 = Allow with check
	DECLARE @Behaviour as tinyint
	SET @Behaviour = 2 -- by default we allow to use the managers' access rights 
	
	SELECT @Behaviour = 
		CASE
			WHEN tAccessSettings.[Value] = 0 THEN 1
			WHEN tAccessSettings.[Value] = 2 THEN 2
			ELSE 0
		END
	FROM dbo.[dvtable_{C9185C66-5104-45C2-A0A0-18787E69DC50}] tCardsSettings WITH(NOLOCK)
	JOIN dbo.[dvtable_{42BFBCAD-0407-4452-B60D-D1195CE035A1}] tAccessSettings WITH(NOLOCK) ON tAccessSettings.ParentRowID = tCardsSettings.RowID
	WHERE tCardsSettings.[Name] = N'CardsSettings' AND tAccessSettings.[Name] = N'CardsDeputyAccessRights'

	-- if deputy access is none or deputy access is custom, but not enabled
	BEGIN
		INSERT @UsersTable
		(
			ID,
			ObjectType,
			AccountSID,
			AccountName
		)
		SELECT tEmployees.[RowID], @EmployeeObjectType, tEmployees.[AccountSID], tEmployees.[AccountName]
		FROM  [dbo].[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] tEmployees WITH(NOLOCK)
		JOIN [dbo].[dvtable_{ED414CB4-B205-4BE4-A2FA-5C0D3347CEB3}] tDeputes ON tDeputes.[ParentRowID] = tEmployees.[RowID]
		JOIN @UsersTable tUsers ON tUsers.[ID] = tDeputes.[DeputyID]
		WHERE (@Behaviour = 1) OR (@Behaviour = 2 AND tDeputes.[DeputyAccess] = 1)
	END
	
	-- declare the result table to store data about all employee managers
	DECLARE @ResultTable TABLE
	(
		ID uniqueidentifier NOT NULL,
		ObjectType int NOT NULL,
		AccountSID varchar(256) NULL
	)
	
	-- save values to the result table
	INSERT @ResultTable
	(
		ID,
		ObjectType,
		AccountSID
	)
	SELECT ID, ObjectType, AccountSID
	FROM @UsersTable
	
	-- AccounSID is coustom for the Units
	-- collect data about departments containing the employees
	INSERT @ResultTable
	(
		ID,
		ObjectType,
		AccountSID
	)
	SELECT tDepartments.[RowID], @DepartmentObjectType, NULL
	FROM [dbo].[dvtable_{7473F07F-11ED-4762-9F1E-7FF10808DDD1}] tDepartments WITH(NOLOCK)
	JOIN [dbo].[dvtable_{DBC8AE9D-C1D2-4D5E-978B-339D22B32482}] tEmployees WITH(NOLOCK) ON tEmployees.[ParentRowID] = tDepartments.[RowID]
	JOIN @UsersTable tUsers ON tUsers.[ID] = tEmployees.[RowID]
	
	-- collect data about groups containing the employees
	INSERT @ResultTable
	(
		ID,
		ObjectType,
		AccountSID
	)
	SELECT tGroup.[RowID], @GroupObjectType, tGroup.[AccountSID]
	FROM [dbo].[dvtable_{5B607FFC-7EA2-47B1-90D4-BB72A0FE7280}] tGroup WITH(NOLOCK)
	JOIN [dbo].[dvtable_{A960E37B-F1BD-4981-858D-AE9706E0571E}] tGroupMember WITH(NOLOCK) ON tGroupMember.[ParentRowID] = tGroup.[RowID]
	JOIN @UsersTable tUsers ON tUsers.ID = tGroupMember.[EmployeeID]

	-- collect data about roles containing the employess
	INSERT @ResultTable
	(
		ID,
		ObjectType,
		AccountSID
	)
	SELECT tRoles.[RowID], @RoleObjectType, tRoles.[AccountSID]
	FROM  [dbo].[dvtable_{F6927A03-5BCE-4C7E-9C8F-E61C6D9F256E}] tRoles WITH(NOLOCK)
	JOIN @ResultTable tResult ON tResult.[ID] = tResult.[ID]
	JOIN [dbo].[dvtable_{C5F5B33A-5201-414C-87F4-7E0C5E641ADD}] tContains ON tContains.[RefID] = tResult.[ID] AND tContains.ParentRowID = tRoles.RowID
	
	-- the users can be have the membership at the same departments, groups and roles, so select distinct values
	SELECT DISTINCT * FROM @ResultTable
END