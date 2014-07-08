BEGIN
SELECT * 
FROM [dbo].[idoc_assignments_tree] 
WHERE ParentAssignmentID = @assignment 
ORDER BY CreationDate DESC
END