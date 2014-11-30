module IFP
	class DirectiveAssignmentAssignee < ActiveRecord::Base
		self.table_name = "dvtable_{2FF80229-7CCB-4721-BD09-D1E08547E580}"
		self.primary_key = "RowID"

		def assignment
			@assignment ||= load_assignment
		end

		private

		def load_assignment
			return nil if self.AssignmentID.nil?
			instance = Card.find(self.AssignmentID)
			return nil unless instance.CardTypeID == CardType.assignment_id
			return instance.card
		end
	end	
end