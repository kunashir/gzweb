BEGIN

	SELECT DISTINCT links.SourceCardID as CardID,
           refs.InstanceID as RefsID,
		   refs.RowID as RowID,		   instances.[Description] as Description
	FROM   [dbo].[dvtable_{F34ADE10-7932-4767-BD03-67F164A45DE5}] refs,
		   [dbo].[dvsys_links] links,
		   [dbo].[dvsys_fielddefs] fielddefs,
           [dbo].[dvsys_instances] instances
	WHERE  refs.Link = @cardID
		   AND links.DestinationCardID = refs.InstanceID
		   AND fielddefs.FieldID = links.FieldID
           AND instances.InstanceID = links.SourceCardID
           AND instances.CardTypeID <> '{F7E2090A-EEC3-4B51-B1BB-567D4A0117D6}'
           AND (instances.CardTypeID <> '{FFF11133-DFC4-4CD6-A2D4-BD242E2A4670}' OR refs.ShowMode = 2 /* ShowIncoming */)
	FOR BROWSE
END