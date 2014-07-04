BEGIN
SELECT 
states.InstanceID,
states.StateIndex,
states.StateHistoryDate
FROM [dvtable_{85395389-EF9B-41BE-8154-5B1D128A591F}] as states,
dvsys_instances as instances
WHERE
instances.InstanceID = states.InstanceID AND
ISNULL(instances.[Deleted], 0) = 0 AND
states.StateIndex is not null AND
states.StateHistoryDate is not null AND
states.StateIndex in (6, 9, 10, 16)
END
