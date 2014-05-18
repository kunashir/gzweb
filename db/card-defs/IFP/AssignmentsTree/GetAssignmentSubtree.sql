if not object_id('[dbo].[GetAssignmentSubtree]') is null
	drop function [dbo].[GetAssignmentSubtree]
go

create function [dbo].[GetAssignmentSubtree]
(@rootAssignmentID uniqueidentifier)
returns @subtree table
(
	AssignmentID uniqueidentifier,
	ParentAssignmentID uniqueidentifier
)
as
begin
	with AssignmentTree (AssignmentID, ParentAssignmentID)
	as
	(
		select @rootAssignmentID, null--Текущая вершина

		union all

		select WFTaskChildrenResolution.ResolutionID, @rootAssignmentID from 
		[dvtable_{86AF6157-D65A-4F8D-8F92-3DAAD2910A9B}] as AssignmentHistory
		inner join [dvtable_{BBAA81AA-999D-461B-9B74-2A60A0965555}] WFTaskChildrenResolution
		on WFTaskChildrenResolution.InstanceID = AssignmentHistory.TaskID
		where AssignmentHistory.InstanceID = @rootAssignmentID
		
		union all 
		
		select WFTaskChildrenResolution.ResolutionID, AssignmentHistory.InstanceID from 
		[dvtable_{86AF6157-D65A-4F8D-8F92-3DAAD2910A9B}] as AssignmentHistory
		inner join [dvtable_{BBAA81AA-999D-461B-9B74-2A60A0965555}] WFTaskChildrenResolution
		on WFTaskChildrenResolution.InstanceID = AssignmentHistory.TaskID
		inner join AssignmentTree
		on AssignmentTree.AssignmentID = AssignmentHistory.InstanceID

		union all
		-- insert linked assignments as children if current assignment was reassigned
		SELECT LinkedAssignment.Assignment,
		(CASE WHEN AssignmentID is null THEN @rootAssignmentID ELSE AssignmentID END) as Parent 
		FROM AssignmentTree, 
		[dvtable_{E3335F61-DBD9-447B-A539-4BF721FFD7B0}] as MainInfo,
		[dvtable_{851B69BD-3F36-4BD9-A5F7-9B80FFEA0791}] as LinkedAssignment
		WHERE
		AssignmentID = MainInfo.InstanceID AND LinkedAssignment.InstanceID = MainInfo.InstanceID AND 
		State = 4 /*recalled*/ 
	)

	insert into @subtree
	select @rootAssignmentID, null /* adding root node */
	union
	select distinct AssignmentID, ParentAssignmentID from AssignmentTree /* adding child nodes */

	return
end
/*
declare @rootAssignmentID uniqueidentifier
set @rootAssignmentID = '{97DBF8BD-97F4-4867-AB6D-5587A8B721D2}';
select * from [dbo].[GetAssignmentSubtree](@rootAssignmentID)
*/