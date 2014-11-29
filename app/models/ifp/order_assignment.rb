module IFP
	class OrderAssignment < ActiveRecord::Base
		self.table_name = "dvtable_{37E44E13-884E-4AC2-8B60-9E4B4FBD48B4}"
		self.primary_key = "RowID"

		has_many :assignees, class_name: 'IFP::OrderAssignmentAssignee', primary_key: 'RowID', foreign_key: 'ParentRowID'
	end	
end