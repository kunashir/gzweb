/*IF NOT OBJECT_ID('[dbo].[dvreport_get_data_{30D3424A-B8C3-4199-BC28-22AC94975BBE}]') IS NULL
	DROP PROCEDURE [dbo].[dvreport_get_data_{30D3424A-B8C3-4199-BC28-22AC94975BBE}]
GO
CREATE PROCEDURE [dbo].[dvreport_get_data_{30D3424A-B8C3-4199-BC28-22AC94975BBE}]
AS*/
/*BEGIN

	UPDATE
	[dbo].[dvtable_{DAA76B4A-98F9-44BA-833C-DD874DB33214}]
	SET NewDocKind = uniItem.RowID
	FROM   [dbo].[dvtable_{DAA76B4A-98F9-44BA-833C-DD874DB33214}] contractMainInfo,
		   [dbo].[dvtable_{DBED195F-6235-4404-B7B2-D86148DC1180}] contractSetup,
		   [dbo].[dvtable_{DD20BF9B-90F8-4D9A-9553-5B5F17AD724E}] uniItem,
		   [dbo].[dvtable_{75CFFADE-7D24-4DFE-ACE7-4C7A812BEF1E}] uniTypeProp1
		   --[dbo].[dvtable_{85D15F7A-DDEE-4484-9B41-57D09E0B1A9A}] uniItemProp1
	WHERE  contractMainInfo.DocKind is NULL
		   AND uniItem.ParentRowID = contractSetup.ContractDocKindRef
		   AND uniTypeProp1.ParentRowID = contractSetup.ContractDocKindRef
		   AND uniTypeProp1.[Name] = 'Старое значение (Enum)'
		   AND uniItemProp1.ParentRowID = uniItem.RowID
		   AND uniItemProp1.[Property] = uniTypeProp1.RowID
		   --AND contractMainInfo.DocKind = uniItemProp1.[Value]

	SELECT DISTINCT 1 as Ok
    FOR BROWSE

END*/