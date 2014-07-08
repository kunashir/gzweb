BEGIN

DECLARE @TempAssignmentIDTable TABLE (TaskID UNIQUEIDENTIFIER, TaskState INT)

	INSERT INTO @TempAssignmentIDTable SELECT DISTINCT task_Performing.InstanceID AS TaskID, task_Performing.TaskState AS TaskState
	FROM   [dbo].[dvtable_{D48E6155-C774-4205-AB70-7A67AB69DF22}] task_Performing WITH (NOLOCK)
		JOIN [dbo].[dvsys_instances] instances WITH (NOLOCK) ON instances.InstanceID = task_Performing.InstanceID
		JOIN [dbo].[dvtable_{9D09144D-CAEC-4732-AD4D-EB6A3864714A}] task_Performers WITH (NOLOCK) ON task_Performers.InstanceID = task_Performing.InstanceID AND task_Performers.PerformerID = @employeeID
	WHERE  task_Performing.TaskState in (2, 3, 4) AND ISNULL(instances.[Deleted], 0) = 0

	DECLARE @TempDocIDTable TABLE (CardID UNIQUEIDENTIFIER, Description NVARCHAR(MAX))
	INSERT INTO @TempDocIDTable EXEC [dvreport_get_data_{D9C6DCC4-D67E-428C-9109-52B5828E458A}] @Barcode

	SELECT DISTINCT kid.TaskID, TaskState FROM [dbo].[dvtable_{eca843ef-2810-4795-a81a-b047f76250ec}] cardRefs
	INNER JOIN @TempDocIDTable id ON cardRefs.RefID = id.CardID
	INNER JOIN @TempAssignmentIDTable kid ON kid.TaskID = cardRefs.InstanceID

END