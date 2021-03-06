BEGIN
	DECLARE @assignmentID as uniqueidentifier

	CREATE TABLE #temp(BPID uniqueidentifier, BPName nvarchar(1024), IsStarter int)

	DECLARE assignments Cursor FOR 
      SELECT wf_res.ResolutionID
      FROM   [dbo].[dvtable_{BBAA81AA-999D-461B-9B74-2A60A0965555}] wf_res WITH (nolock),
             [dbo].[dvtable_{E3335F61-DBD9-447B-A539-4BF721FFD7B0}] assignment_maininfo WITH (nolock)
      WHERE  wf_res.InstanceID = @taskID
             AND assignment_maininfo.InstanceID = wf_res.ResolutionID
             AND ((assignment_maininfo.ForAcquaintance = 0) OR (assignment_maininfo.ForAcquaintance is NULL))

  OPEN assignments
    FETCH NEXT FROM assignments INTO @assignmentID 
    WHILE @@fetch_status = 0
    BEGIN
		INSERT #temp
		EXECUTE [dbo].[dvreport_get_data_{2B390ED8-6D62-46bf-B2DA-7C0C2B94A88A}]
			@assignmentID = @assignmentID

	    FETCH NEXT FROM assignments INTO @assignmentID 
    END

	CLOSE assignments
	DEALLOCATE assignments

	SELECT DISTINCT
		BPID,
		BPName,
		IsStarter
	FROM #temp

	DROP TABLE #temp
END