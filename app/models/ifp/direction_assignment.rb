module IFP
	class DirectionAssignment < ActiveRecord::Base
		self.table_name = "dvtable_{9C8CB241-40D4-48FD-A7FA-B6E5DF2B97F4}"
		self.primary_key = "RowID"

		has_many :assignees, class_name: 'IFP::DirectionAssignmentAssignee', primary_key: 'RowID', foreign_key: 'ParentRowID'
	end	
end