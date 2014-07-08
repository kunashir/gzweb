BEGIN

	/*выбрать все входящие, у которых завершены все поручения 1ого уровня (считая с нуля)*/
	SELECT DISTINCT IncDocMainInfo.InstanceID as Card, IncDocMainInfo.* 
	FROM   [dvtable_{C06228B9-99F8-4B41-950B-8FACDC00A2B7}] as IncDocMainInfo WITH (nolock),
       	       [dvtable_{AD95E7FB-592C-4CAA-BBDF-25F32F0B2987}] as IncDocResolutions WITH (nolock),
	       [dvtable_{86AF6157-D65A-4F8D-8F92-3DAAD2910A9B}] as AssignmentHistory WITH (nolock)
	WHERE  IncDocMainInfo.State = 3 AND -- On executing
     	       IncDocResolutions.InstanceID = IncDocMainInfo.InstanceID AND
               AssignmentHistory.Decision = 6 AND  -- Completed
     	NOT EXISTS(
		SELECT InstanceID FROM [dvtable_{E3335F61-DBD9-447B-A539-4BF721FFD7B0}] as AssignmentMainInfo
		WHERE InstanceID IN
		(
			-- Поручения 1-го уровня
			SELECT DISTINCT WFTaskChildrenResolution.ResolutionID from 
				[dvtable_{86AF6157-D65A-4F8D-8F92-3DAAD2910A9B}] as AssignmentHistory
				inner join [dvtable_{BBAA81AA-999D-461B-9B74-2A60A0965555}] WFTaskChildrenResolution
				ON WFTaskChildrenResolution.InstanceID = AssignmentHistory.TaskID
				WHERE AssignmentHistory.InstanceID in
			(
				-- Поручения по ВД
				SELECT DISTINCT  AssignmentMainInfo.InstanceID 
				FROM [dvtable_{E3335F61-DBD9-447B-A539-4BF721FFD7B0}] as AssignmentMainInfo
				WHERE (AssignmentMainInfo._ParentCard = IncDocMainInfo.InstanceID and ParentTaskID is null)
			)
		) and State not in (3, 7)
)
FOR BROWSE
   
END
