module IFP
	class DirectiveAssignment < ActiveRecord::Base
		self.table_name = "dvtable_{7F553F11-6E51-4430-B868-29571EBC9813}"
		self.primary_key = "RowID"

		has_many :assignees, class_name: 'IFP::DirectiveAssignmentAssignee', primary_key: 'RowID', foreign_key: 'ParentRowID'
	end	
end